// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/components/consts.dart';
import 'package:shop_app/moduels/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoradingModel {
  final String img;
  final String title;
  final String body;

  BoradingModel({
    @required this.img,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var onBoardController = PageController();

  List<BoradingModel> boarding = [
    BoradingModel(
        img: 'assets/images/onboarding1.png',
        title: 'Shopping',
        body: 'Explore top organic fruits & grab them'),
    BoradingModel(
        img: 'assets/images/onboarding2.png',
        title: 'Delivery on the way',
        body: 'Get your order by speed delivery'),
    BoradingModel(
        img: 'assets/images/onboarding3.png',
        title: 'Delivery Arrived',
        body: 'Order is arrived at your Place'),
  ];
  bool isLast = false;
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndEnd(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: const Text(
                'SKIP',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: defaultColor,
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: onBoardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                      print('last');
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildPageViewItems(boarding[index]),
                itemCount: 3,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: onBoardController,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      onBoardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                  backgroundColor: defaultColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildPageViewItems(BoradingModel boradingModel) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage('${boradingModel.img}')),
        const SizedBox(
          height: 20.0,
        ),
        Center(
          child: Column(
            children: [
              Text(
                '${boradingModel.title}',
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                '${boradingModel.body}',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
