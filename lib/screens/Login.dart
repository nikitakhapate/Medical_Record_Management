import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_record_management/contract_linking.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import '../Layers/config.dart' ;
import '../contract_linking.dart';
import 'package:medical_record_management/const.dart';

import 'Admin_screen.dart';
import 'DoctorList.dart';
import 'Doctor_Screen.dart';
import 'Patient_screen.dart';
class LogIn extends StatefulWidget {

  @override
  State<LogIn> createState() => LogInState( );
}

class LogInState extends State<LogIn>  {


  TextEditingController  OwnerPrivateKey= TextEditingController();
  TextEditingController DoctorAddress = TextEditingController();
  void dispose() {
    // Clean up the controller when the widget is disposed.
    OwnerPrivateKey.clear();
    DoctorAddress.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Picsart_22-09-12_14-34-03-896.jpg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text("MEDICAL_RECORD_MANAGEMENT"),
          ),
          backgroundColor: Colors.transparent,
          body:   ListView(
            children: [
              SizedBox(height:  MediaQuery.of(context).size.height/4,),
              Container(

                    width: 399,
                height:  MediaQuery.of(context).size.height/3,
                    decoration: BoxDecoration(

                    color: Colors.teal[200],
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    ),
                    ),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Positioned(
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF024335)),
                        )),


                    SizedBox(height: 35,),
                    Center(
                      child: Container(
                        width: 6*MediaQuery.of(context).size.width/7,
                        child: TextField(
                          controller: OwnerPrivateKey,

                          decoration: InputDecoration( enabledBorder: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(50.0),
                          ),
                            labelText: 'Enter Your Private Key', fillColor: Colors.white,  filled: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25,),
                    InkWell(
                      onTap:(){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  LogInAs(OwnerPrivateKey.text),
                               ),
                        );

                      },

                      child: Container(
                        width: 110,
                        height: 50,
                        decoration: BoxDecoration(
                          color: signInButton,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            'Sign In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins-Medium',
                                fontWeight: FontWeight.w400),
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
        ),
            ],
          ),
      ),
      ),
    );
  }
}

class LogInAs extends StatelessWidget{
  String OwnerPrivateKey;
  LogInAs(this.OwnerPrivateKey);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.tealAccent.shade100,
        // image: DecorationImage(
        //     image: AssetImage('assets/Picsart_22-09-12_14-34-03-896.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("MEDICAL_RECORD_MANAGEMENT"),
        ),
        backgroundColor: Colors.transparent,
        body:   Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/4,),
              Container(
                width: 140,
                height: 50,
                decoration: BoxDecoration(

                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),

                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>   Admin(OwnerPrivateKey)),
                      );
                    },
                    child: Row(
                      children: [SizedBox(width: 5,),
                        Text(
                          'AS ADMIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 10,),
                        Icon(Icons.arrow_forward_ios,color: Colors.white,),
                      ],
                    ),
                  ),
                ),

              ),
              SizedBox(height: 20,),
              Container(
                width: 140,
                height: 50,
                decoration: BoxDecoration(

                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),

                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>   DoctorScreen(OwnerPrivateKey)),
                      );
                    },
                    child: Row(
                      children: [SizedBox(width: 5,),
                        Text(
                          'AS DOCTOR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 10,),
                        Icon(Icons.arrow_forward_ios,color: Colors.white,),
                      ],
                    ),
                  ),
                ),

              ), SizedBox(height: 20,),
              Container(
                width: 140,
                height: 50,
                decoration: BoxDecoration(

                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),

                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>   Patient_Screen(OwnerPrivateKey)),
                      );
                    },
                    child: Row(
                      children: const [SizedBox(width: 5,),
                        Text(
                          'AS PATIENT',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 10,),
                        Icon(Icons.arrow_forward_ios,color: Colors.white,),
                      ],
                    ),
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }

}
