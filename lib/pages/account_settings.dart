import 'package:firebase_app/Models/user_model.dart';
import 'package:firebase_app/Widgets/colors.dart';
import 'package:firebase_app/Widgets/navigation_routes.dart';
import 'package:firebase_app/pages/Settings/account.dart';
import 'package:flutter/material.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> with SingleTickerProviderStateMixin {

  late ScrollController scrollController;
  late double _avatarOpacity;
  late double expandedHight;

  bool showPic = false;

  double _avatarRadius = 60.0;


  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() { 
      setState(() {
        _avatarRadius = 60.0 - (scrollController.offset );
        _avatarRadius = _avatarRadius.clamp(30.0, 60.0);
        _avatarOpacity = 1.0 - (scrollController.offset * 0.001);
      _avatarOpacity = _avatarOpacity.clamp(0.2, 1.0);
      });
    }
    );
  }

    @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  double get vertical {
    double res = expandedHight;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      if (offset < (res - kToolbarHeight)) {
        res -= offset;
      } else {
        res = kToolbarHeight;
        setState(() {
          showPic = !showPic;
        });
      }
    }
    return res;
  }
  double get horizontal {
    double res = expandedHight;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      if (offset < (res - kToolbarHeight)) {
        res -= offset;
      } else {
        res = kToolbarHeight;
        setState(() {
          showPic = !showPic;
        });
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {

    Size size  =  MediaQuery.of(context).size;
    expandedHight = size.height*0.2;
    _avatarOpacity = 1;
    return Scaffold(
      backgroundColor: ThemeColors.orange,

      body: Stack(
        children: [
           NestedScrollView(
            physics:const BouncingScrollPhysics(),
            controller: scrollController,
            headerSliverBuilder: (context, value) {
              return [
               SliverAppBar(
                  // leading: Row(
                  //   children: [
                  //     const SizedBox(width: 10),
                  //     showPic? CircleAvatar(
                  //       child: Image.asset(
                  //         'assets/images/Profile.png',
                  //       ),
                  //     ): const SizedBox(),
                  //   ],
                  // ),
                  backgroundColor:ThemeColors.orange,
                  title:const Text("   Settings", style: TextStyle(fontSize: 25),),
                  //expandedHeight:180, //MediaQuery.of(context).size.height*0.2,
                  expandedHeight: expandedHight,
                  collapsedHeight: 60,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Image.asset(
                      // Image background for the top widget
                      'assets/images/landscape.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  pinned: true,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(side: BorderSide.none , borderRadius: BorderRadius.all(Radius.circular(25))),
                ),
              ];
            },
            body: Padding (
              padding:const EdgeInsets.all(15),
              child: Container ( 
                decoration: const BoxDecoration(
                  color: ThemeColors.lightorange,
                  borderRadius:  BorderRadius.all(Radius.circular(30))
                ),
                child : ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: ListView(
                    children: [
                      Container(
                        padding:const EdgeInsets.only(left: 20, bottom: 20),
                        height: 40,
                        child: const Text(
                          'User Settings',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ),
                      ListTile(
                        onTap: (){
                          Navigator.of(context).push(slideTransitionBuilder(const MyAccount()));
                        },
                        leading: const Icon(Icons.portrait, size: 30,),
                        title: const Text("My Account", style: TextStyle(fontSize: 20),),
                      ),
                      ListTile(
                        onTap: (){},
                        leading: const Icon(Icons.edit_outlined, size: 30,),
                        title: const Text("Profile", style: TextStyle(fontSize: 20),),
                      ),
                      ListTile(
                        onTap: (){},
                        leading: const Icon(Icons.settings_outlined, size: 30,),
                        title: const Text("Set Status", style: TextStyle(fontSize: 20)),
                        trailing: const Text("Online"),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 30,left: 20, bottom: 20),
                        height: 80,
                        child: const Text(
                          'App Settings',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ),
                      ListTile(
                        onTap: (){},
                        leading: const Icon(Icons.color_lens_outlined, size: 30,),
                        title: const Text("Appearance", style: TextStyle(fontSize: 20)),
                      ),
                      ListTile(
                        onTap: (){},
                        leading: const Icon(Icons.language, size: 30,),
                        title: const Text("Language", style: TextStyle(fontSize: 20)),
                      ),
                      ListTile(
                        onTap: (){},
                        leading: const Icon(Icons.edit_notifications_outlined, size: 30,),
                        title: const Text("Notifications", style: TextStyle(fontSize: 20)),
                      ),

                    ],
                  ),
                )
              )
            )
          ),
          Positioned(
            //right: -horizontal,
            top: vertical-20,
            width: MediaQuery.of(context).size.width,
            child: CircleAvatar(
              backgroundColor: ThemeColors.orange,
              radius: _avatarRadius,
              child: Opacity(
                opacity: _avatarOpacity,
                child: Image.asset(
                'assets/images/Profile.png',
                width: _avatarRadius+50,
              ),
              
              )
            )
          )
        ],
      )
    );
  }
}