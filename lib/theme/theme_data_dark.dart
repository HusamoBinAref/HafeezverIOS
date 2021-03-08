import 'package:flutter/material.dart'
    show
        AppBarTheme,
        Brightness,
        Color,
        FloatingActionButtonThemeData,
        IconThemeData,
        TabBarTheme,
        TextStyle,
        TextTheme,
        ThemeData;
import 'package:flutter/material.dart';

// Color get primeryWhiteColor => Color(0xFFFCF5F5);
// Color get primeryLightColor => Color(0xffd5b664);
// Color get primeryMedialColor => Color(0xff957f42);
// Color get primeryDarkColor => Color(0xff776633);
// Color get primeryVeryDarkColor => Color(0xFF635426);

class ThemeDataDark {
  static const Color light = Color(0xffd5b664);
  static const Color dark = Color(0xFFB6963E);
  get theme => ThemeData(
        brightness: Brightness.dark,
        // primaryColor: Color(0xff957f42),

        primaryColor: Color(0xFF252525),
        accentColor: Color(0xff957f42),
        textSelectionColor: Colors.brown.shade800,
        primaryColorLight: light, primaryColorDark: dark,
        applyElevationOverlayColor: true,

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
          hoverColor: light,
          focusColor: light,
          alignLabelWithHint: true,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            gapPadding: 1,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: light),
            gapPadding: 1,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: TextStyle(
            color: light,
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
            color: light,
          ),
        ),

        iconTheme: IconThemeData(
          color: Color(0xFF252525),
        ),

        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        dividerTheme: DividerThemeData(
          color: light,
          thickness: 1,
        ),

        /// floating Action Buttons
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: light,
          foregroundColor: Color(0xFF252525),
        ),
        //
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
            color: Color(0xFF252525),
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
