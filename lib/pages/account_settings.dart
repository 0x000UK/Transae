import 'package:flutter/material.dart';

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
    return Scaffold(
        body: Container(
      color: const Color.fromARGB(255, 255, 168, 168),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
              expandedHeight: 200,
              collapsedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  // Image background for the top widget
                  'assets/images/landscape.jpg',
                  fit: BoxFit.cover,
                ),
              )),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 20, // Number of items in the ListView
            ),
          )
        ],
      ),
    )
        //appBar: ,
        // body: Container (
        //   height: size.height,
        //   width: size.width,
        //   child:

        //   Stack(
        //   children: [
        //     Positioned(
        //       top: size.height * 0.25,
        //       child: Container(
        //         width: size.width,
        //         child :ListView.builder(
        //         itemCount: 50, // Replace with your actual item count
        //         itemBuilder: (context, index) {
        //           return ListTile(
        //             title: Text('Item $index'),
        //           );
        //         },
        //       ),
        //       )
        //     ),
        //     Container(
        //       height: size.height * 0.25,
        //       width: size.width, // Half of the screen height
        //       decoration:const BoxDecoration(
        //         image: DecorationImage(
        //           image: NetworkImage(
        //             'https://imgs.search.brave.com/5Uk7BTqjpysZm6SjIGFU9XWbkdM6gFCIwMUE8mIsJdA/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by9h/YnN0cmFjdC1zcGFj/ZS13YWxscGFwZXIt/YmFja2dyb3VuZC1k/YXJrLXNtb2tlLWRl/c2lnbl81Mzg3Ni0x/MjgyNzguanBnP3Np/emU9NjI2JmV4dD1q/cGc', // Replace with your background image URL
        //           ),
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //       child:const Padding(
        //         padding: EdgeInsets.only(left: 20, top: 40),
        //         child: Text(
        //           'Account Settings',
        //           style: TextStyle(
        //             fontSize: 25,
        //             color: Colors.white
        //           ),

        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       top: size.height * 0.2, // Adjust the positioning as needed
        //       left: size.width * 0.2-50, // Center the profile picture
        //       child: const CircleAvatar(
        //         radius: 50,
        //         backgroundColor: Colors.white,
        //         backgroundImage: NetworkImage('https://imgs.search.brave.com/VtuLHgcddG8TLDGhaJKjTncbbvvSBk_shiTxgEnwGFs/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9mcmVl/c3ZnLm9yZy9pbWcv/YWJzdHJhY3QtdXNl/ci1mbGF0LTQucG5n'),
        //       )

        //     ),

        //   ],
        // ),
        // )
        );
  }
}
