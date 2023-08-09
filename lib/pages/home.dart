
import 'package:flutter/material.dart';
import 'account_settings.dart';
import 'chats.dart';
import 'users.dart';

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
 Color homeColor = const Color.fromARGB(255, 255, 168, 168);
  Color chatColor = const Color.fromARGB(255, 255, 168, 168);
  Color grpColor = const Color.fromARGB(255, 255, 168, 168);
  Color accColor = const Color.fromARGB(255, 255, 168, 168);

  IconData homeIcon = Icons.home_outlined;
  IconData freindsIcon = Icons.groups_2_outlined;
  IconData notifyIcon = Icons.notifications_outlined;
  IconData accIcon = Icons.account_circle_outlined;
  
  bool lastButton= true;
  
  void _onHomeClicked() {
    setState(() {
      homeIcon = Icons.home;
      freindsIcon = Icons.groups_2_outlined;
      notifyIcon = Icons.notifications_outlined;
      accIcon = Icons.account_circle_outlined;
      _currentIndex = 0;
    });
  }

    void _onFrndClicked() {
    setState(() {
      homeIcon = Icons.home_outlined;
      freindsIcon = Icons.groups_2;
      notifyIcon = Icons.notifications_outlined;
      accIcon = Icons.account_circle_outlined;
      _currentIndex = 1;
    });
  }

  void _onNotifyClicked() {
    setState(() {
      homeIcon = Icons.home_outlined;
      freindsIcon = Icons.groups_2_outlined;
      notifyIcon = Icons.notifications;
      accIcon = Icons.account_circle_outlined;
      _currentIndex = 2;
    });
  }
  void _onAccClicked() {
    setState(() {
      homeIcon = Icons.home_outlined;
      freindsIcon = Icons.groups_2_outlined;
      notifyIcon = Icons.notifications_outlined;
      accIcon = Icons.account_circle;
      _currentIndex = 3;
    });
  }

  final List<Widget> _screens = [
    const ScrollableUserList(),
    const MyMessagesPage(index: 1,name: "qwerty",),
    const MyMessagesPage(index: 2,name: "asdfgh",),
    const MySettings(),
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
                      icon: Icon(homeIcon, color: homeColor),
                      iconSize: 30,
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
                      onPressed: _onFrndClicked,
                      icon: Icon(freindsIcon, color:chatColor),
                      iconSize: 35,
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
                      onPressed: _onNotifyClicked,
                      icon: Icon(notifyIcon, color:grpColor),
                      iconSize: 28,
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
                      icon: Icon(accIcon, color:accColor),
                      iconSize:32,
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