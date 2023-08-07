import 'package:flutter/material.dart';

Route _createPageRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return const MySettings();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0); // Start position of the page
      var end = Offset.zero; // End position of the page
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      // Slide the page vertically from bottom to top.
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class page2 extends StatefulWidget {
  const page2({super.key});

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Page 2'),
      ),
    );
  }
}

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.width * 0.6,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/landscape.jpg'),
                  fit: BoxFit.cover)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  splashRadius: 1,
                  onPressed: (){}, 
                  icon:const Icon(
                    Icons.edit,
                    color: Colors.blue,
                    size: 30,
                  )
                )
              ],
            )
          ),
          Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: size.width*0.6,
                left: size.width*0.5,

                child:  const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/Profile.png'),
                )
              )
            ],
          )
        ]
      )
    );
  }
}
