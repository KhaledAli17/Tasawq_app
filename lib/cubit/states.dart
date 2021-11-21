import 'dart:io';

import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}


// MAKE LOGIN
class ShopLoadingLoginState extends ShopStates {}

class ShopSucssesLoginState extends ShopStates {
  final LoginModel loginModel;

  ShopSucssesLoginState(this.loginModel);
}

class ShopFailedLoginState extends ShopStates {
  final String error;

  ShopFailedLoginState(this.error);
}

// MAKE REGISTER
class ShopLoadingRegisterState extends ShopStates {}

class ShopSucssesRegisterState extends ShopStates {
  final LoginModel loginModel;

  ShopSucssesRegisterState(this.loginModel);
}

class ShopFailedRegisterState extends ShopStates {
  final String error;

  ShopFailedRegisterState(this.error);
}


// VISIBLE PASSWORD
class ShopSucssesChangePassVisibilityState extends ShopStates {}

// BOTTOM NAV BAR
class ChangeBottomNavigationBar extends ShopStates {}

// HOME DATA
class LoadingHomeData extends ShopStates{}
class SuccesHomeData extends ShopStates{}
class FailedHomeData extends ShopStates{}

// GET CATEGORIES DATA
class SuccesCategoriesData extends ShopStates{}
class FailedCategoriesData extends ShopStates{}

// MAKE ITEM FAVORITE
class ChangeFavoritesData extends ShopStates{}
class SuccesFavoritesData extends ShopStates{
  final ChangeFavoriteModel changeFavoriteModel;

  SuccesFavoritesData(this.changeFavoriteModel);
}
class FailedFavoritesData extends ShopStates{}

// GET FAVORITES DATA
class LoadingGetFavoritesData extends ShopStates{}
class SuccesGetFavoritesData extends ShopStates{}
class FailedGetFavoritesData extends ShopStates{}

// USER DATA
class LoadingGetUserData extends ShopStates{}
class SuccesGetUserData extends ShopStates{
  final LoginModel userData;

  SuccesGetUserData(this.userData);
}
class FailedGetUserData extends ShopStates{}


// SEARCH DATA
class LoadingSearchData extends ShopStates{}
class SuccesSearchData extends ShopStates{}
class FailedSearchsData extends ShopStates{}




class ChangeModeState  extends ShopStates{}