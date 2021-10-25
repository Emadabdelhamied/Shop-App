import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/home_layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/shop_Register/register_screen.dart';
import 'package:shop_app/shared/component/componant.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cacheHelper.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailControll = TextEditingController();
  var passwordControll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSucessState){
            if(state.loginmodel.status){
              print(state.loginmodel.message);
              print(state.loginmodel.data.token);
              CacheHelper.setData(key: 'token', value: state.loginmodel.data.token).then((value){
              token=state.loginmodel.data.token;
              print(token);
                naigateAndRemove(context,ShopLayout());
              });
            }
            else{
              showToast(message: state.loginmodel.message, state:  toastStates.ERROR,time: Toast.LENGTH_LONG);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/login.png'),
                        // Email Form Field
                        formFeild(
                            label: 'Email',
                            hint: 'Enter your Email',
                            prefix: Icons.person,
                            controller: emailControll,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Email Shoudn\'t be Empty';
                              }
                              return null;
                            },
                            isPassword: false),
                        SizedBox(
                          height: 20,
                        ),
                        // Password Form Field
                        formFeild(
                            label: 'Password',
                            hint: 'Enter your Password',
                            prefix: Icons.lock,
                            controller: passwordControll,
                            type: TextInputType.visiblePassword,
                            validate: (String value) {
                              if (value.length < 6) {
                                return 'Password is too short';
                              }
                              return null;
                            },
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            suffix: ShopLoginCubit.get(context).suffix,
                            suffixPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        // Login Button
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defultBottun(
                              function: () {
                                if (formKey.currentState.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailControll.text,
                                      password: passwordControll.text);
                                }
                              },
                              text: 'Log In'),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have account ?'),
                            defaultTextButton(
                                function: () {
                                  pushPage(context, RegisterScreen());
                                },
                                text: 'register'),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
