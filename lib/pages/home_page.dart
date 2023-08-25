import 'package:firebase_app/Models/UserModel.dart';
import 'package:firebase_app/Widgets/colors.dart';
import 'package:firebase_app/Widgets/navigation_routes.dart';
import 'package:firebase_app/Widgets/warnings.dart';
import 'package:firebase_app/pages/Tabs/chat_page.dart';
import 'package:firebase_app/pages/Tabs/group_page.dart';
import 'package:firebase_app/pages/Tabs/story_page.dart';
import 'package:firebase_app/pages/auth/login.dart';
import 'package:firebase_app/pages/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScrollableUserList extends StatefulWidget {
  const ScrollableUserList({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<ScrollableUserList> createState() => _ScrollableUserListState();
}

class _ScrollableUserListState extends State<ScrollableUserList>
  with TickerProviderStateMixin {


  final List<IconData> _tabAddIcons = [
    Icons.person_add_alt,
    Icons.group_add_outlined,
    Icons.add_circle_outline
  ];
  late TabController tabController;
  late AnimationController _animationController;
  late ScrollController scrollController;

  bool _isExpanded = false;
  int lastTab = 0;
  int _currIndex = 0;
  int chatNum = 0;
  int activeTab = 0;

  @override
  void initState() {
    super.initState();

    tabController =
        TabController(length: 3, vsync: this, initialIndex: activeTab);
    _animationController = AnimationController(
        vsync: this, duration:const Duration(milliseconds: 400));
    
    scrollController = ScrollController();




    tabController.addListener(() {
      if (tabController.index != activeTab) {
        setState(() {
          activeTab = tabController.index;
        });
      }
      if (tabController.index == 2) {
        setState(() {
          _isExpanded = false;
          _currIndex = 0;
        });
      }
      if (tabController.indexIsChanging) {
        setState(() {
        if (tabController.animation!.value == tabController.index.toDouble()) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
        });
      }
    });

    
  }

  @override
  void dispose() {
    tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> tabs = <Widget> [
      MyChatPageTab(userModel: widget.userModel),
      MyGroupTabPage(userModel: widget.userModel),
      const MyStoryPage()
    ];

    return SafeArea(
      maintainBottomViewPadding: true,
      child: DefaultTabController(
      length: 3,
      initialIndex: 1,
        child: Scaffold(
          backgroundColor:ThemeColors.orange,
          body: NestedScrollView(
            controller: scrollController,
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  snap: true,
                  floating: true,
                  elevation: 0.0,
                  flexibleSpace:AppBar(
                    backgroundColor: ThemeColors.orange,
                    title: const Text('BoomBam',
                      style: TextStyle(
                        fontSize: 30,
                        color: ThemeColors.redorange
                      ),
                    ),
                    actions: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: _isExpanded ? 250.0 : 0.0,
                        height: 50.0,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeColors.lightorange,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(45.0)),
                            ),
                            hintText: "Search...",
                            suffixIcon: IconButton(onPressed: (){}, icon:const Icon(Icons.search), iconSize: _isExpanded? 30: 0 ,)
                          ),
                          enabled: _isExpanded,
                        ),
                      ),
                      IconButton(
                        splashRadius: 1,
                        iconSize: 30,
                        color: ThemeColors.redorange,
                        icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            transitionBuilder: (child, anim) => RotationTransition(
                                  turns: child.key == const ValueKey('search')
                                      ? Tween<double>(begin: 0.75, end: 1.0).animate(anim)
                                      : Tween<double>(begin: 1.0, end: 0.75).animate(anim),
                                  child: ScaleTransition(scale: anim, child: child),
                                ),
                            child: tabController.index == 2? null: _currIndex == 0
                                ? const Icon(Icons.search, key:ValueKey('search'))
                                : const Icon(
                                    Icons.close,
                                    key: ValueKey('close'),
                                  )),
                        onPressed: () {
                          if(tabController.index != 2) {
                          setState(() {
                            _currIndex = _currIndex == 0 ? 1 : 0;
                            _isExpanded = !_isExpanded;
                          });
                          }
                        },
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child
                          );
                        },
                        child: IconButton(
                          key: ValueKey<int>(tabController.index),
                          icon: Icon(_tabAddIcons[tabController.index],
                            color: ThemeColors.redorange,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              switch (tabController.index) {
                                case 0 : Navigator.of(context).push(slideTransitionBuilder( MysearchPage(userModel: widget.userModel,))); break;
                                case 1 : break;
                                default: break;
                              }
                            });
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () => {
                          showMenu(
                            context: context, 
                            position: const RelativeRect.fromLTRB(100, 50, 50, 0), 
                            elevation: 10,
                            items: [
                              PopupMenuItem(
                                child: ListTile(
                                  leading:const Icon(Icons.logout_outlined),
                                  title:const Text('Logout'),
                                  onTap: () async {
                                    try {
                                      await FirebaseAuth.instance.signOut();
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyLogin()));
                                    } catch (error) {
                                      showWarning(context, error);
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        },
                        icon:const Icon(Icons.more_vert, size: 30,),
                        color: ThemeColors.redorange,
                        splashRadius: 1,
                      )
                    ],
                      elevation: 0.0,
                    )
                  ),
              ),
              // SliverOverlapInjector(
              //             handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              //           ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: Tabs(50.0, tabController),
                ),
              ];
            },
            body:Padding(
              padding:const EdgeInsets.fromLTRB(15, 15,15, 10),
              child :Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: ThemeColors.lightorange,
                  borderRadius:  BorderRadius.all(Radius.circular(30))
                ),
                child : TabBarView(
                  controller: tabController,
                  physics:const BouncingScrollPhysics(),
                  children: tabs.map((content ) {
                    return CustomScrollView(

                      key: Key(content.toString()),
                      slivers: [
                        
                        content],
                    );
                  }).toList(),
                  )
                )
              )
            )
          )
        )
    );
  }
}

class UserChatModel {
  final String id;
  final String name;
  final String messageText;
  final String imageURL;
  final String time;

  UserChatModel({
    required this.id, 
    required this.name,
    required this.imageURL,
    required this.messageText,
    required this.time,
  });
}

class Tabs extends SliverPersistentHeaderDelegate {
  final double size;
  final TabController tabController;

  Tabs(this.size, this.tabController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: ThemeColors.orange,
      height: size,
      child: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3,
        indicatorColor: ThemeColors.redorange,
        labelColor: ThemeColors.redorange,
        unselectedLabelColor: Colors.white60,
        tabs: const <Widget> [
          Tab(child: Icon(Icons.chat_outlined, size: 25)),
          Tab(child: Icon(Icons.question_answer_outlined, size: 25)),
          Tab(child: Icon(Icons.camera, size: 28)),
        ],
      ),
    );
  }

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(Tabs oldDelegate) {
    return oldDelegate.size != size;
  }
}


// PageRouteBuilder slideTransitionBuilder(Widget page) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(1.0, 0.0); // Start the slide from right
//       const end = Offset.zero;
//       const curve = Curves.easeInOut;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       var offsetAnimation = animation.drive(tween);

//       return SlideTransition(position: offsetAnimation, child: child);
//     },
//   );
// }

