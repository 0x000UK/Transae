import 'package:flutter/material.dart';
 
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
 
  final String title;
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
 
  @override
  Widget build(BuildContext context) {
 
    return  Scaffold(

      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back)),
        title:const Text('Add Memeber', 
          style: TextStyle(fontSize: 30),
        ),
        flexibleSpace:const SizedBox(height: 100),
      ),
    );
  }
}