import 'package:flutter/material.dart';

class CustomTheme{
  static ThemeData lightTheme = ThemeData(
  cardColor: Colors.white,
    backgroundColor: Colors.white,
      primaryColor: Colors.white,
      drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
    brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.red),
    textTheme: const TextTheme(

      bodyMedium: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 25,
          color: Colors.black),

      titleMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
        color: Colors.black,
      ),
      titleSmall:  TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 25),
        bodyLarge: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w500,
          fontSize: 20),
      bodySmall: TextStyle(
          color: Colors.black,
          fontFamily: 'MainFont',

    )
  )
  );

  static ThemeData darkTheme = ThemeData(
      cardColor: const Color(0xff191A32),
      drawerTheme: DrawerThemeData(backgroundColor: const Color(0xff191A32)),
      backgroundColor: const Color(0xff191A32),
      primaryColor: Color(0xff191A32),
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: const TextTheme(

        bodyMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 25,
            color: Colors.white),

          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.white,
            overflow: TextOverflow.ellipsis,

          ),
          titleSmall:  TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),

          titleLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 25,
              overflow: TextOverflow.clip
          ),

          bodyLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20),

          bodySmall: TextStyle(
            color: Colors.white,
              fontFamily: 'MainFont',
          ),

      )
  );

}