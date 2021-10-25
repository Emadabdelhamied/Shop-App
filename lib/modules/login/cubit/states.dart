import 'package:shop_app/models/loginModel.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginSucessState extends ShopLoginStates{
  final LoginModel loginmodel;
  ShopLoginSucessState(this.loginmodel);
}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates{}
