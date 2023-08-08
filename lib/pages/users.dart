import 'package:flutter/material.dart';
import 'dart:ui';

class ScrollableUserList extends StatefulWidget {
  const ScrollableUserList({super.key});

  @override
  State<ScrollableUserList> createState() => _ScrollableUserListState();
}

class _ScrollableUserListState extends State<ScrollableUserList>
  with SingleTickerProviderStateMixin {
  final List<User> userList = [
    User(id: "1", name: "John"),
    User(id: "2", name: "Alice"),
    User(id: "3", name: "alex"),
    User(id: "4", name: "Bob"),
    User(id: "5", name: "sam"),
    User(id: "6", name: "dominic"),
    User(id: "7", name: "cliff"),
    User(id: "8", name: "lockne"),
    User(id: "9", name: "harry"),
    User(id: "10", name: "kane"),
    User(id: "11", name: "sara"),
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Tab 1', 'Tab 2', 'Tab 3'];
    Size size = MediaQuery.of(context).size;

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
                        IconButton(
                          padding: const EdgeInsets.only(right: 10),
                          onPressed: () => {},
                          icon:const Icon(Icons.search, size: 30,),
                          color:  Color.fromARGB(225, 250, 79, 79),
                          splashRadius: 1,

                        ),
                        IconButton(
                          onPressed: () => {},
                          icon:const Icon(Icons.more_vert, size: 30,),
                          color:  Color.fromARGB(225, 250, 79, 79),
                          splashRadius: 1,
                        )
                      ],
                      elevation: 0.0,
                    )
                  ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: BoomBam(60.0),
                ),
              ];
            },
            body:Padding(
              padding:const EdgeInsets.all(10),
              child :Container(
                padding:const EdgeInsets.all(5.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(200, 255, 186, 186),
                  borderRadius:  BorderRadius.all(Radius.circular(30))
                ),
                child : TabBarView(
                    children: tabs.map(
                      (String name) {
                        return const CustomScrollView(
                          slivers: [
                            Messages(),
                          ],
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

class User {
  final String id;
  final String name;

  User({required this.id, required this.name});
}

class BoomBam extends SliverPersistentHeaderDelegate {
  final double size;

  BoomBam(this.size);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color.fromARGB(255, 255, 151, 151),
      height: size,
      child: const TabBar(
        indicatorWeight: 3,
        indicatorColor:  Color.fromARGB(225, 250, 79, 79),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        tabs: <Widget>[

          Tab(child: Text("Chats", style: TextStyle(fontSize: 20)),),
          Tab(child: Text("Groups", style: TextStyle(fontSize: 20)),),
          Tab(child: Text("Story", style: TextStyle(fontSize: 20)),),
        ],
      ),
    );
  }

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(BoomBam oldDelegate) {
    return oldDelegate.size != size;
  }
}

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage:NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
            ),
            title:Text(
              "Mr. H",
              style: TextStyle(
                fontSize: 20
              ),
            
            ),
            subtitle: Text("Hey there, Isn't it cool ?"),
            minVerticalPadding: 20,
          );
        },
      ),
    );
  }
}
