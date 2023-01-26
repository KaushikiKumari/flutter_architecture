// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use, unused_local_variable, equal_keys_in_map

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/bloc/auth_data_bloc.dart';
import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/pages/dashboard/home.dart';
import 'package:flutter_architecture/shared_preference/shared_pref_constant.dart';
import 'package:flutter_architecture/utilities/app_colors.dart';
import 'package:flutter_architecture/utilities/app_strings.dart';
import 'package:flutter_architecture/utilities/constant_strings.dart';
import 'package:flutter_architecture/utilities/string_styles.dart';
import 'package:flutter_architecture/widgets/loader.dart';
import 'package:flutter_architecture/widgets/toast.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController timeOfBirthController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  FocusNode focusNode = FocusNode();
  late AuthDataBloc authDataBloc;

  /// Variables
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  String dropdownValue = 'Male';
  var items = [
    'Male',
    'Female',
    'Others',
  ];
  var cityList = [
    'city1',
    'city2',
    'city3',
  ];
  var stateList = [
    'state1',
    'state2',
    'state3',
  ];
  @override
  void initState() {
    super.initState();
    authDataBloc = AuthDataBloc();
    timeOfBirthController.text = ""; //set the initial value of text field
    birthDateController.text = ""; //set the initial value of text field
    genderController.text = ""; //set the initial value of text field
    authDataBloc.registerStream.listen((event) async {
      Get.back();
      if (event != NetworkConstant.ERROR) {
        SharedPreferences box = await SharedPreferences.getInstance();
        showSuccessToast('Registration Successfully done');
        Get.offAll(const Home());
      } else {
        showErrorToast('Login Faild.\nPlease Try Again!');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    timeOfBirthController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    cityController.dispose();
    stateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.signUp,
          style: textStyle(
              size: ConstantStrings.font_large,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Stack(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: image == null || image == ""
                    ? const CircleAvatar(
                        backgroundColor: AppColors.greyColor,
                      )
                    : Image.file(
                        image!,
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
              ),
              Positioned(
                bottom: 15,
                right: 0,
                child: InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primaryColor,
                    child: Center(
                        child: image == null || image == ""
                            ? const Icon(
                                Icons.camera_alt,
                                color: AppColors.whiteColor,
                                size: 25,
                              )
                            : const Icon(
                                Icons.edit,
                                color: AppColors.whiteColor,
                                size: 25,
                              )),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
            child: SizedBox(
              height: 50,
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: firstNameController,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white, //this has no effect
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Full Name",
                    prefixIcon: const Icon(Icons.person,
                        color: AppColors.primaryColor)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 15, right: 30),
            child: SizedBox(
              height: 50,
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: lastNameController,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white, //this has no effect
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Last Name",
                    prefixIcon: const Icon(Icons.person,
                        color: AppColors.primaryColor)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 15, right: 30),
            child: SizedBox(
              height: 50,
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: timeOfBirthController,
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red, //this has no effect
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Time Of Birth",
                    suffixIcon: const Icon(Icons.calendar_month,
                        color: AppColors.primaryColor)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 15, right: 30),
            child: SizedBox(
              height: 50,
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: birthDateController,
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.red //this has no effect
                          ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Date Of Birth",
                    suffixIcon: const Icon(Icons.calendar_month,
                        color: AppColors.primaryColor)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 15, right: 30),
            child: SizedBox(
              height: 50,
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: genderController,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red, //this has no effect
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Gender",
                    prefixIcon: const Icon(Icons.accessibility,
                        color: AppColors.primaryColor)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 15, right: 30),
            child: SizedBox(
              height: 50,
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: cityController,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red, //this has no effect
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "City",
                    prefixIcon: const Icon(Icons.location_city,
                        color: AppColors.primaryColor)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 15, right: 30),
            child: SizedBox(
              height: 50,
              child: TextField(
                textInputAction: TextInputAction.done,
                controller: stateController,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red, //this has no effect
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "State",
                    prefixIcon: const Icon(Icons.location_city,
                        color: AppColors.primaryColor)),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
              child: Bounce(
                duration: const Duration(milliseconds: 110),
                onPressed: () {
                  focusNode.unfocus();
                  if (firstNameController.text.isEmpty) {
                    if (kDebugMode) {
                      print('Enter First Name');
                    }
                  } else if (lastNameController.text.isEmpty) {
                    if (kDebugMode) {
                      print('Enter Last Name');
                    }
                  } else if (timeOfBirthController.text.isEmpty) {
                    if (kDebugMode) {
                      print('Enter Time Of Birth');
                    }
                  } else if (birthDateController.text.isEmpty) {
                    if (kDebugMode) {
                      print('Enter Date Of Birth');
                    }
                  } else if (genderController.text.isEmpty) {
                    if (kDebugMode) {
                      print('Enter Gender');
                    }
                  } else if (cityController.text.isEmpty) {
                    if (kDebugMode) {
                      print('Enter City');
                    }
                  } else if (stateController.text.isEmpty) {
                    if (kDebugMode) {
                      print('Enter State');
                    }
                  } else {
                    getRegistered(File(image!.path));
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ))
        ],
      )),
    );
  }

  void getRegistered(File imageFile) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Loading();
        });

    Map data = {
      NetworkConstant.API_PARAM_FIRST_NAME: firstNameController.text,
      NetworkConstant.API_PARAM_LAST_NAME: lastNameController.text,
      NetworkConstant.API_PARAM_DATE_OF_TIME: timeOfBirthController.text,
      NetworkConstant.API_PARAM_DATE_OF_BIRTH: birthDateController.text,
      NetworkConstant.API_PARAM_GENDER: genderController.text,
      NetworkConstant.API_PARAM_CITY: cityController.text,
      NetworkConstant.API_PARAM_STATE: stateController.text,
    };
    if (kDebugMode) {
      print(data);
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString(SharedPrefConstant.TOKEN);

    Map param = {'token': token, 'registerData': json.encode(data)};
    authDataBloc.callSignUpApiWithProfile(param, imageFile);
    // authDataBloc.callSignUpApiWithoutProfile(param);
  }
}
