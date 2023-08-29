import 'package:firebase_app/Models/user_model.dart';
import 'package:firebase_app/Widgets/navigation_routes.dart';
import 'package:firebase_app/pages/Settings/account.dart';
import 'package:firebase_app/pages/Settings/appearance.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Stack(
        children: [
           NestedScrollView(
            physics:const BouncingScrollPhysics(),
            controller: scrollController,
            headerSliverBuilder: (context, value) {
              return [
               SliverAppBar(
                  backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                  title: Text("   Settings", style: Theme.of(context).textTheme.displayMedium),
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
              padding:const EdgeInsets.only(top: 15, bottom: 10, left: 15, right: 15),
              child: Container ( 
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: const BorderRadius.all(Radius.circular(30))
                ),
                child : ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: ListView(
                    children: [
                      Container(
                        padding:const EdgeInsets.only(top: 20,left: 15, bottom: 0),
                        height: 80,
                        alignment: Alignment.bottomLeft,
                        child:  Text(
                          'User Settings',
                          style: Theme.of(context).textTheme.displaySmall//TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ),
                      ListTile(
                        onTap: (){
                          Navigator.of(context).push(slideTransitionBuilder(const MyAccount()));
                        },
                        leading: const Icon(Icons.portrait, size: 24,),
                        title:  Text("My Account", style: Theme.of(context).textTheme.titleMedium),
                      ),
                      ListTile(
                        onTap: (){},
                        leading: const Icon(Icons.edit_outlined, size: 24,),
                        title: Text("Profile", style: Theme.of(context).textTheme.titleMedium),
                      ),
                      ListTile(
                        onTap: (){},
                        leading: const Icon(Icons.settings_outlined, size: 24,),
                        title: Text("Set Status", style: Theme.of(context).textTheme.titleMedium),
                        trailing: const Text("Online"),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20,left: 20, bottom: 10),
                        height: 60,
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'App Settings',
                          style: Theme.of(context).textTheme.displaySmall,
                        )
                      ),
                      ListTile(
                        onTap: (){
                          Navigator.of(context).push(slideTransitionBuilder(const Appearance()));
                        },
                        leading: const Icon(Icons.color_lens_outlined, size: 24),
                        title: Text("Appearance", style: Theme.of(context).textTheme.titleMedium),
                      ),
                      ListTile(
                        onTap: (){},
                        leading: const Icon(Icons.language, size: 24),
                        title: Text("Language", style: Theme.of(context).textTheme.titleMedium)
                      ),
                      ListTile(
                        onTap: (){},
                        leading: const Icon(Icons.edit_notifications_outlined, size: 24),
                        title: Text("Notifications", style: Theme.of(context).textTheme.titleMedium),
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
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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