import 'package:flutter/material.dart';
import 'package:shop_app/models/favouritesModel.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';

class FavHelper extends StatelessWidget {
  final FavouritesModel favModel;
  final int index;
  FavHelper({this.favModel, this.index});
  @override
  Widget build(BuildContext context) {
    var favItem = favModel.data.data[index].product;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Container(
              child:
                  Stack(alignment: AlignmentDirectional.bottomStart, children: [
                Image(
                  image: NetworkImage('${favItem.image}'),
                  height: 120,
                  width: 120,
                ),
                if (favItem.discount != 0)
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
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${favItem.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${favItem.price} \$',
                        style: TextStyle(color: defultColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (favItem.discount != 0)
                        Text(
                          '${favItem.oldPrice} \$',
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          icon: ShopCubit.get(context).favorites[favItem.id]
                              ?Icon(
                            Icons.favorite,
                            color: defultColor,
                          )
                              :Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            ShopCubit.get(context).changeFavourites(favItem.id);
                          })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
