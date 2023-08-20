import 'package:firebase_app/Models/UserModel.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_app/service/FireBase/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'pages/auth/login.dart';
import 'pages/navigation.dart';

Uuid uuid = const Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  User? currentUser = FirebaseAuth.instance.currentUser;
  if(currentUser != null) {
    DatabaseService.uid = currentUser.uid;
    UserModel? userModel = await DatabaseService.getUserDataByID(currentUser.uid);
    if(userModel != null) {
      runApp(Home(userModel: userModel));
    }
    else {
    runApp(const Login());
    }
  }
  else {
    runApp(const Login());
  }
}

class Login extends StatelessWidget {

  const Login({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context ){

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyLogin(),
    );
  }
}

class Home extends StatelessWidget {

  final UserModel userModel;

  const Home({super.key, required this.userModel});

  @override
  Widget build(BuildContext context ){

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(userModel: userModel),
    );
  }
}

//import 'package:flutter/material.dart';

// void main() {
//   runApp(ScrollableTabsApp());
// }

// class ScrollableTabsApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ScrollableTabsScreen(),
//     );
//   }
// }

// class ScrollableTabsScreen extends StatefulWidget {
//   @override
//   _ScrollableTabsScreenState createState() => _ScrollableTabsScreenState();
// }

// class _ScrollableTabsScreenState extends State<ScrollableTabsScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final List<String> tabTitles = ['Tab 1', 'Tab 2', 'Tab 3'];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: tabTitles.length, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200,
//             floating: false,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text('Scrollable Tabs Example'),
//               background:Container(
//                 color: Colors.green,
//               ),
//             ),
//           ),
//           SliverPersistentHeader(
//             delegate: MyTabBarDelegate(
//               tabBar: TabBar(
//                 controller: _tabController,
//                 tabs: tabTitles.map((title) => Tab(text: title)).toList(),
//               ),
//             ),
//             pinned: true,
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return TabContent(title: tabTitles[index]);
//               },
//               childCount: tabTitles.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyTabBarDelegate extends SliverPersistentHeaderDelegate {
//   final TabBar tabBar;

//   MyTabBarDelegate({required this.tabBar});

//   @override
//   double get minExtent => tabBar.preferredSize.height;
//   @override
//   double get maxExtent => tabBar.preferredSize.height;

//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.blue,
//       child: tabBar,
//     );
//   }

//   @override
//   bool shouldRebuild(covariant MyTabBarDelegate oldDelegate) {
//     return tabBar != oldDelegate.tabBar;
//   }
// }

// class TabContent extends StatelessWidget {
//   final String title;

//   const TabContent({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         for (int i = 0; i < 20; i++)
//           Container(
//             height: 100,
//             color: Colors.blue[100 * (i % 9)],
//             child: Center(child: Text('$title Item $i')),
//           ),
//       ],
//     );
//   }
// }




