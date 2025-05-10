import 'package:flutter/material.dart';
import 'package:recipe_app/enterform.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FormPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 149, 214, 214),
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 100,),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 153, 214, 215),
                    spreadRadius: 35,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Image.asset("assets/images/logo_bluee.png"),
            ),
            SizedBox(height: 40),
            Text("Welcome to the Family", style: TextStyle(fontSize: 30),)
           ],
        ),
      ),
    );
  }
}