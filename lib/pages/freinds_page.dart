import 'package:firebase_app/Models/user_model.dart';
import 'package:firebase_app/Widgets/empty_tabs.dart';
import 'package:firebase_app/service/FireBase/database_services.dart';
import 'package:firebase_app/service/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyFreinds extends ConsumerStatefulWidget {
  const MyFreinds({super.key});

  @override
  ConsumerState<MyFreinds> createState() => _MyFreindsState();
}

class _MyFreindsState extends ConsumerState<MyFreinds> {
  UserModel? currentUser;
  bool requests = false;
  bool pending = false;
  List<String> pendingfriends = [];

  // void initState() {
  //   super.initState();
  //   pendingFriends();
  // }

  pendingFriends(UserModel? currentUser) async {
    final snapshot =
        await DatabaseService.userCollection.doc(currentUser!.uid).get();
    if (snapshot.exists && snapshot.data() != null) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.isNotEmpty && data["friends"] is Map<String, dynamic>) {
        var userMap = data["friends"] as Map<String, dynamic>;
        pendingfriends = userMap.entries
            .where((entry) => entry.value == false)
            .map((entry) => entry.key)
            .toList();

        if (pendingfriends.isNotEmpty) {
          setState(() {
            pending = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    currentUser = ref.watch(userModelProviderState);

    final sentRequests = ref.watch(friendRequestProvider);
    if (sentRequests.isNotEmpty) {
      setState(() {
        requests = true;
      });
    }
    pendingFriends(currentUser);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SizedBox(
          height: size.height,
          child: Column(
            children: [
              	SafeArea(
                	child: SizedBox(
                    	height: 50,
                    	child: Row(
							crossAxisAlignment: CrossAxisAlignment.center,
							children: [
								const SizedBox(
									width: 30,
								),
								Text(
									'Friends',
									style: Theme.of(context).textTheme.displayMedium,
								)
                      		],
                    	)
					),
              	),
              	Expanded(
                  	child: Padding(
						padding: const EdgeInsets.all(15),
						child: Container(
							decoration: BoxDecoration(
								color: Theme.of(context).primaryColorLight,
								borderRadius: const BorderRadius.all(Radius.circular(30))),
								child: ClipRRect(
									child: Padding(
										padding: const EdgeInsets.only(top: 30, left: 20, bottom: 30),
										child: Column(children: [
											requests
											? Column(children: [
												Text('Requests',
													style: Theme.of(context)
														.textTheme
														.displaySmall
												),
												Expanded(
													child: ListView.builder(
														itemBuilder: (context, index) {
															if (sentRequests.isNotEmpty) {
																return ListTile(
																	leading: const CircleAvatar(
																		radius: 24,
																	),
																	title: Text(
																		sentRequests[index].fullName!,
																		style: Theme.of(context).textTheme.displaySmall
																	),
																	trailing: IconButton(
																	onPressed: () {},
																	icon: const Icon(Icons
																		.cancel_outlined),
																	iconSize: 20,
																	),
																);
															} else {
																return Container();
															}
														}
													),
                                            	)
                                           	]
										)
                                        : Container(),
                                    pending
                                        ? Column(children: [
                                            Container(
                                              child: Text('Pending',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemBuilder: (context, index) {
                                                  return FutureBuilder(
                                                      future: DatabaseService
                                                          .getUserDataByID(
                                                              pendingfriends[
                                                                  index]),
                                                      builder:
                                                          (context, userData) {
                                                        if (userData
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          if (userData.data !=
                                                              null) {
                                                            UserModel
                                                                targetUser =
                                                                userData.data
                                                                    as UserModel;
                                                            return ListTile(
                                                              leading:
                                                                  const CircleAvatar(
                                                                radius: 24,
                                                              ),
                                                              title: Text(
                                                                  targetUser
                                                                      .fullName!,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .displaySmall),
                                                              subtitle: Text(
                                                                  'online',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall),
                                                              trailing: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    IconButton(
                                                                      onPressed:
                                                                          () {},
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .check_circle_outline),
                                                                      iconSize:
                                                                          20,
                                                                    ),
                                                                    IconButton(
                                                                      onPressed:
                                                                          () {},
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .cancel_outlined),
                                                                      iconSize:
                                                                          20,
                                                                    )
                                                                  ]),
                                                              minVerticalPadding:
                                                                  20,
                                                            );
                                                          } else {
                                                            return Container();
                                                          }
                                                        } else {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }
                                                      });
                                                },
                                                itemCount:
                                                    pendingfriends.length,
                                              ),
                                            )
                                          ])
                                        : Container(),
                                    Container(
                                      child: Text('Friends',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall),
                                    ),
                                    StreamBuilder(
                                        stream: DatabaseService.userCollection
                                            .doc(currentUser!.uid)
                                            .snapshots(),
                                        //stream: DatabaseService.userCollection.snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.active) {
                                            if (snapshot.hasData) {
                                              	var data = snapshot.data!.data() as Map<String, dynamic>;
                                              	var userMap = data["friends"] as Map<String, dynamic>;

                                              	final freinds = userMap.entries
                                                  .where((entry) =>
                                                      entry.value == true)
                                                  .map((entry) => entry.key)
                                                  .toList();

                                              if (freinds.isNotEmpty) {
                                                return ListView.builder(
                                                  itemBuilder:
                                                      (context, index) {
                                                    return FutureBuilder(
                                                        future: DatabaseService.getUserDataByID(freinds[index]),
                                                        builder: (context,userData) {
                                                          if (userData.connectionState ==ConnectionState.done) {
                                                            if (userData.data !=null) {
																UserModel targetUser = userData.data as UserModel;
                                                              	return ListTile(
																	leading: Hero(
																		tag: 'freindpic$index',
																		child: const CircleAvatar(
																			radius: 24,
																		),
																	),
                                                                title: Text(
                                                                    targetUser
                                                                        .fullName!,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .displaySmall),
                                                                subtitle: Text(
                                                                    'online',
                                                                    style: Theme.of(context).textTheme.titleSmall),
                                                                	trailing: Row(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon: const Icon(
                                                                            Icons.phone),
                                                                        iconSize:
                                                                            20,
                                                                      ),
                                                                      IconButton(
                                                                        onPressed:() {},
																		icon: const Icon(Icons.video_call),
                                                                        iconSize:20,
                                                                      )
                                                                    ]),
                                                                	minVerticalPadding:20,
                                                              );
                                                            } else {
                                                              return emptyTabContent(
                                                                  tab: 'chats',
                                                                  text:
                                                                      "no user data");
                                                            }
                                                          } else {
                                                            return const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            );
                                                          }
                                                        });
                                                  },
                                                  itemCount: freinds.length,
                                                );
                                              } else {
                                                return emptyTabContent(
                                                    tab: 'chats',
                                                    text:
                                                        "You don't have any freinds Go make some");
                                              }
                                            } else if (snapshot.hasError) {
                                              return emptyTabContent(
                                                  tab: 'chats',
                                                  text: snapshot.error
                                                      .toString());
                                            } else {
                                              return emptyTabContent(
                                                  tab: 'chats',
                                                  text: "snapshot error");
                                            }
                                          } else {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        })
                                  	]
								  )
								)
							)
						)
					)
				)
            ],
          ),
        ));
  }
}
