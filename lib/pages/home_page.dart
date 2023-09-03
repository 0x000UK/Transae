import 'package:firebase_app/Models/user_model.dart';
import 'package:firebase_app/Widgets/navigation_routes.dart';
import 'package:firebase_app/Widgets/warnings.dart';
import 'package:firebase_app/pages/Tabs/chat_page.dart';
import 'package:firebase_app/pages/Tabs/group_page.dart';
import 'package:firebase_app/pages/Tabs/story_page.dart';
import 'package:firebase_app/pages/auth/login.dart';
import 'package:firebase_app/pages/search_page.dart';
import 'package:firebase_app/service/Provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrollableUserList extends ConsumerStatefulWidget {
  const ScrollableUserList({super.key, required this.userModel});

  final UserModel userModel;

  @override
  ConsumerState<ScrollableUserList> createState() => _ScrollableUserListState();
}

class _ScrollableUserListState extends ConsumerState<ScrollableUserList>
  with TickerProviderStateMixin {


  final List<IconData> _tabAddIcons = [
    Icons.person_add_alt,
    Icons.group_add_outlined,
    Icons.add_circle_outline
  ];
  late TabController tabController;
  late AnimationController _animationController;
  late ScrollController scrollController;
  late UserModel? userModel;

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
    Size size = MediaQuery.of(context).size;
    final List<Widget> tabs = <Widget> [
      MyChatPageTab(userModel: widget.userModel),
      MyGroupTabPage(userModel: widget.userModel),
      const MyStoryPage()
    ];

    userModel = ref.read(userModelProviderState.notifier).state;
    return SafeArea(
      maintainBottomViewPadding: true,
      child: DefaultTabController(
      length: 3,
      initialIndex: 1,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,  //ThemeColors.orange,
          body: NestedScrollView(
            controller: scrollController,
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor ,
                  snap: true,
                  floating: true,
                  elevation: 0.0,
                  flexibleSpace:AppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    title: Text('BoomBam',
                      style: Theme.of(context).textTheme.displayLarge
                    ),
                    actionsIconTheme:const IconThemeData.fallback(),
                    actions: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: _isExpanded ? size.width-150 : 0.0,
                        
                        height: 50.0,
                        child: TextField(
                          //textAlignVertical: TextAlignVertical.top,
                          cursorHeight: 22,
                          style: Theme.of(context).textTheme.titleSmall,
                          decoration: InputDecoration(
                            
                            filled: true,
                            fillColor: Theme.of(context).primaryColorLight,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(45.0)),
                            ),
                           
                            suffixIcon: IconButton(onPressed: (){}, icon:const Icon(Icons.search), iconSize: _isExpanded? Theme.of(context).iconTheme.size: 0 ,)
                          ),
                          enabled: _isExpanded,
                        ),
                      ),
                      IconButton(
                        splashRadius: 1,
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
                            //color: Theme.of(context).popupMenuTheme.color,
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
                        icon: const Icon(Icons.more_vert),
                        splashRadius: 1,
                      )
                    ],
                      elevation: 0.0,
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: Tabs(50.0, tabController),
                ),
                
              ];
            },
            body:Padding(
              padding:const EdgeInsets.fromLTRB(10, 10,10, 10),
              child :
              
              Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius:const BorderRadius.all(Radius.circular(30))
                ),
                child : TabBarView(
                  controller: tabController,
                  physics:const BouncingScrollPhysics(),
                  children: tabs.map((content ) {
                    return CustomScrollView(

                      key: Key(content.toString()),
                      slivers: [
                        // SliverOverlapInjector(
                        //   // This is the flip side of the SliverOverlapAbsorber
                        //   // above.
                        //   handle:
                        //       NestedScrollView.sliverOverlapAbsorberHandleFor(
                        //           context),
                        // ),
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

class Tabs extends SliverPersistentHeaderDelegate {
  final double size;
  final TabController tabController;

  Tabs(this.size, this.tabController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: size,
      child: TabBar(
        controller: tabController,
        indicatorPadding:const EdgeInsets.only(top: 10, bottom: 10, right: 35, left: 35),
        tabs: const <Widget> [
          Tab(child: Icon(Icons.chat_outlined, size: 20,)),
          Tab(child: Icon(Icons.question_answer_outlined, size: 20,)),
          Tab(child: Icon(Icons.camera, size: 20,)),
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

