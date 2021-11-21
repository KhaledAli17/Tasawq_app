import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/components/consts.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/get_fav_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/moduels/categories/categories.dart';
import 'package:shop_app/moduels/categories/favorites.dart';
import 'package:shop_app/moduels/categories/productes.dart';
import 'package:shop_app/moduels/categories/profile.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';
import 'package:shop_app/network/end_point.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  LoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(ShopLoadingLoginState());
    DioHelper.postData(url: Login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      loginModel = LoginModel.dataFromJson(value.data);
      emit(ShopSucssesLoginState(loginModel));
    }).catchError((error) {
      emit(ShopFailedLoginState(error.toString()));
    });
  }

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(ShopLoadingRegisterState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data);
      loginModel = LoginModel.dataFromJson(value.data);
      emit(ShopSucssesRegisterState(loginModel));
    }).catchError((error) {
      emit(ShopFailedRegisterState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changePassVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopSucssesChangePassVisibilityState());
  }

  int currentIndex = 0;

  List<Widget> bottomScreens = const [
    ProductesScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];
  List<String> titles = [
    'Tasawq',
    'Categories',
    'Favorite',
    'Profile',
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavigationBar());
  }

  HomeModel homeModel;
  Map<int, dynamic> favorites = {};

  void getHomeData() {
    emit(LoadingHomeData());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.in_favorites,
        });
      });
      print(favorites.toString());
      /*   printFullText(homeModel.data.banners[0].image);
      print(homeModel.status);*/
      emit(SuccesHomeData());
    }).catchError((error) {
      print(error.toString());
      emit(FailedHomeData());
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccesCategoriesData());
    }).catchError((error) {
      print(error.toString());
      emit(FailedCategoriesData());
    });
  }

  ChangeFavoriteModel changeFavoriteModel;

  void changeFavorites(int id) {
    favorites[id] = !favorites[id];

    emit(ChangeFavoritesData());

    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': id},
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoriteModel.status) {
        favorites[id] = !favorites[id];
      } else {
        getFavoritesData();
      }
      emit(SuccesFavoritesData(changeFavoriteModel));
    }).catchError((onError) {
      favorites[id] = !favorites[id];
      emit(FailedFavoritesData());
    });
  }

  GetFavoriteData getFavoriteData;
  void getFavoritesData() {
    emit(LoadingGetFavoritesData());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      getFavoriteData = GetFavoriteData.fromJson(value.data);
      emit(SuccesGetFavoritesData());
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetFavoritesData());
    });
  }

  LoginModel userData;
  void getUserData() {
    emit(LoadingGetUserData());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userData = LoginModel.dataFromJson(value.data);
      emit(SuccesGetUserData(userData));
    }).catchError((error) {
      print(error.toString());
      emit(FailedGetUserData());
    });
  }

  SearchData searchData;
  void search({@required String text}) {
    emit(LoadingSearchData());
    DioHelper.postData(
            url: SEARCH,
            data: {
              'text': text,
            },
            token: token)
        .then((value) {
      searchData = SearchData.fromJson(value.data);
      emit(SuccesSearchData());
    }).catchError((error) {
      print(error.toString());
      emit(FailedSearchsData());
    });
  }



  bool isDark = true;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeModeState());
      });
    }
  }
}
