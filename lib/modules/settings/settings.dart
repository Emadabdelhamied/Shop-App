import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/componant.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/States.dart';

class SettingScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailControll = TextEditingController();
  var nameControll = TextEditingController();
  var phoneControll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var model=ShopCubit.get(context).userModel;
        emailControll.text=model.data.email;
        nameControll.text=model.data.name;
        phoneControll.text=model.data.phone;
        return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel!=null,
            builder: (context)=> SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(model.data.image),
                        ),
                        SizedBox(height: 30,),
                        formFeild(
                            label: 'Name',
                            hint: 'Enter your name ',
                            prefix: Icons.person,
                            controller: nameControll,
                            type: TextInputType.text,
                            validate: (String value){
                              if (value.isEmpty) {
                                return 'Name Shoudn\'t be Empty';
                              }
                              return null;
                            },
                            isPassword: false
                        ),
                        SizedBox(height: 20,),
                        formFeild(
                            label: 'Email',
                            hint: 'Enter your email ',
                            prefix: Icons.email_rounded,
                            controller: emailControll,
                            type: TextInputType.emailAddress,
                            validate: (String value){
                              if (value.isEmpty) {
                                return 'Email Shoudn\'t be Empty';
                              }
                              return null;
                            },
                            isPassword: false
                        ),
                        SizedBox(height: 20,),
                        formFeild(
                            label: 'Phone',
                            hint: 'Enter your phone ',
                            prefix: Icons.phone,
                            controller: phoneControll,
                            type: TextInputType.number,
                            validate: (String value){
                              if (value.isEmpty) {
                                return 'Invalid Number';
                              }
                              return null;
                            },
                            isPassword: false
                        ),
                        SizedBox(height: 20,),
                        defultBottun(
                          width: 100,
                            function: (){
                              if(formKey.currentState.validate()){
                                ShopCubit.get(context).updateUserData(
                                    name: nameControll.text,
                                    phone: phoneControll.text,
                                    email: emailControll.text);
                              }
                            },
                            text: 'Update'
                        ),
                      ],
                    ),
                  ),
              ),
            ),
            
            fallback: (context)=>Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}
