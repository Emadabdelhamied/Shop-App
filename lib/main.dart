import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/home_layout/shop_layout.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/modules/onBoarding.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/States.dart';
import 'package:shop_app/shared/network/local/cacheHelper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'shared/network/remote/helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Widget widget;
  bool isDark = CacheHelper.getData(key: 'isDark');
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  MyApp({this.isDark, this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..changeAppMode(fromShared: isDark)
        ..getFavData()
        ..getHomeData()
        ..getCategoryData()
        ..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ShopCubit.get(context).isDark
                ? ThemeMode.light
                : ThemeMode.dark,
            home: startWidget,
          );
        },
      ),
    );
  }
}
