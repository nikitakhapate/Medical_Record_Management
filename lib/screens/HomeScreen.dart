import 'package:flutter/material.dart';
import 'dart:async';
import 'DoctorList.dart';
import 'Login.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<HomeScreen> {
  _MyHomePageState(){
    getdoctors();
  }
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 1),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    LogIn(),
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:   ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.transparent,
      ),
      home:  Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Picsart_22-09-12_14-34-03-896.jpg'),
              fit: BoxFit.cover,
            )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage (
                  image: AssetImage('assets/Picsart_22-09-12_14-34-03-896.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}