import 'package:firebase_app/Widgets/colors.dart';
import 'package:flutter/material.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {

  late ScrollController scrollController;
  late double expandedHight;
  late double horizontalPos;

  double _avatarRadius = 60.0;


  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() => setState(() {
       _avatarRadius = 60.0 - (scrollController.offset * 0.1);
      // Ensure the radius doesn't go below a certain value
      _avatarRadius = _avatarRadius.clamp(30.0, 60.0);
    }));
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
      }
    }
    return res;
  }

    double get horizontal {
    double res = horizontalPos;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      if (offset < (res + kToolbarHeight)) {
        res -= offset;
      } else {
        res = kToolbarHeight;
      }
    }
    return res;
  }
  @override
  Widget build(BuildContext context) {

    Size size  =  MediaQuery.of(context).size;
    expandedHight = size.height*0.25;
    horizontalPos = size.width*0.2;

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
                  // leading: AnimatedPositioned(
                  //   duration: ,
                  //   child: ,
                  // ),
                  backgroundColor:ThemeColors.orange,
                  title:const Text("   Settings", style: TextStyle(fontSize: 25),),
                  //expandedHeight:180, //MediaQuery.of(context).size.height*0.2,
                  actions: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.edit))
                  ],
                  expandedHeight: size.height*0.25,
                  flexibleSpace: FlexibleSpaceBar(
                    
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
                // const SliverToBoxAdapter(
                //   child: SizedBox(height: 60,),
                // )
              ];
            },
            body:Padding (
              padding:const EdgeInsets.all(15),
              child: Container ( 
                decoration: const BoxDecoration(
                  color: ThemeColors.lightorange,
                  borderRadius:  BorderRadius.all(Radius.circular(30))
                ),
                child : ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                 child : ListView.builder(
                  physics:const NeverScrollableScrollPhysics(),
                  itemCount: 80,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      'text_string $index'.toUpperCase(),
                      style:const TextStyle(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                )
              )
            )
          ),
          Positioned(
            right: -horizontal,
            top: vertical,
            width: MediaQuery.of(context).size.width,
            child: CircleAvatar(
              backgroundColor: ThemeColors.orange,
              radius: _avatarRadius,
              child: Image.asset(
                'assets/images/Profile.png',
                width: 110,
              ),
            )
          )
        ],
      )
    );
  }
}