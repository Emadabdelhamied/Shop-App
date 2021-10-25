import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/modules/shop_Register/cubit/cubit.dart';
import 'package:shop_app/modules/shop_Register/cubit/states.dart';
import 'package:shop_app/shared/component/componant.dart';
import 'package:shop_app/shared/network/local/cacheHelper.dart';

class RegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailControll = TextEditingController();
  var nameControll = TextEditingController();
  var passwordControll = TextEditingController();
  var phoneControll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState){
            if(state.model.status){
             showToast(message: state.model.message, time: Toast.LENGTH_LONG,state: toastStates.SUCCESS);
              naigateAndRemove(context,LoginScreen());
            }
            else{
              showToast(message: state.model.message, time: Toast.LENGTH_LONG,state: toastStates.ERROR);
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 20,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sign Up',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      SizedBox(height: 60,),
                      formFeild(
                          label: 'Name',
                          hint: 'Emad Abd El-Hamied',
                          prefix: Icons.person,
                          controller: nameControll,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Name Shoudn\'t be Empty';
                            }
                            return null;
                          },
                          isPassword: false),
                      SizedBox(height: 10,),
                      formFeild(
                          label: 'Email',
                          hint: 'emad@examble.com',
                          prefix: Icons.alternate_email,
                          controller: emailControll,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Email Shoudn\'t be Empty';
                            }
                            return null;
                          },
                          isPassword: false),
                      SizedBox(height: 10,),
                      formFeild(
                          label: 'Password',
                          hint: '',
                          prefix: Icons.lock,
                          controller: passwordControll,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.length<6) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          isPassword: RegisterCubit.get(context).isPassword,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixPressed: (){
                            RegisterCubit.get(context).changePasswordVisibility();
                          }
                      ),
                      SizedBox(height: 10,),
                      formFeild(
                        label: 'Phone',
                        hint: '',
                        prefix: Icons.phone,
                        controller: phoneControll,
                        type: TextInputType.number,
                        validate: (String value) {
                          if (value.length<11) {
                            return 'Invalid Number';
                          }
                          return null;
                        },
                        isPassword:false,
                      ),
                      SizedBox(height: 30,),
                      ConditionalBuilder(
                          condition: state is ! ShopRegisterLoadingState,
                          builder:(context)=> defultBottun(
                              function: (){
                                if(formKey.currentState.validate()){
                                  RegisterCubit.get(context).userRegisteration(
                                      name: nameControll.text,
                                      email: emailControll.text,
                                      password: passwordControll.text,
                                      phone: phoneControll.text
                                  );
                                }
                              },
                              text: 'Sign Up'),
                        fallback:(context)=>Center(child: CircularProgressIndicator(),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account ?'),
                          defaultTextButton(
                              function:(){popPage(context);},
                              text: 'log in')
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
