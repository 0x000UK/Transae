import 'package:flutter/material.dart';
 
class MysearchPage extends StatefulWidget {
  const MysearchPage({super.key});
 
  @override
  State<MysearchPage> createState() => _MysearchPageState();
}
class _MysearchPageState extends State<MysearchPage> {
 
  @override
  Widget build(BuildContext context) {
 
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 151, 151),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child : Row(
                children: [
                  IconButton(
                    onPressed: (){Navigator.pop(context);}, 
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 30,
                  ),
                  const SizedBox(width: 30),
                  const Text('Add Members',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
                )
            ),
            SingleChildScrollView(
              child : Center(
                child: Column(
                  children: [
                    Container(
                      width: 500,
                      height: 400,
                      decoration:const  BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/search.png'))
                      ),
                    ),
                    const Text('Add members on BoomBam',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    const Text('Search already registered users using there Email or',
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 15,
                        //decoration: TextDecoration.lineThrough
                      ),
                    ),
                    const Text('username. Keep in mind username is case sensitive',
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 15,
                        //decoration: TextDecoration.lineThrough
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Padding(padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(200, 255, 186, 186),
                          
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(45),
                          //   borderSide: const BorderSide(color: Colors.black),
                          // ),
                          hintText: 'Email or Username',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          // errorBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(45),
                          //   borderSide: const BorderSide(color: Colors.black),
                          // ),
                        ),
                      )
                    )
                  ]
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}