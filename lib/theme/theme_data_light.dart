import 'package:flutter/material.dart'
    show
        AppBarTheme,
        BorderRadius,
        Brightness,
        CardTheme,
        Color,
        Colors,
        DividerThemeData,
        FloatingActionButtonThemeData,
        IconThemeData,
        RoundedRectangleBorder,
        TabBarIndicatorSize,
        TabBarTheme,
        TextStyle,
        TextTheme,
        ThemeData;
import 'package:flutter/material.dart';

class ColorsBag {
  static const Color primeryWhiteColor = Color(0xFFFCF5F5);
  static const Color primeryLightColor = Color(0xffd5b664);
  static const Color primeryMedialColor = Color(0xff957f42);
  static const Color primeryDarkColor = Color(0xff776633);
  static const Color primeryVeryDarkColor = Color(0xFF635423);
}

class ThemeDataLight {
  static const Color light = Color(0xFF635423);
  static const Color dark = Color(0xFF42360D);
  static const Color primeryWhiteColor = Color(0xFFFCF5F5);
  get theme => ThemeData(
        brightness: Brightness.light,
        primaryColor: primeryWhiteColor,
        primaryColorLight: light, primaryColorDark: dark,
        accentColor: Color(0xFF786320),
        applyElevationOverlayColor: true,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: AppBarTheme(
          elevation: 1,
          textTheme: TextTheme(
              headline6: TextStyle(
            color: light,
            fontSize: 26,
          )),
          iconTheme: IconThemeData(
            color: light,
          ),
        ),

        //
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hoverColor: ColorsBag.primeryLightColor,
          focusColor: light,
          alignLabelWithHint: true,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: light),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: light.withOpacity(0.5)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelStyle: TextStyle(
            color: light,
          ),
        ),

        //
        tabBarTheme: TabBarTheme(
          labelColor: light,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: TextStyle(
            fontSize: 22,
          ),
        ),
        iconTheme: IconThemeData(
          color: light,
        ),

        cardTheme: CardTheme(
          color: primeryWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        dividerTheme: DividerThemeData(
          color: light,
          thickness: 1,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: light,
          foregroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: light,
            fontFamily: 'GeSsTwoLight',
          ),
          headline2: TextStyle(
            color: light,
            fontFamily: 'GeSsTwoLight',
          ),
          headline3: TextStyle(
            color: light,
            fontFamily: 'GeSsTwoLight',
          ),
          headline4: TextStyle(
            color: light,
            fontFamily: 'GeSsTwoLight',
          ),
          headline5: TextStyle(
            color: light,
            fontFamily: 'GeSsTwoLight',
          ),
          headline6: TextStyle(
            color: light,
            fontFamily: 'GeSsTwoLight',
          ),
          bodyText1: TextStyle(
            color: light,
            fontFamily: 'GeSsTwoLight',
          ),
          bodyText2: TextStyle(
            color: light,
            fontFamily: 'GeSsTwoLight',
          ),
          subtitle1: TextStyle(
            color: light,
            fontFamily: 'GeSsTwoLight',
          ),
          subtitle2: TextStyle(
            color: Color(0xFFFFFFFF),
            fontFamily: 'GeSsTwoLight',
          ),
          caption: TextStyle(
            fontSize: 12.0,
            color: light,
            fontFamily: 'GeSsTwoLight',
          ),
        ),
      );
}
