// import 'package:flutter_architecture/models/responses/general_cms_response.dart';
// import 'package:flutter_architecture/networking/api_provider.dart';
// import 'package:flutter_architecture/networking/network_constant.dart';
// import 'package:flutter_architecture/provider/api_provider.dart';

// class CmsRepository {
//   ApiProvider _apiProvider = ApiProvider();

//   Future<GeneralCmsResponse> getCmsPages(Map parameter) async {
//     final response = await _apiProvider.postBeforeAuth(
//         parameter, NetworkConstant.END_POINT_GET_CMS_PAGE);
//     return GeneralCmsResponse.fromJson(response);
//   }

//   Future<GeneralCmsResponse> getCmsPagesAfterAuth(Map parameter) async {
//     final response = await _apiProvider.postAfterAuth(
//         parameter, NetworkConstant.END_POINT_GET_CMS_PAGE);
//     return GeneralCmsResponse.fromJson(response);
//   }

//   Future<GeneralCmsResponse> getHelpDesk(Map parameter) async {
//     final response = await _apiProvider.postAfterAuth(
//         parameter, NetworkConstant.END_POINT_CONTACT_REQUEST);
//     return GeneralCmsResponse.fromJson(response);
//   }

//   Future<GeneralCmsResponse> getLogoutCall(Map parameter) async {
//     final response = await _apiProvider.postAfterAuth(
//         parameter, NetworkConstant.END_POINT_LOGOUT);
//     return GeneralCmsResponse.fromJson(response);
//   }

//   Future<GeneralCmsResponse> getSwitchPushNotifications(Map parameter) async {
//     final response = await _apiProvider.postAfterAuth(
//         parameter, NetworkConstant.END_POINT_UPDATE_PUSH_NOTIFICATIONS);
//     return GeneralCmsResponse.fromJson(response);
//   }
// }
