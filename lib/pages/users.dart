import 'package:flutter/material.dart';

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
    //Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 255, 168, 168),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
            snap: true,
            shadowColor: const Color.fromARGB(0, 0, 0, 0),
            floating: true,
            expandedHeight: 10,
            flexibleSpace:AppBar(
                //toolbarOpacity: 1,
                backgroundColor:const Color.fromARGB(255, 255, 151, 151),
                title: const Text('BoomBam',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(226, 255, 83, 83)
                  ),
                ),
                actions: [
                  IconButton(
                    padding: const EdgeInsets.only(right: 10),
                    onPressed: () => {},
                    icon:const Icon(Icons.search)
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon:const Icon(Icons.more_vert)
                  )
                ],
              )
            ),
          ];
        },
        body: 
        // Container(
        //   decoration:const BoxDecoration(
        //   color: Color.fromARGB(192, 249, 195, 195),
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(10),
        //     topRight: Radius.circular(10)
        //   )
        //   ),
        //   child :
            ListView.builder(
            itemCount: userList.length, // Replace with your actual item count
            itemBuilder: (context, index) {
            return ListTile (
                leading: const CircleAvatar(
                  radius: 45,
                ),
                title: Text(
                  userList[index].name,
                  style: const TextStyle(fontSize: 25),
                ),
                minVerticalPadding: 25,
                minLeadingWidth: 10,
                horizontalTitleGap: 5,
                onTap: () => {},
            );
            }
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
