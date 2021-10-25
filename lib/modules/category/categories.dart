import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoryModel.dart';
import 'package:shop_app/shared/component/componant.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/States.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => catBuilder(ShopCubit.get(context).CategoryModel.data.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:ShopCubit.get(context).CategoryModel.data.data.length);
      },
    );
  }

  Widget catBuilder(CategoryData model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                  '${model.image}'),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text('${model.name}'),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
