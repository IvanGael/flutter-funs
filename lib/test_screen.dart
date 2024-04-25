import 'package:flutter/material.dart';
import 'package:flutter_explosive_like/character_transformation_animation.dart';
import 'package:flutter_explosive_like/cherry_blossom_animation.dart';
import 'package:flutter_explosive_like/custom_3D_carousel.dart';
import 'package:flutter_explosive_like/custom_numerical_keyboard.dart';
import 'package:flutter_explosive_like/elevator_simulator_screen.dart';
import 'package:flutter_explosive_like/explosive_heart_button.dart';
import 'package:flutter_explosive_like/hear_palpitation_animation.dart';
import 'package:flutter_explosive_like/liquid_linear_pogress_indicator.dart';
import 'package:flutter_explosive_like/password_checker.dart';
import 'package:flutter_explosive_like/payment_button.dart';
import 'package:flutter_explosive_like/profilePicker/profile_picker1.dart';
import 'package:flutter_explosive_like/profilePicker/profile_picker10.dart';
import 'package:flutter_explosive_like/profilePicker/profile_picker2.dart';
import 'package:flutter_explosive_like/profilePicker/profile_picker3.dart';
import 'package:flutter_explosive_like/profilePicker/profile_picker4.dart';
import 'package:flutter_explosive_like/profilePicker/profile_picker5.dart';
import 'package:flutter_explosive_like/profilePicker/profile_picker6.dart';
import 'package:flutter_explosive_like/profilePicker/profile_picker7.dart';
import 'package:flutter_explosive_like/profilePicker/profile_picker8.dart';
import 'package:flutter_explosive_like/profilePicker/profile_picker9.dart';
import 'package:flutter_explosive_like/reels_screen.dart';
import 'package:flutter_explosive_like/stories_screen.dart';
import 'package:flutter_explosive_like/stretchy_tab_bar.dart';
import 'package:flutter_explosive_like/swipe_to_pay_button.dart';
import 'package:flutter_explosive_like/time_travel_animation.dart';
import 'package:flutter_explosive_like/spider_animation.dart';
import 'package:flutter_explosive_like/water_level_slider.dart';
import 'package:flutter_explosive_like/water_pouring_animation.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  String ecran = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       Text(
      //         ecran,
      //         style: const TextStyle(color: Colors.white, fontSize: 20),
      //       ),
      //       const SizedBox(
      //         height: 20,
      //       ),
      //       CustomNumericalKeyboard(
      //         onKeyPressed: (key) {
      //           if (key.isEmpty) {
      //             setState(() {
      //               ecran = "";
      //             });
      //           } else {
      //             setState(() {
      //               ecran += key;
      //             });
      //           }
      //           // print('Key pressed: $key');
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      // body: Center(
      //   child: SwipeToPayButton(
      //     onSwipeComplete: () {
      //       // Handle swipe completion
      //       print('Payment completed!');
      //     },
      //   ),
      // ),
      body: PageView(
        controller: pageController,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: const [
          ReelsScreen(videoAsset: 'assets/opening1.mp4',),
          ReelsScreen(videoAsset: 'assets/opening2.mp4',),
          ReelsScreen(videoAsset: 'assets/slow-burn.mp4',),
          ReelsScreen(videoAsset: 'assets/video.mp4',)
        ],
      ),
      backgroundColor: Colors.white,
      // body: SpiderAnimation(),
      // body: Center(
      //   child: PaymentButton(
      //     buttonText: 'Make Payment',
      //     onPressed: () {
      //       print('payero');
      //     },
      //   ),
      // ),
      // bottomNavigationBar: StretchyTabBar(),
    );
  }
}
