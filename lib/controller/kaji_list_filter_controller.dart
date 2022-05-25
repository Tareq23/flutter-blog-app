

import 'package:blog_app/Model/DistrictModel.dart';
import 'package:blog_app/Model/division_model.dart';
import 'package:blog_app/Model/sub_district_model.dart';
import 'package:blog_app/Model/union_model.dart';
import 'package:blog_app/Services/app_service.dart';
import 'package:get/get.dart';

class KajiListFilterController extends GetxController
{
  var divisionList = <DivisionModel>[].obs;
  var selectDivision = DivisionModel(0, "Select Division", "Select Division").obs;

  var districtList = <DistrictModel>[].obs;
  var selectDistrict = DistrictModel(0, "Select District", "Select District").obs;

  var selectSubDistrict = SubDistrictModel(0, "Select upazila", "Select upazila").obs;
  var subDistrictList = <SubDistrictModel>[].obs;

  var selectUnion = UnionModel(0, "Select Union", "Select Union").obs;
  var unionList = <UnionModel>[].obs;

  @override
  void onInit() {
    divisionList.add(selectDivision.value);
    fetchDivision();
    super.onInit();
  }

  void fetchDivision() async {
    if(divisionList.length <2){
      var list = await AppService.fetchDivision();
      divisionList.addAll(list);
    }
  }

  void fetchDistrict() async {
    if(districtList.isEmpty){
      districtList.add(selectDistrict.value);
    }
    if(selectDivision.value.id !=0){
      var list = await AppService.fetchDistrict(selectDivision.value.id!);
      // selectDistrict.value = list[0];

      districtList.addAll(list);
    }
    else{
      districtList.assignAll([]);
      districtList.add(selectDistrict.value);
    }
  }


  void fetchSubDistrict() async {
    if(subDistrictList.isEmpty){
      subDistrictList.add(selectSubDistrict.value);
    }
    if(selectDistrict.value.id !=0){
      var list = await AppService.fetchSubDistrict(selectDistrict.value.id!);
      // selectSubDistrict.value = list[0];
      subDistrictList.addAll(list);
    }
    else{
      subDistrictList.assignAll([]);
      subDistrictList.add(selectSubDistrict.value);
    }
  }

  void fetchUnion() async {
    if(unionList.isEmpty){
      unionList.add(selectUnion.value);
    }
    if(selectSubDistrict.value.id != 0){
        var list = await AppService.fetchUnion(selectSubDistrict.value.id!);

        unionList.addAll(list);
    }
    else{
      unionList.assignAll([]);
      unionList.add(selectUnion.value);
    }
  }


}