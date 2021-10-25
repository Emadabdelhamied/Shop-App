import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
class NavBar extends StatelessWidget {
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<GButton> tabs=[
    GButton(
      icon: Icons.home,
      text: 'Home',
    ),
    GButton(
      icon: Icons.apps,
      text: 'Categories',
    ),
    GButton(
      icon: Icons.favorite_border,
      text: 'Favourite',
    ),
    GButton(
      icon: Icons.settings,
      text: 'Settings',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 8,
              activeColor: defultColor,
              iconSize: 20,
              padding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[200],
              color: Colors.black,
              tabs:tabs ,
              selectedIndex: cubit.selectedIndex,
              onTabChange:(int index){
                cubit.changeBottomScreen(index);
              },
            ),
          ),
        ));
  }
}
