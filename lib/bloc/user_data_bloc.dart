import 'dart:async';

import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/repository/user_repository.dart';

class UserDataBloc {
  late UserRepository userRepository;
  late StreamController<dynamic> _streamController;

  UserDataBloc() {
    _streamController = StreamController<dynamic>();

    userRepository = UserRepository();
  }

  StreamSink<dynamic> get userDataSink => _streamController.sink;

  Stream<dynamic> get userDataStream => _streamController.stream;

  callGetUserProfileApi(Map parameter) async {
    try {
      final response = await userRepository.getUserDetailApi(parameter);

      userDataSink.add(response);
    } catch (e) {
      userDataSink.add(NetworkConstant.ERROR);
    }
  }

  dispose() {
    _streamController.close();
  }
}
