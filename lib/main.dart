// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/components/consts.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/moduels/categories/profile.dart';
import 'package:shop_app/moduels/onBoarding_screen.dart';
import 'package:shop_app/moduels/register_screen.dart';
import 'package:shop_app/moduels/splash_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';

import 'bloc.dart';
import 'moduels/login_screen.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  //bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  bool splash = CacheHelper.getData(key: 'splash');
  token = CacheHelper.getData(key: 'token');
 // print('token :' + token);

  if (splash != null) {
    if (token != null)
      widget = HomeScreen();
    else
      widget = LoginScreen();
  } else {
    widget = SplashScreen();
  }

  print(splash);

  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  final Widget startWidget;

  MyApp({this.startWidget, this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavoritesData()
        ..getUserData()
        ..changeAppMode(
          fromShared: isDark,
        ),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: kPrimaryColor,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: defaultColor,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: HexColor('333739'),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: kPrimaryColor,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                // ignore: deprecated_member_use
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: defaultColor,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: HexColor('333739'),
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: ShopCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
