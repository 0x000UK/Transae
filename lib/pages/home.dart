
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
 Color homeButton = Colors.grey;
  Color chatButton = Colors.grey;
  Color grpButton = Colors.grey;
  Color accButton = Colors.grey;
  
  bool _isHomeLarge = false;
  bool _isChatLarge = false;
  bool _isgrpLarge = false;
  bool _isaccLarge = false;
  
  void _onHomeClicked() {
    setState(() {
      _isHomeLarge = true;
      homeButton =Color.fromARGB(255, 244, 151, 176);
      chatButton = grpButton = accButton = Colors.grey;
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
      chatButton = Color.fromARGB(255, 244, 151, 176);
      homeButton = grpButton = accButton = Colors.grey;
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _isChatLarge = false;
        });
      });
      _currentIndex = 1;
    });
  }

  void _onGroupClicked() {
    setState(() {
      _isgrpLarge = true;
      grpButton = Color.fromARGB(255, 214, 71, 143);
      chatButton = homeButton = accButton =  Colors.grey;
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
      grpButton = Color.fromARGB(255, 214, 71, 143);
      chatButton = homeButton = grpButton = Colors.grey;
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _isaccLarge = false;
        });
      });
      _currentIndex = 3;
    });
  }
  



  final List<Widget> _screens = [
    const ScrollableUserList(),
    const MySettings()
  ];

  int _currentIndex = 0;
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.deepOrangeAccent,
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height*0.08,
        decoration: const BoxDecoration(
          //color: Color.fromARGB(255, 108, 11, 165),
          gradient: SweepGradient(
            colors: [ Color.fromARGB(255, 176, 39, 114),Colors.deepOrangeAccent,],
            center: Alignment.topRight,
            tileMode: TileMode.repeated
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
                  icon: Icon(Icons.home, color: homeButton),
                  iconSize: _isHomeLarge ? 35 : 30,
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
                  icon: Icon(Icons.chat, color:chatButton),
                  iconSize: _isChatLarge ? 35 : 30,
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
                  icon: Icon(Icons.group, color:grpButton),
                  iconSize: _isgrpLarge ? 40 : 30,
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
                  icon: Icon(Icons.settings, color:accButton),
                  iconSize: _isaccLarge ? 40 : 30,
                  splashRadius: 1,
                ),
              ),
            ),
          ]
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