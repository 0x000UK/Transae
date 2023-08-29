import 'package:firebase_app/Widgets/colors.dart';
import 'package:firebase_app/Widgets/navigation_routes.dart';
import 'package:firebase_app/pages/Settings/Edits/edit.dart';
import 'package:firebase_app/service/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

 
class MyAccount extends ConsumerStatefulWidget {
  const MyAccount({super.key});
 
  @override
  ConsumerState<MyAccount> createState() => _MyAccountState();
}
class _MyAccountState extends ConsumerState<MyAccount> {
  
  @override
  Widget build(BuildContext context) {
    final userModel = ref.watch(userModelProviderState.notifier).state;
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
                    IconButton(
                      splashRadius: 1,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 30,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Account Settings',
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  ],
                )
              ),
            ),
            Expanded(
              child: Padding(
                padding:const EdgeInsets.all(15),
                child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: const BorderRadius.all(Radius.circular(30))

                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Padding(
                      padding:const EdgeInsets.only(left: 20, bottom: 10),
                      child : Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("UserName", style: Theme.of(context).textTheme.displaySmall),
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(width: 60),
                              Text(userModel!.userName!, style: Theme.of(context).textTheme.titleMedium),
                              IconButton(
                                onPressed: () {
                                  
                                  Navigator.of(context).push(slideTransitionBuilder( MyEdits(edit: "UserName",userModel: userModel,)));
                                },
                                 icon:const Icon(Icons.arrow_forward_ios), iconSize: 20,)
                            ],
                          ))
                        ],
                      )
                    ),
                    Padding(
                      padding:const EdgeInsets.only(left: 20, bottom: 10),
                      child : Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("FullName", style: Theme.of(context).textTheme.displaySmall),
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(width: 60),
                              Text(userModel.fullName!, style:  Theme.of(context).textTheme.titleMedium),
                              IconButton(
                                onPressed: (){
                                   Navigator.of(context).push(slideTransitionBuilder( MyEdits(edit: "FullName",userModel: userModel,)));
                                }, 
                                icon:const Icon(Icons.arrow_forward_ios), iconSize: 20,)
                            ],
                          ))
                        ],
                      )
                    ),
                    Padding(
                      padding:const EdgeInsets.only(left: 20, bottom: 10),
                      child : Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("EMail", style: Theme.of(context).textTheme.displaySmall),
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(width: 60),
                              Text(userModel.email!, style:  Theme.of(context).textTheme.titleMedium),
                              IconButton(
                                onPressed: (){
                                   Navigator.of(context).push(slideTransitionBuilder( MyEdits(edit: "Email",userModel: userModel,)));
                                }, 
                                icon:const Icon(Icons.arrow_forward_ios), iconSize: 20,)
                            ],
                          ))
                        ],
                      )
                    ),
                    Padding(
                      padding:const EdgeInsets.only(left: 20, bottom: 10),
                      child : Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Change Password", style: Theme.of(context).textTheme.displaySmall),
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_forward_ios), iconSize: 20,)
                            ],
                          ))
                        ],
                      )
                    ),
                  ],
                ),
              )
              )
            )
          ],
        ),
      )
    );
  }
}