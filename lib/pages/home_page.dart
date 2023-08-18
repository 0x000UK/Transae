import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Models/UserModel.dart';
import 'package:firebase_app/Models/chat_room_model.dart';
import 'package:firebase_app/Widgets/Tabs.dart';
import 'package:firebase_app/pages/auth/login.dart';
import 'package:firebase_app/pages/search_page.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chats.dart';

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
        vsync: this, duration: tabController.animationDuration);

    tabController.addListener(() {
      if (tabController.index != activeTab) {
        setState(() {
          activeTab = tabController.index;
          _animationController.reset();
          _animationController.forward();
        });
      }
      if (tabController.index == 2) {
        setState(() {
          _isExpanded = false;
          _currIndex = 0;
        });
      }
      if (tabController.indexIsChanging) {
        if (tabController.animation!.value == tabController.index) {
          _animationController.value = tabController.animation!.value;
        }
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }
  final List<UserChatModel> userList = [
    UserChatModel(id: "1", name: 'Alexandre', imageURL: 'https//www.bla.com/pic.png', messageText: 'heheheh', time: '1:32'),
    UserChatModel(id: "2", name: 'Alex', imageURL: 'https//www.bla.com/pic.png', messageText: 'hey', time: '2:20'),
  ];

  @override
  Widget build(BuildContext context) {

    final List<String> tabNames =  [ 'chats', 'groups', 'story'];

    return SafeArea(
      maintainBottomViewPadding: true,
      child: DefaultTabController(
      length: 3,
      initialIndex: 1,
        child: Scaffold(
          backgroundColor:const Color.fromARGB(255, 255, 151, 151),
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  snap: true,
                  floating: true,
                  elevation: 0.0,
                  flexibleSpace:AppBar(
                    backgroundColor:const Color.fromARGB(255, 255, 151, 151),
                    title: const Text('BoomBam',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(225, 250, 79, 79)
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
                            fillColor: const Color.fromARGB(200, 255, 186, 186),
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
                        color: const Color.fromARGB(225, 250, 79, 79),
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
                        duration: tabController.animationDuration,
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: _animationController, 
                            child: child
                          );
                        },
                        child: IconButton(
                          key: ValueKey<int>(tabController.index),
                          icon: Icon(_tabAddIcons[tabController.index],
                            color: const Color.fromARGB(225, 250, 79, 79),
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
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        backgroundColor: const Color.fromARGB(205, 219, 30, 30),
                                        content: Text(
                                          error.toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                        duration: const Duration(seconds: 4),
                                      ));
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        },
                        icon:const Icon(Icons.more_vert, size: 30,),
                        color: const Color.fromARGB(225, 250, 79, 79),
                        splashRadius: 1,
                      )
                    ],
                      elevation: 0.0,
                    )
                  ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: Tabs(60.0, tabController),
                ),
              ];
            },
            body: Padding(
              padding:const EdgeInsets.fromLTRB(15, 15,15, 15),
              child :Container(
                padding:const EdgeInsets.all(5.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(200, 255, 186, 186),
                  borderRadius:  BorderRadius.all(Radius.circular(30))
                ),
                child : TabBarView(
                  controller: tabController,
                  physics:const BouncingScrollPhysics(),
                    children: tabNames.map(
                      (content ) {
                        return  StreamBuilder(
                          stream: FirebaseFirestore.instance.collection(content).where('members.${widget.userModel.uid}', isEqualTo: true).snapshots(),
                          builder: (context, snapshot){
                          Widget tabContent;
                          switch (content) {
                            case "chats": tabContent = UserTab( snapshot: snapshot,userModel: widget.userModel); break;
                            case "groups": tabContent = const GroupsTab(count: 0); break;
                            case "story": tabContent = const Story(); break;
                            default:
                              tabContent = const Center(
                                child: CircularProgressIndicator(),
                              ); break;
                          }
                          return CustomScrollView(
                            slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              fillOverscroll: true,
                              child: tabContent
                            )
                            ],
                          );
                          }
                        );
                      },
                    ).toList(),
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
      color: const Color.fromARGB(255, 255, 151, 151),
      height: size,
      child: TabBar(
        controller: tabController,
        indicatorWeight: 3,
        indicatorColor: const Color.fromARGB(225, 250, 79, 79),
        labelColor: const Color.fromARGB(255, 250, 79, 79),
        unselectedLabelColor: Colors.white60,
        tabs: const <Widget>[
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

class UserTab extends StatelessWidget {
  const UserTab({Key? key, required this.snapshot, required this.userModel}) : super(key: key);

  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    if(snapshot.connectionState == ConnectionState.active) {
      if(snapshot.hasData) {
        QuerySnapshot chatRoomSnapshot = snapshot.data as QuerySnapshot;

        if(chatRoomSnapshot.docs.isNotEmpty){
          return  SliverList(
            delegate: SliverChildBuilderDelegate( 
              (context, index) {
                // getting chatroommodel of snapshot
                ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                  chatRoomSnapshot.docs[index].data() as Map<String, dynamic>);
                //extracting members of chatroom as map
                Map<String, dynamic> members = chatRoomModel.members!;
                // converting member id to list
                List<String> memberKeys = members.keys.toList();

                // remove my key so that i know who is the other person
                memberKeys.remove(userModel.uid);

                return FutureBuilder(
                  future: DatabaseService.getUserDataByID(memberKeys[0]),
                  builder: (context, userData) {
                    if(userData.connectionState == ConnectionState.done){
                      // print("userdata connection done");
                      if(userData.data != null) {

                        UserModel targetUser = userData.data as UserModel;
                        return ListTile(
                          leading: Hero(
                            tag: 'profilepic$index',
                            child: CircleAvatar(
                              radius: 30,
                              //backgroundImage: NetworkImage(targetUser.profilepic.toString()),
                            ),
                          ),
                          title:  Text(
                            targetUser.userName.toString(),
                            style:const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(chatRoomModel.lastMessage.toString()),
                          minVerticalPadding: 20,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyChatRoom(
                                  chatroom: chatRoomModel,
                                  user: userModel,
                                  targetUser: targetUser,
                                  heroId: index
                                ),
                              ),
                            );
                          },
                        );
                      }else {
                        return emptyTabContent(tab: 'chats');
                      }
                    }else{
                      return emptyTabContent(tab: 'chats', text: 'connecton faild');
                    }
                  }
                );  
              },
              childCount: chatRoomSnapshot.docs.length,
            ),
          );
        } else {
          return emptyTabContent(tab: 'chats');
        }
      }else if(snapshot.hasError){
        return emptyTabContent(tab: 'chats', text: snapshot.error.toString());
      }else {
        return emptyTabContent(tab: 'chats');
      }
    }else {
      return  const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}

class GroupsTab extends StatelessWidget {
  const GroupsTab({Key? key, required this.count}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return //count == 0?
      Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Container(
              width: 400,
              height: 250,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/group.png"),
                    fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 20),
            const Text.rich(
              TextSpan(text: 'OOPS!!', children: [
                TextSpan(text: '  Sorry', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan( text: " Can't see anyone ", style: TextStyle(fontSize: 20)),
                TextSpan(text: '\nMay be Try joining any group'),
              ]),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        )
      );
        // : SliverList(
        //     delegate: SliverChildBuilderDelegate((context, index) {
        //       return ListTile(
        //         leading: Hero(
        //           tag: 'profilepic$index',
        //           child: const CircleAvatar(
        //             radius: 30,
        //             backgroundImage: NetworkImage(
        //                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
        //           ),
        //         ),
        //         title: const Text(
        //           "Mr. H",
        //           style: TextStyle(fontSize: 20),
        //         ),
        //         subtitle: const Text("Hey there, Isn't it cool ?"),
        //         minVerticalPadding: 20,
        //         onTap: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => const MyMessagesPage(
        //                 id: "2",
        //                 name: "Mr. k",
        //               ),
        //             ),
        //           );
        //         },
        //       );
        //     }, childCount: count),
        //   );
  }
}

class Story extends StatelessWidget {
  const Story({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Container(
              width: 400,
              height: 250,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/activity.png"),
                    fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 20),
            const Text.rich(
              TextSpan(text: 'OOPS!!', children: [
                TextSpan(text: '  Sorry', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan( text: " Can't see anyone ", style: TextStyle(fontSize: 20)),
                TextSpan(text: '\nMay be Try joining any group'),
              ]),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        )
      );
    // return SliverList(
    //   delegate: SliverChildBuilderDelegate((context, index) {
    //     return ListTile(
    //       leading: Hero(
    //         tag: 'profilepic$index',
    //         child: const CircleAvatar(
    //           radius: 30,
    //           backgroundImage: NetworkImage(
    //               "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
    //         ),
    //       ),
    //       title: const Text(
    //         "Mr. H",
    //         style: TextStyle(fontSize: 20),
    //       ),
    //       subtitle: const Text("Hey there, Isn't it cool ?"),
    //       minVerticalPadding: 20,
    //       onTap: () {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) =>const MyMessagesPage(
    //               id: "1",
    //               name: "Mr. k",
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   }, childCount: 1),
    // );
  }
}

PageRouteBuilder slideTransitionBuilder(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Start the slide from right
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

