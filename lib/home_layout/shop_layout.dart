import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/home_layout/navBar.dart';
import 'package:shop_app/modules/search/search.dart';
import 'package:shop_app/shared/component/componant.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/States.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title:Text('Salla',style: TextStyle(fontSize: 25),),
              bottom: state is ShopLoadingUpdateDataState?
                PreferredSize(child: LinearProgressIndicator(), preferredSize: Size(double.infinity,0)):null,
              actions: [
               ShopCubit.get(context).selectedIndex==3
                   ?IconButton(icon: Icon(Icons.logout), onPressed:(){signOut(context);})
                   :IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      pushPage(context, SearchScreen());
                    })
              ],
            ),
            body: Center(
              child: cubit.bottomScreens[cubit.selectedIndex],
            ),
            bottomNavigationBar: NavBar());
      },
    );
  }
}
