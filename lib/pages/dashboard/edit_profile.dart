import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/bloc/user_data_bloc.dart';
import 'package:flutter_architecture/models/responses/custom_response/user/user_model.dart';
import 'package:flutter_architecture/models/responses/custom_response/user_profile_response.dart';
import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/utilities/app_colors.dart';
import 'package:flutter_architecture/utilities/app_strings.dart';
import 'package:flutter_architecture/utilities/string_styles.dart';
import 'package:flutter_architecture/view_model/user_view_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  // UserProfileResponse userPreference;
  // EditProfile({super.key, required this.userPreference});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late UserDataBloc userDataBloc;
  bool isLoading = true;
  UserProfileResponse? userEditProfileResponse;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthTimeController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  File? selectedProfile;
  String? profileUrl;
  void selectImage() async {
    ImagePicker picker = ImagePicker();
    var response =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      selectedProfile = File(response!.path);
    });
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

  void getEditProfileData() async {
    UserModel token = await UserViewModel().getUser();
    Map data = {NetworkConstant.TOKEN: token.token};

    if (kDebugMode) {
      print("****************");
    }
    if (kDebugMode) {
      print(token);
    }
    userDataBloc.callGetUserProfileApi(data);
  }

  @override
  void initState() {
    userDataBloc = UserDataBloc();
    userDataBloc.userDataStream.listen((event) {
      setState(() {
        isLoading = false;
      });
      userEditProfileResponse = UserProfileResponse.fromJson(event);
      if (kDebugMode) {
        print("************************************************");
      }
      if (kDebugMode) {
        print(userEditProfileResponse.toString());
      }
    });

    getEditProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: Get.width / 1,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 0.5,
                    color: AppColors.whiteColor,
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.greyColor,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 5))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      // Stack(
                      //   children: [
                      //     Container(
                      //         height: 110,
                      //         width: 110,
                      //         decoration: BoxDecoration(
                      //             color: AppColors.primaryColor,
                      //             shape: BoxShape.circle,
                      //             border: Border.all(
                      //               width: 0.5,
                      //               color: AppColors.whiteColor,
                      //             ),
                      //             boxShadow: const [
                      //               BoxShadow(
                      //                   color: AppColors.greyColor,
                      //                   spreadRadius: 1,
                      //                   blurRadius: 3,
                      //                   offset: Offset(0, 3))
                      //             ],
                      //             image: selectedProfile == null
                      //                 ? profileUrl == ""
                      //                     ? const DecorationImage(
                      //                         image: AssetImage(
                      //                             'assets/images/user_default_image.png'),
                      //                         fit: BoxFit.fill)
                      //                     : DecorationImage(
                      //                         image: NetworkImage(NetworkConstant
                      //                                 .API_PARAM_PROFILE_PIC +
                      //                             profileUrl!),
                      //                         fit: BoxFit.fill)
                      //                 : DecorationImage(
                      //                     image: FileImage(
                      //                       selectedProfile!,
                      //                     ),
                      //                     fit: BoxFit.fill))),
                      //     Positioned(
                      //       right: 1,
                      //       bottom: 1,
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           selectImage();
                      //         },
                      //         child: Container(
                      //           height: 35,
                      //           width: 35,
                      //           decoration: BoxDecoration(
                      //             color: AppColors.whiteColor,
                      //             shape: BoxShape.circle,
                      //             border: Border.all(
                      //               width: 0.5,
                      //               color: AppColors.whiteColor,
                      //             ),
                      //             boxShadow: const [
                      //               BoxShadow(
                      //                   color: AppColors.greyColor,
                      //                   spreadRadius: 1,
                      //                   blurRadius: 3,
                      //                   offset: Offset(0, 3))
                      //             ],
                      //           ),
                      //           child: const Center(
                      //               child: Icon(Icons.edit, size: 15)),
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: Get.width / 1,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 20.0, 20.0, 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.account_box,
                                          color: AppColors.primaryColor,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          AppStrings.firstName,
                                          style: textStyle(
                                              color: AppColors.secondryColor,
                                              size: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    Expanded(
                                      child: SizedBox(
                                        child: TextField(
                                          // controller: _firstNameController,
                                          textInputAction: TextInputAction.next,
                                          cursorHeight: 20,
                                          keyboardType: TextInputType.name,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          cursorColor: AppColors.secondryColor,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 15),
                                              hintText: userEditProfileResponse!
                                                  .firstName,
                                              hintStyle: textStyle(
                                                  size: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.secondryColor)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.account_box,
                                          color: AppColors.primaryColor,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          AppStrings.lastName,
                                          style: textStyle(
                                              color: AppColors.secondryColor,
                                              size: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    Expanded(
                                      child: SizedBox(
                                        child: TextField(
                                          // controller: _firstNameController,
                                          textInputAction: TextInputAction.next,
                                          cursorHeight: 20,
                                          keyboardType: TextInputType.name,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          cursorColor: AppColors.secondryColor,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 15),
                                              hintText: userEditProfileResponse!
                                                  .lastName,
                                              hintStyle: textStyle(
                                                  size: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.secondryColor)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.call,
                                          color: AppColors.primaryColor,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          AppStrings.mobileNumber,
                                          style: textStyle(
                                              color: AppColors.secondryColor,
                                              size: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    Expanded(
                                      child: SizedBox(
                                        child: TextField(
                                          // controller: _firstNameController,
                                          textInputAction: TextInputAction.next,
                                          cursorHeight: 20,
                                          keyboardType: TextInputType.name,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          cursorColor: AppColors.secondryColor,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 15),
                                              hintText: userEditProfileResponse!
                                                  .mobileNumber,
                                              hintStyle: textStyle(
                                                  size: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.secondryColor)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.face,
                                          color: AppColors.primaryColor,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          AppStrings.gender,
                                          style: textStyle(
                                              color: AppColors.secondryColor,
                                              size: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    Expanded(
                                      child: SizedBox(
                                        child: TextField(
                                          // controller: _firstNameController,
                                          textInputAction: TextInputAction.next,
                                          cursorHeight: 20,
                                          keyboardType: TextInputType.name,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          cursorColor: AppColors.secondryColor,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 15),
                                              hintText:
                                                  userEditProfileResponse!.dob,
                                              hintStyle: textStyle(
                                                  size: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.secondryColor)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month,
                                          color: AppColors.primaryColor,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          AppStrings.dob,
                                          style: textStyle(
                                              color: AppColors.secondryColor,
                                              size: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    Expanded(
                                      child: SizedBox(
                                        child: TextField(
                                          // controller: _firstNameController,
                                          textInputAction: TextInputAction.next,
                                          cursorHeight: 20,
                                          keyboardType: TextInputType.name,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          cursorColor: AppColors.secondryColor,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 15),
                                              hintText:
                                                  userEditProfileResponse!.dob,
                                              hintStyle: textStyle(
                                                  size: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.secondryColor)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month,
                                          color: AppColors.primaryColor,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          AppStrings.tob,
                                          style: textStyle(
                                              color: AppColors.secondryColor,
                                              size: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    Expanded(
                                      child: SizedBox(
                                        child: TextField(
                                          // controller: _firstNameController,
                                          textInputAction: TextInputAction.next,
                                          cursorHeight: 20,
                                          keyboardType: TextInputType.name,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          cursorColor: AppColors.secondryColor,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 15),
                                              hintText: userEditProfileResponse!
                                                  .dobTime,
                                              hintStyle: textStyle(
                                                  size: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.secondryColor)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_city,
                                          color: AppColors.primaryColor,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          AppStrings.city,
                                          style: textStyle(
                                              color: AppColors.secondryColor,
                                              size: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    Expanded(
                                      child: SizedBox(
                                        child: TextField(
                                          // controller: _firstNameController,
                                          textInputAction: TextInputAction.next,
                                          cursorHeight: 20,
                                          keyboardType: TextInputType.name,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          cursorColor: AppColors.secondryColor,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 15),
                                              hintText:
                                                  userEditProfileResponse!.city,
                                              hintStyle: textStyle(
                                                  size: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.secondryColor)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_pin,
                                          color: AppColors.primaryColor,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          AppStrings.state,
                                          style: textStyle(
                                              color: AppColors.secondryColor,
                                              size: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    Expanded(
                                      child: SizedBox(
                                        child: TextField(
                                          // controller: _firstNameController,
                                          textInputAction: TextInputAction.next,
                                          cursorHeight: 20,
                                          keyboardType: TextInputType.name,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          cursorColor: AppColors.secondryColor,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 15),
                                              hintText: userEditProfileResponse!
                                                  .state,
                                              hintStyle: textStyle(
                                                  size: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.secondryColor)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text(AppStrings.submit),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            )),
    );
  }
}
