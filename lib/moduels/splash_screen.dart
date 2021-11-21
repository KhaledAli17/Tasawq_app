import 'package:flutter/material.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/components/consts.dart';
import 'package:shop_app/moduels/onBoarding_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> fadeAnimate;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    fadeAnimate = Tween<double>(begin: .2, end: 1).animate(animationController);
    animationController?.repeat(reverse: true);

    goToNext();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //const Spacer(),

          Center(
            child: FadeTransition(
              opacity: fadeAnimate,
              child: const Text(
                'TASAWQ',
                style: TextStyle(
                  fontSize: 51,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          //Image.asset('assets/imgs/splash_view_image.png'),
        ],
      ),
    );
  }

  void goToNext() {
    Future.delayed(
        Duration(
          seconds: 3,
        ), () {
      CacheHelper.saveData(key: 'splash', value: true).then((value) {
        if (value) {
          navigateAndEnd(context, OnBoardingScreen());
        }
      });
    });
  }
}
