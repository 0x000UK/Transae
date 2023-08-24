
import 'package:firebase_app/Models/UserModel.dart';
import 'package:firebase_app/Widgets/colors.dart';
import 'package:flutter/material.dart';
import 'account_settings.dart';
import 'home_page.dart';

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.userModel});
  final UserModel  userModel;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  //Map arguments = {};

 Color homeColor = const Color.fromARGB(255, 255, 168, 168);
  Color chatColor = const Color.fromARGB(255, 255, 168, 168);
  Color grpColor = const Color.fromARGB(255, 255, 168, 168);
  Color accColor = const Color.fromARGB(255, 255, 168, 168);

  IconData homeIcon = Icons.home;
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
      _currentIndex = 1;
    });
  }
  int _currentIndex = 0;
  
 
  @override
  Widget build(BuildContext context) {

    final List<Widget> screens = [
      ScrollableUserList(userModel : widget.userModel),
      //const MyMessagesPage(id: '1',name: "qwerty",),
      //const MyMessagesPage(id : '2',name: "asdfgh",),
      const MySettings(),
    ];

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ThemeColors.orange,
      bottomNavigationBar: SizedBox(
        height: size.height* 0.08,
        child: Padding(
          padding:const EdgeInsets.only(bottom: 5,left: 15, right: 15),
          child: 
          Container(
            height: MediaQuery.of(context).size.height*0.08,
            decoration: const  BoxDecoration(
              borderRadius: BorderRadius.all( Radius.circular(45)),
              gradient: SweepGradient(
                center: Alignment.topRight,
                startAngle: 2,
                endAngle:9,
                tileMode: TileMode.clamp,
               // colors: [Color.fromARGB(255, 240, 75, 97), Color.fromARGB(236, 230, 122, 46)]
               colors: [Color.fromARGB(242, 235, 36, 246), Color.fromRGBO(107, 46, 230, 0.922)]
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
                      onPressed: _onAccClicked,
                      icon: Icon(accIcon, color:accColor),
                      iconSize:34,
                      splashRadius: 1,
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
      body: screens[_currentIndex]
    );
  }
}