import 'package:firebase_app/Widgets/colors.dart';
import 'package:flutter/material.dart';

class Themes  {
 static  ThemeData lightTheme() {
  return ThemeData(
        useMaterial3: true,
        popupMenuTheme:const PopupMenuThemeData(
          color: LightThemeColors.darkgrey,
          elevation: 4.0,
          shape: RoundedRectangleBorder(),
          textStyle: TextStyle(color: Colors.black, fontSize: 15),
          position: PopupMenuPosition.over
        ),
        scaffoldBackgroundColor: LightThemeColors.orange,
        primaryColor: LightThemeColors.redorange,
        primaryColorDark: LightThemeColors.orange,
        primaryColorLight: LightThemeColors.lightorange,
        textTheme: const  TextTheme(
          displayLarge: TextStyle(color: LightThemeColors.coolGreen, fontSize: 22, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: LightThemeColors.coolGreen, fontSize: 20, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(color: LightThemeColors.coolGreen, fontSize: 18, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: Colors.black, fontSize: 25, overflow: TextOverflow.ellipsis),
          titleMedium: TextStyle(color: Colors.black54, fontSize: 16, overflow: TextOverflow.ellipsis),
          titleSmall: TextStyle(color: Colors.black45, fontSize: 16, overflow: TextOverflow.ellipsis),
          bodySmall: TextStyle(color: Colors.black54, fontSize: 16),
          bodyMedium: TextStyle(color: LightThemeColors.coolGreen, fontSize: 20, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: LightThemeColors.coolGreen, fontSize: 27, fontWeight: FontWeight.bold),
        ),
        bottomNavigationBarTheme:const BottomNavigationBarThemeData(
          backgroundColor: LightThemeColors.redorange,
          selectedIconTheme: IconThemeData(
            color: LightThemeColors.orange,
            fill: 0.8,
            size: 25,
            weight: 30,
            opticalSize: 10
          ),
          unselectedIconTheme:  IconThemeData(
            color: LightThemeColors.orange,
            fill: 1,
            size: 25,
            weight: 30,
            opticalSize: 10
          ),
          type: BottomNavigationBarType.shifting,
          elevation: 5
        ),
        iconButtonTheme:const IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(LightThemeColors.coolGreen),
            iconSize: MaterialStatePropertyAll(25),
            animationDuration: Duration(milliseconds: 300)
          )
        ),
        iconTheme:const IconThemeData(
          size: 25,
          fill: 0.2,
          weight: 10,
          grade: 20,
          color:  LightThemeColors.coolGreen
        ),
        tabBarTheme: const TabBarTheme(
          indicator: BoxDecoration(
            color: LightThemeColors.coolGreen,
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          dividerColor: Colors.transparent,
          labelColor: Colors.black45,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: Colors.white54,
          tabAlignment: TabAlignment.fill
        )
    );
  }

  static ThemeData darkTheme() {
     return ThemeData(
        useMaterial3: true,
        popupMenuTheme:const PopupMenuThemeData(
          color: DarkThemeColors.darkgrey,
          elevation: 4.0,
          shape: RoundedRectangleBorder(),
          textStyle: TextStyle(color: Colors.black, fontSize: 15),
          position: PopupMenuPosition.over
        ),
        scaffoldBackgroundColor: DarkThemeColors.darkpurple,
        primaryColor: DarkThemeColors.darkpurple,
        primaryColorDark: DarkThemeColors.darkpurple,
        primaryColorLight: DarkThemeColors.lightpurle,
        textTheme: const  TextTheme(
          displayLarge: TextStyle(color: DarkThemeColors.coolGreen, fontSize: 22, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: DarkThemeColors.coolGreen, fontSize: 20, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(color: DarkThemeColors.coolGreen, fontSize: 16, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: DarkThemeColors.coolGreen, fontSize: 25, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: Colors.black54, fontSize: 18),
          titleSmall: TextStyle(color: Colors.white38, fontSize: 12),
          bodySmall: TextStyle(color: Colors.white, fontSize: 16),
          bodyMedium: TextStyle(color: DarkThemeColors.coolGreen, fontSize: 16),
          bodyLarge: TextStyle(color: Colors.white54, fontSize: 20)
        ),
        bottomNavigationBarTheme:const BottomNavigationBarThemeData(
          backgroundColor: DarkThemeColors.darkpurple,
          selectedIconTheme: IconThemeData(
            color: DarkThemeColors.darkpurple,
            fill: 0.8,
            size: 20,
            weight: 30,
            opticalSize: 10
          ),
          unselectedIconTheme:  IconThemeData(
            color: DarkThemeColors.darkpurple,
            fill: 1,
            size: 20,
            weight: 30,
            opticalSize: 10
          ),
          type: BottomNavigationBarType.shifting,
          elevation: 5
        ),
        iconButtonTheme:const IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(DarkThemeColors.coolGreen),
            iconSize: MaterialStatePropertyAll(25),
            animationDuration: Duration(milliseconds: 300)
          )
        ),
        iconTheme:const IconThemeData(
          size: 20,
          fill: 0.2,
          weight: 10,
          grade: 20,
          color: DarkThemeColors.coolGreen
        ),
        tabBarTheme: const TabBarTheme(
          indicator: BoxDecoration(
            color: DarkThemeColors.coolGreen,
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          dividerColor: Colors.transparent,
          labelColor: Colors.black45,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: Colors.white54,
          tabAlignment: TabAlignment.fill
        ),

    );
  }
}