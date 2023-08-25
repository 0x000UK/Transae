import 'package:firebase_app/Models/UserModel.dart';
import 'package:firebase_app/Widgets/colors.dart';
import 'package:flutter/material.dart';

 
class MyAccount extends StatefulWidget {
  const MyAccount({super.key, required this.userModel});
 
  final UserModel userModel;
  @override
  State<MyAccount> createState() => _MyAccountState();
}
class _MyAccountState extends State<MyAccount> {
 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeColors.orange,
      body: SizedBox(
        height: size.height,
        child: Column(
          children: [
            SafeArea(
              child: SizedBox(
                height: 60,
                child: Row(
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
                    const Text(
                      'Account Setting',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ),
            ),
            Expanded(
              child: Padding(
                padding:const EdgeInsets.all(15),
                child: Container(
                decoration: const BoxDecoration(
                  color: ThemeColors.lightorange,
                  borderRadius: BorderRadius.all(Radius.circular(30))

                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Padding(
                      padding:const EdgeInsets.only(left: 20, bottom: 10),
                      child : Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("UserName", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(widget.userModel.userName!, style: const TextStyle(fontSize: 20)),
                              IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_forward_ios), iconSize: 20,)
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
                          const Text("FullName", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(widget.userModel.fullName!, style: const TextStyle(fontSize: 20),),
                              IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_forward_ios), iconSize: 20,)
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
                          const Text("EMail", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(widget.userModel.email!, style: const TextStyle(fontSize: 20),overflow: TextOverflow.ellipsis,),
                              IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_forward_ios), iconSize: 20,)
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
                          const Text("change Password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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