import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/categoryModel.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';

class ProductsClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: ShopCubit.get(context).homeModel != null &&
          ShopCubit.get(context).CategoryModel != null,
      builder: (context) => productBuilder(ShopCubit.get(context).homeModel,
          ShopCubit.get(context).CategoryModel, context),
      fallback: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget productBuilder(HomeModel model, Categories catModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 4),
                autoPlayCurve: Curves.fastOutSlowIn,
                initialPage: 0,
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildCategory(catModel),
            Container(
              color: Colors.grey[200],
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.58,
                crossAxisCount: 2,
                children: List.generate(model.data.products.length,
                    (index) => buildGrid(model.data.products[index], context)),
              ),
            ),
          ],
        ),
      );

  Widget buildGrid(ProductsModel model, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:
                Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
            ]),
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.1),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price} \$',
                      style: TextStyle(color: defultColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()} \$',
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        icon: ShopCubit.get(context).favorites[model.id]
                            ? Icon(
                                Icons.favorite,
                                color: defultColor,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                              ),
                        onPressed: () {
                          ShopCubit.get(context).changeFavourites(model.id);
                        })
                  ],
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildCategory(Categories model) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      categoyItem(model.data.data[index]),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 8,
                      ),
                  itemCount: model.data.data.length),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'New Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );

  Widget categoyItem(CategoryData model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              '${model.name}',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
}
