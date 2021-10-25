import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/products/ProductsClass.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/States.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){},
      builder: (context,state){
          return ProductsClass();
      },
    );
  }
}
