import 'package:flutter/material.dart';

final kPrimaryColor = Color(0xff128C7E);
final kPrimaryLightColor = Color(0xff25D366);
final kPrimaryDarkColor = Color(0xff075E54);
final kOutgoingMessageBubbleColor = Color(0xffDCF8C6);
final kWhiteColor = Colors.white;

final kLightTheme = ThemeData.light().copyWith(
  primaryColor: kPrimaryColor,
  appBarTheme: AppBarTheme(
    color: kPrimaryColor,
    actionsIconTheme: IconThemeData(color: kWhiteColor),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kPrimaryLightColor,
    foregroundColor: kWhiteColor,
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.grey[200],
    labelColor: kWhiteColor,
  ),
);
