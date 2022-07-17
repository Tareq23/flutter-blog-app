import 'package:blog_app/Services/color.dart';
import 'package:blog_app/controller/kaji_list_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class NetworkNotConnect extends StatelessWidget {
  final String page;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  KajiListFilterController? filterController;
  NetworkNotConnect({Key? key, required this.page,required this.controller,this.filterController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              width: size.width,
              height: size.height * 0.4,
              decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
              child: const Icon(
                Icons.cloud_off_outlined,
                size: 250,
                color: Color(0xFF4C4C4C),
              ),
            ),
            const Text('Check your Internet Connection!'),
            SizedBox(
                height: size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.circle,
                      size: 17,
                      color: ConstValue.dotIconColor,
                    ),
                    Icon(
                      Icons.circle,
                      size: 13,
                      color:  ConstValue.dotIconColor,
                    ),
                    Icon(
                      Icons.circle,
                      size: 12,
                      color:  ConstValue.dotIconColor,
                    ),
                    Icon(
                      Icons.circle,
                      size: 10,
                      color:  ConstValue.dotIconColor,
                    ),
                    Icon(
                      Icons.circle,
                      size: 7,
                      color:  ConstValue.dotIconColor,
                    ),
                  ],
                )),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: InkWell(
                onTap: () async {
                  if(page == "userPost"){
                    controller.isUserPostLoading.value = true;
                    controller.fetchUserPosts();
                  }
                  else if(page == "allPost"){
                    controller.isAllPostLoading.value = true;
                    controller.fetchPosts();
                  }
                  else if(page == "kajiList"){
                    filterController?.isLoadingDivision.value = true;
                    filterController?.fetchDivision();
                    controller.isLoadKajiList.value = true;
                    controller.fetchKajiList({"list":0});
                  }
                  else if(page == "assistantList"){
                    controller.isLoading.value = true;
                    controller.fetchAssistant();
                  }
                  else if(page == "message"){
                    controller.isLoadingMessage.value = true;
                    controller.fetchMessages();
                  }
                  else if(page == "about"){
                    controller.isLoading.value = true;
                    controller.fetchAboutData();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: const BoxDecoration(color: Color(0xDC2973E2)),
                  child: const Text(
                    'Refresh',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  }
}


class EmptyListData extends StatelessWidget {
  final String page;
  // ignore: prefer_typing_uninitialized_variables
  final  controller;
  const EmptyListData({Key? key, required this.page,required this.controller}) : super(key: key);
  // final PostController _postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      width: screenSize.width,
      height: screenSize.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('কোন তথ্য পাওয়া যায় নি।',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Color(
              0xFF050317)),),
          SizedBox(
            height: screenSize.height * 0.3,
          ),
          OutlinedButton(
            onPressed: (){
              if(page == "userPost"){
                //_postController.isUserPostLoading.value = true;
                // _postController.fetchUserPosts();
                controller.isUserPostLoading.value = true;
                controller.fetchUserPosts();
              }
              else if(page == "allPost"){
                controller.isAllPostLoading.value = true;
                controller.fetchPosts();
              }
              else if(page == "kajiList"){
                controller.isLoadKajiList.value = true;
                controller.fetchKajiList({});
              }
              else if(page == "assistantList"){
                controller.isLoading.value = true;
                controller.fetchAssistant();
              }
              else if(page == "message"){
                controller.isLoadingMessage.value = true;
                controller.fetchMessages();
              }
              else if(page == "about"){
                controller.isLoading.value = true;
                controller.fetchAboutData();
              }
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: ConstValue.color,
              primary: ConstValue.whileColor,
            ),
            child: const Text('Reload',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,),),
          )
        ],
      ),
    );
  }
}


class VideoPlayerFromUrl extends StatefulWidget {

  String url;

  VideoPlayerFromUrl({Key? key,required this.url}) : super(key: key);

  @override
  _VideoPlayerFromUrlState createState() => _VideoPlayerFromUrlState();
}

class _VideoPlayerFromUrlState extends State<VideoPlayerFromUrl> {


  late YoutubePlayerController youtubePlayerController;

  @override
  void initState() {

    List<String> splitUrl = widget.url.split("v=");

    youtubePlayerController = YoutubePlayerController(
        initialVideoId: splitUrl[splitUrl.length-1].toString(),
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          startAt: 0,
        )

    );

  }

  @override
  void dispose() {
    youtubePlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),

      child: YoutubePlayer(
        controller: youtubePlayerController,
        showVideoProgressIndicator: true,
      ),
    );
  }
}


class LoadBlogPostAnimation extends StatelessWidget {
  const LoadBlogPostAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: 5,
      itemBuilder: (context,index){
        return LoadBlogPostAnimationItemBuild(id: index,);
      },
    );
  }
}

class LoadBlogPostAnimationItemBuild extends StatelessWidget {

  final int id;
  LoadBlogPostAnimationItemBuild({required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.only(top: id==1 ? 25 : 10,left: 10,right: 10, bottom: id==4 ? 20 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: ShimmerWidget.rectangular(height: (MediaQuery.of(context).size.height * 0.2))),
          const SizedBox(width: 20,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerWidget.rectangular(height: (MediaQuery.of(context).size.height * 0.2) * 0.6),
                SizedBox(height: (MediaQuery.of(context).size.height * 0.2) * 0.15,),
                ShimmerWidget.rectangular(height: (MediaQuery.of(context).size.height * 0.2) * 0.25,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  ShimmerWidget.rectangular({
    this.width = double.infinity,
    required this.height,
  }) : this.shapeBorder = const RoundedRectangleBorder();


  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        width: width,
        height: height,
        color: Colors.grey[400]!,
      ),
    );
  }
}




