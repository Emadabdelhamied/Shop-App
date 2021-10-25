import 'package:shop_app/models/registerModel.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final RegisterModel model;
  ShopRegisterSuccessState(this.model);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopRegisterStates{}