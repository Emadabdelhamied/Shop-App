import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/constants/constants.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: defultColor,
    fontFamily: 'RobotoSlab',
    scaffoldBackgroundColor: primarydarkBackground,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        backgroundColor: primarydarkBackground,
        elevation: 0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primarydarkBackground,
          statusBarIconBrightness: Brightness.light,
        )),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white)));

ThemeData lightTheme = ThemeData(
    primarySwatch: defultColor,
    scaffoldBackgroundColor: primaryBackground,
    fontFamily: 'RobotoSlab',
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        backgroundColor: primaryBackground,
        elevation: 0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryBackground,
          statusBarIconBrightness: Brightness.dark,
        )),
    textTheme:TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black
        )
    )
);
