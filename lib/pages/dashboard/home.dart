import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/pages/dashboard/drawer.dart';
import 'package:flutter_architecture/utilities/app_colors.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  final PageController _controller = PageController();
  final List<Widget> _list = <Widget>[
    Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Find your partner with us",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0XFF8A8A8A),
              fontSize: 18.0,
              fontWeight: FontWeight.w600),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            color: AppColors.primaryColor,
          ),
        ))
      ],
    )),
    Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Introducing Cupid Coins",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0XFF8A8A8A),
              fontSize: 18.0,
              fontWeight: FontWeight.w600),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            color: AppColors.primaryColor,
          ),
        ))
      ],
    )),
    Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Share Common Contacts",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0XFF8A8A8A),
              fontSize: 18.0,
              fontWeight: FontWeight.w600),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            color: AppColors.primaryColor,
          ),
        ))
      ],
    )),
  ];
  final int _curr = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: AppColors.primaryColor,
      //drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 40),
            child: CarouselSlider(
              options: CarouselOptions(
                  height: Get.height / 4,
                  viewportFraction: 1,
                  aspectRatio: 1.2,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      // _curr = index;
                    });
                  }),
              items: _list,
            ),
          ),
        ]),
      ),
    );
  }
}
