import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/favourite/favHelper.dart';
import 'package:shop_app/shared/component/componant.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/States.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is!ShopLoadingFavoritesState,
          builder: (context) =>
              ShopCubit.get(context).favouritesModel.data.data.length == 0
                  ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                          child: Icon(
                        Icons.favorite,
                        color: Colors.grey[200],
                        size: 300,
                      )),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) => FavHelper(
                          favModel: ShopCubit.get(context).favouritesModel,
                          index: index),
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: ShopCubit.get(context)
                          .favouritesModel
                          .data
                          .data
                          .length),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
