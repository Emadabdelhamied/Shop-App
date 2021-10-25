import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  LoginModel shopLogin;
  void userLogin({@required String email, @required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },

    ).then((value) {
      shopLogin=LoginModel.fromJson(value.data);
      emit(ShopLoginSucessState(shopLogin));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix=Icons.visibility;
  bool isPassword=true;

  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_off:Icons.visibility;
    emit(ShopChangePasswordVisibilityState());
  }
}
