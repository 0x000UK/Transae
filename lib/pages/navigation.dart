
import 'package:firebase_app/Models/user_model.dart';
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
  int currentPageIndex = 0;
  
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
      MySettings(userModel : widget.userModel),
    ];

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: _buildBottomBar(),
        // onDestinationSelected: (int index) {
        //   setState(() {
        //     currentPageIndex = index;
        //   });
        // },
        // indicatorColor: Colors.amber[800],
        // selectedIndex: currentPageIndex,
        // destinations: const <Widget>[
        //   Icon(Icons.home_max_outlined, size: 25),
        //   Icon(Icons.groups_2_outlined, size: 25),
        //   Icon(Icons.notifications_outlined, size: 25),
        //   Icon(Icons.account_circle_outlined, size: 25),
          
        // ],
        // height: size.height* 0.08,
      //),
      // bottomNavigationBar: SizedBox(
      //   height: size.height* 0.08,
      //   child: Padding(
      //     padding:const EdgeInsets.only(bottom: 5,left: 15, right: 15),
      //     child: 
      //     Container(
      //       height: MediaQuery.of(context).size.height*0.08,
      //       decoration:  BoxDecoration(
      //         borderRadius: const BorderRadius.all( Radius.circular(45)),
      //         color: Theme.of(context).bottomNavigationBarTheme.backgroundColor
      //       ),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           SizedBox(
      //             width: 60,
      //             height: 60,
      //             child: AnimatedContainer(duration: const  Duration(milliseconds: 400),
      //               curve: Curves.easeInOut,
      //               child: IconButton(
      //                 onPressed: _onHomeClicked,
      //                 icon: Icon(homeIcon, color: homeColor),
      //                 iconSize: 30,
      //                 splashRadius: 1,
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             width: 60,
      //             height: 60,
      //             child: AnimatedContainer(duration: const  Duration(milliseconds: 400),
      //               curve: Curves.easeInOut,
      //               child: IconButton(
      //                 onPressed: _onFrndClicked,
      //                 icon: Icon(freindsIcon, color:chatColor),
      //                 iconSize: 35,
      //                 splashRadius: 1,
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             width: 60,
      //             height: 60,
      //             child: AnimatedContainer(duration: const  Duration(milliseconds: 400),
      //               curve: Curves.easeInOut,
      //               child: IconButton(
      //                 onPressed: _onNotifyClicked,
      //                 icon: Icon(notifyIcon, color:grpColor),
      //                 iconSize: 30,
      //                 splashRadius: 1,
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             width: 60,
      //             height: 60,
      //             child: AnimatedContainer(duration: const  Duration(milliseconds: 400),
      //               curve: Curves.easeInOut,
      //               child: IconButton(
      //                 onPressed: _onAccClicked,
      //                 icon: Icon(accIcon, color:accColor),
      //                 iconSize:34,
      //                 splashRadius: 1,
      //               ),
      //             ),
      //           ),
      //         ]
      //       ),
      //     ),
      //   ),
      // ),
      body: screens[_currentIndex]
    );
  }
  Widget _buildBottomBar(){
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          activeColor: Colors.white,
          inactiveColor: Colors.grey,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon:const  Icon(Icons.people),
          title:const  Text('Users'),
          activeColor: Colors.white,
          inactiveColor: Colors.grey,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const  Icon(Icons.message),
          title: const Text('Messages '),
          activeColor: Colors.pink,
          inactiveColor: Colors.grey,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon:const  Icon(Icons.settings),
          title: const Text('Settings'),
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class CustomAnimatedBottomBar extends StatelessWidget {

  const CustomAnimatedBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 27,
    this.backgroundColor,
    this.itemCornerRadius = 60,
    this.containerHeight = 40,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  }) : assert(items.length >= 2 && items.length <= 5),
        super(key: key);
  
  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;

    return Padding (padding:const EdgeInsets.only(bottom: 10, left : 15, right:  15, top: 10),
    child : Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).primaryColor,
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    )
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.iconSize,
    this.curve = Curves.linear,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? 100: 50,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics:const NeverScrollableScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
            color: isSelected ? backgroundColor: Colors.transparent,
              borderRadius: BorderRadius.circular(60)
            ),
            width: isSelected ? 90 : 50,
            padding:const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                    size: iconSize,
                    color: isSelected
                        ? item.activeColor
                        : item.inactiveColor == null
                        ? item.activeColor
                        : item.inactiveColor,
                  ),
                  child: item.icon,
                ),
                if (isSelected)
                  Expanded(
                    child: Container(
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                          color: item.activeColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                        ),
                        maxLines: 1,
                        textAlign: item.textAlign,
                        child: item.title,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {

  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
  });

  final Widget icon;
  final Widget title;
  final Color activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;

}