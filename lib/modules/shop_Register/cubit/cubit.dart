import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/registerModel.dart';
import 'package:shop_app/modules/shop_Register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/helper.dart';

class RegisterCubit extends Cubit<ShopRegisterStates>{
  RegisterCubit() : super(ShopRegisterInitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  RegisterModel registerModel;

  void userRegisteration({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url:REGISTER, data:{
      'name':name,
      'email':email,
      'password':password,
      'phone':phone
    }).then((value){
      registerModel=RegisterModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
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