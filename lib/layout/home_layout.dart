// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/moduels/categories/search.dart';
import 'package:shop_app/moduels/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var cubit = ShopCubit.get(context);

    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state) {},
      builder: (context , state){
      return  Scaffold(
          appBar: AppBar(
            title:  Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                onPressed: () {
                  ShopCubit.get(context).changeAppMode();
                },
                icon: Icon(Icons.brightness_4_rounded),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon:Icon(Icons.home),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon:Icon(Icons.apps_outlined),
                  label: 'Categories'),
              BottomNavigationBarItem(
                  icon:Icon(Icons.favorite),
                  label: 'Favorites'),
              BottomNavigationBarItem(
                  icon:Icon(Icons.person),
                  label: 'Profile'),
            ],
          ),
        );
      },

    );
  }
}
