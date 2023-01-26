import 'dart:async';

import 'package:flutter_architecture/repository/home_repository.dart';

class HomeDataBloc {
  late HomeRepository homeRepository;

  late StreamController<dynamic> _streamController;
  late StreamController<dynamic> getAstrologgersListController;
  late StreamController<dynamic> getAstrologgersProfile;
  late StreamController<dynamic> ratingController;
  late StreamController<dynamic> wishlistController;
  HomeDataBloc() {
    _streamController = StreamController<dynamic>();
    getAstrologgersListController = StreamController<dynamic>();
    getAstrologgersProfile = StreamController<dynamic>();
    ratingController = StreamController<dynamic>();
    wishlistController = StreamController<dynamic>();
    homeRepository = HomeRepository();
  }

  StreamSink<dynamic> get sliderListDataSink => _streamController.sink;

  Stream<dynamic> get sliderListDataStream => _streamController.stream;

  StreamSink<dynamic> get getAstrologgersDataSink =>
      getAstrologgersListController.sink;

  Stream<dynamic> get getAstrologgersDataStream =>
      getAstrologgersListController.stream;

  StreamSink<dynamic> get getAstrologgersProfileDataSink =>
      getAstrologgersProfile.sink;

  Stream<dynamic> get getAstrologgersProfileDataStream =>
      getAstrologgersProfile.stream;

  StreamSink<dynamic> get ratingDataSink => ratingController.sink;

  Stream<dynamic> get ratingDataStream => ratingController.stream;

  StreamSink<dynamic> get wishlistDataSink => wishlistController.sink;

  Stream<dynamic> get wishlistDataStream => wishlistController.stream;

//   callGetSlidersList() async {
//     try {
//       final response = await homeRepository.getSlidersList();

//       sliderListDataSink.add(response);
//     } catch (e) {
//       sliderListDataSink.add(NetworkConstant.ERROR);
//     }
//   }

//  callGetAstrologgers() async {
//     try {
//       final response = await homeRepository.getAstrologgersList();

//       getAstrologgersDataSink.add(response);
//     } catch (e) {
//       getAstrologgersDataSink.add(NetworkConstant.ERROR);
//     }
//   }

// callGetAstrologgersProfile(Map data) async {
//     try {
//       final response = await homeRepository.getAstrologgersProfile(data);

//       getAstrologgersProfileDataSink.add(response);
//     } catch (e) {
//       getAstrologgersProfileDataSink.add(NetworkConstant.ERROR);
//     }
//   }

// callRating(Map data) async {
//     try {
//       final response = await homeRepository.rating(data);

//       ratingDataSink.add(response);
//     } catch (e) {
//       ratingDataSink.add(NetworkConstant.ERROR);
//     }
//   }

// callAddWishlist(Map data) async {
//     try {
//       final response = await homeRepository.addWishlist(data);

//       wishlistDataSink.add(response);
//     } catch (e) {
//       wishlistDataSink.add(NetworkConstant.ERROR);
//     }
//   }

  dispose() {
    _streamController.close();
  }
}
