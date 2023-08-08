
import 'package:flutter/material.dart';
import 'account_settings.dart';
import 'dart:async';
import 'users.dart';

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
 Color homeButton = const Color.fromARGB(255, 255, 168, 168);
  Color chatButton = const Color.fromARGB(255, 255, 168, 168);
  Color grpButton = const Color.fromARGB(255, 255, 168, 168);
  Color accButton = const Color.fromARGB(255, 255, 168, 168);
  
  bool _isHomeLarge = false;
  bool _isChatLarge = false;
  bool _isgrpLarge = false;
  bool _isaccLarge = false;
  
  void _onHomeClicked() {
    setState(() {
      _isHomeLarge = true;
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _isHomeLarge = false;
        });
      });
      _currentIndex = 0;
    });
  }

    void _onChatClicked() {
    setState(() {
      _isChatLarge = true;
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _isChatLarge = false;
        });
      });
      _currentIndex = 3;
    });
  }

  void _onGroupClicked() {
    setState(() {
      _isgrpLarge = true;
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _isgrpLarge = false;
        });
      });
      _currentIndex = 2;
    });
  }
  void _onAccClicked() {
    setState(() {
      _isaccLarge = true;
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _isaccLarge = false;
        });
      });
      _currentIndex = 1;
    });
  }

  final List<Widget> _screens = [
    const ScrollableUserList(),
    const MySettings()
  ];

  int _currentIndex = 0;
  
 
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 151, 151),
      bottomNavigationBar: SizedBox(
        height: size.height* 0.08,
        child: Padding(
          padding:const EdgeInsets.only(bottom: 5,left: 10, right: 10),
          child: 
          Container(
            height: MediaQuery.of(context).size.height*0.08,
            decoration: const  BoxDecoration(
              borderRadius: BorderRadius.all( Radius.circular(45)),
              gradient: SweepGradient(
                center: Alignment.topCenter,
                startAngle: 1.0,
                endAngle: 9.0,
                tileMode: TileMode.clamp,
                colors: [Color.fromARGB(255, 240, 75, 97), Color.fromARGB(236, 230, 122, 46)]
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: AnimatedContainer(duration: const  Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: IconButton(
                      onPressed: _onHomeClicked,
                      icon: Icon(Icons.home_outlined, color: homeButton),
                      iconSize: _isHomeLarge ? 40 : 30,
                      splashRadius: 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: AnimatedContainer(duration: const  Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: IconButton(
                      onPressed: _onChatClicked,
                      icon: Icon(Icons.groups_2_outlined, color:chatButton),
                      iconSize: _isChatLarge ? 40 : 35,
                      splashRadius: 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: AnimatedContainer(duration: const  Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: IconButton(
                      onPressed: _onGroupClicked,
                      icon: Icon(Icons.circle_notifications_outlined, color:grpButton),
                      iconSize: _isgrpLarge ? 40 : 32,
                      splashRadius: 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: AnimatedContainer(duration: const  Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: IconButton(
                      onPressed: _onAccClicked,
                      icon: Icon(Icons.account_circle_outlined, color:accButton),
                      iconSize: _isaccLarge ? 40 : 32,
                      splashRadius: 1,
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
    ),
      body: _screens[_currentIndex]
    );
  }
}

//   void _navigateToScreen(int index) {
//     var route = PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) {
//         return _screens[index];
//       },
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(0.0, 1.0);
//         const end = Offset.zero;
//         const curve = Curves.easeInOut;

//         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );

//     Navigator.push(context, route);
    
//   }
// }