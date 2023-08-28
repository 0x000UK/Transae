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
          displayLarge: TextStyle(color: LightThemeColors.redorange, fontSize: 28),
          titleMedium: TextStyle(color: Colors.black, fontSize: 20),
          displaySmall: TextStyle(color: Colors.black, fontSize: 20),
          titleSmall: TextStyle(color: Colors.black45, fontSize: 18)
        ),
        bottomNavigationBarTheme:const BottomNavigationBarThemeData(
          backgroundColor: ThemeColors.redorange,
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
            iconColor: MaterialStatePropertyAll(LightThemeColors.redorange),
            iconSize: MaterialStatePropertyAll(25),
            animationDuration: Duration(milliseconds: 300)
          )
        ),
        iconTheme:const IconThemeData(
          size: 25,
          fill: 0.2,
          weight: 10,
          grade: 20,
          color: LightThemeColors.redorange
        ),
        tabBarTheme: const TabBarTheme(
          indicator: BoxDecoration(
            color: LightThemeColors.redorange,
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          dividerColor: Colors.transparent,
          labelColor: Colors.white,
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
        primaryTextTheme: const  TextTheme(
          displayLarge: TextStyle(color: LightThemeColors.redorange, fontSize: 25),
          titleMedium: TextStyle(color: Colors.black, fontSize: 18),
          displaySmall: TextStyle(color: Colors.black, fontSize: 15),
          titleSmall: TextStyle(color: Colors.black, fontSize: 15)
        ),
        bottomNavigationBarTheme:const BottomNavigationBarThemeData(
          backgroundColor: ThemeColors.redorange,
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
        iconTheme:const IconThemeData(
          size: 25,
          fill: 0.2,
          weight: 10,
          grade: 20,
          color: LightThemeColors.redorange
        ),
        tabBarTheme:const TabBarTheme(
          indicatorColor: LightThemeColors.redorange,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colors.white38,
          tabAlignment: TabAlignment.center
        )
    );
  }
}