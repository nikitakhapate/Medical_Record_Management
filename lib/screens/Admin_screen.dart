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

import 'DoctorList.dart';
class Admin extends StatefulWidget {

  String OwnerPrivateKey;
  Admin(this.OwnerPrivateKey);
  @override
  State<Admin> createState() => AdminState(OwnerPrivateKey);
}

class AdminState extends State<Admin>  {
  String OwnerPrivateKey;

  TextEditingController DoctorName = TextEditingController();
  TextEditingController DoctorAddress = TextEditingController();
  AdminState(this.OwnerPrivateKey);
  void dispose() {

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/Picsart_22-09-12_14-34-03-896.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("ADMIN"),
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [

            SingleChildScrollView(

              child: Container(padding: EdgeInsets.all(20),
                // height: 310,

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white54,
                  boxShadow: [BoxShadow(
                    color: Colors.teal,
                    blurRadius: 6.0,
                    offset: Offset(0, 5),
                  ),
                  ],
                ),
                child: Column(
                  children: [

                    // SizedBox(height: 5,),
                    SizedBox(height: 10,),
                    Positioned(
                        child: const Text(
                          'ADD DOCTOR',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.w700,
                              color: Colors.teal),
                        )),
                    SizedBox(height: 30,),
                    TextField(
                      controller: DoctorName,
                      decoration: InputDecoration( enabledBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(50.0),
                      ),
                        labelText: 'Enter doctor name', fillColor: Colors.white,  filled: true,
                      ),
                    ),

                    SizedBox(height: 15,),
                    TextField(
                      controller: DoctorAddress,
                      decoration: InputDecoration( enabledBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(50.0),
                      ),
                        labelText: 'Enter Doctor Address', fillColor: Colors.white,  filled: true,
                      ),
                    ),
                    SizedBox(height: 25,),
                    InkWell(
                      onTap:(){
                        print("object");
                        _addDoctor(DoctorAddress.text ,DoctorName.text,OwnerPrivateKey) ;

                      },

                      child: Container(
                        width: 110,
                        height: 40,
                        decoration: BoxDecoration(
                          color: signInButton,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            'Add Doctor',
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
                    SizedBox(height: 40,),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>   DoctorLIst()),
                        );

                      }, child: const    Text(
                      ' View Doctor\'s List',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.underline,

                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.w400),
                    ),
                    ),


                    SizedBox(height: 40,),
                  ],
                ),
              ),

            ),

          ],
        ),
      ),
    );
  }
}

Future<String> _addDoctor(String id, String   name,String owner) async {
  final ethClient = Web3Client( rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect( wsUrl).cast<String>();
  });
  print(id);print(name);print(owner);
  var response =
  await callFunction('addDoctor', [EthereumAddress.fromHex(id),name], ethClient,  owner);
  print('doctor addedd successfully');
  await  getdoctors();
  return response;
}