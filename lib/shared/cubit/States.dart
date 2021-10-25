import 'package:shop_app/models/changeFavoritesModel.dart';
import 'package:shop_app/models/loginModel.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeThemeState extends ShopStates {}

class ShopChangeNavBarState extends ShopStates {}

class ShopHomeLoadingState extends ShopStates {}

class ShopHomeSuccessState extends ShopStates {}

class ShopHomeErrorState extends ShopStates {}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopCategoriesErrorState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates{}

class ShopChangeFavoritesSuccessState extends ShopStates {
  final ChangeFavoritesModel model;
  ShopChangeFavoritesSuccessState(this.model);
}

class ShopChangeFavoritesErrorState extends ShopStates {}

class ShopFavoritesSuccessState extends ShopStates {}

class ShopLoadingFavoritesState extends ShopStates {}

class ShopFavoritesErrorState extends ShopStates {}

class ShopUserDataSuccessState extends ShopStates {
  final LoginModel model;
  ShopUserDataSuccessState(this.model);
}

class ShopLoadingUserDataState extends ShopStates {}

class ShopUserDataErrorState extends ShopStates {}

class ShopUpdateDataSuccessState extends ShopStates {
  final LoginModel model;
  ShopUpdateDataSuccessState(this.model);
}

class ShopLoadingUpdateDataState extends ShopStates {}

class ShopUpdateDataErrorState extends ShopStates {}
