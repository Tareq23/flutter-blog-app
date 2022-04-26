class ApiUrl{

  // ignore: constant_identifier_names
  static const MRDC_API ="https://api.nationalmrdc.com/";
  // ignore: constant_identifier_names
  static const CATEGORY = "https://api.nationalmrdc.com/api/get-desired-job";
  // ignore: constant_identifier_names
  static const BLOG_POST = "https://api.nationalmrdc.com/api/frontend/posts";
  // static const USER_BLOG_POST = "https://api.nationalmrdc.com/api/post/5?limit=4&page=1&title=";
  static const USER_BLOG_POST = "https://api.nationalmrdc.com/api/post/list/5";
  // ApiUrl.MRDC_API + 'api/post/'+id;
  static String UPDATE_POST = "https://api.nationalmrdc.com/api/post/";
  static const CREATE_POST = "https://api.nationalmrdc.com/api/post";
  // String url = ApiUrl.MRDC_API + 'api/post/list/5?limit=4&page=1&title=';
  // static const MY_BLOG_POST = "https://api.nationalmrdc.com/api/post/list/5";
  static String DELETE_POST = "https://api.nationalmrdc.com/api/post/delete/";
  static String USER_PROFILE = "https://api.nationalmrdc.com/api/contacts/show/";
  static String KAJI_PROFILE = "https://api.nationalmrdc.com/api/frontend/users";
  static const USER_PROFILE_UPDATE = "http://api.nationalmrdc.com/contacts/basic-info";
  static const USER_MESSAGE_SEND = "https://api.nationalmrdc.com/api/communication/messaging";
  static const USER_MESSAGE_GET = "https://api.nationalmrdc.com/api/communication/topic/list";
}