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
import 'viewPrescription.dart';


class Patient_Screen extends StatefulWidget {

  String OwnerPrivateKey;
  Patient_Screen(this.OwnerPrivateKey);
  @override
  State<Patient_Screen> createState() => Patient_ScreenState(OwnerPrivateKey);
}

class Patient_ScreenState extends State<Patient_Screen>  {
  String OwnerPrivateKey;

  TextEditingController PatientName = TextEditingController();
  TextEditingController DoctorAddress = TextEditingController();
  Patient_ScreenState(this.OwnerPrivateKey);
  void dispose() {
    // Clean up the controller when the widget is disposed.
    PatientName.clear();
    DoctorAddress.clear();
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
          title: Text("PATIENT"),
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
                          'AUTHORIZE DOCTOR',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.w700,
                              color: Colors.teal),
                        )),


                    SizedBox(height: 35,),
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
                        _accessToDoctor(DoctorAddress.text,OwnerPrivateKey);
                        dispose();
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
                            'Authorize Doctor',
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
                          MaterialPageRoute(builder: (context) =>   viewPrescription(OwnerPrivateKey)),
                        );
                        dispose();
                      }, child: const    Text(
                      ' View  Your Prescription',
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

Future<String> _accessToDoctor(String id, String owner) async {
  final ethClient = Web3Client(rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect(wsUrl).cast<String>();
  });
  var response =
  await callFunction('accessToDoctor', [EthereumAddress.fromHex(id)], ethClient,  owner);
  print('_accessToDoctor got access');
  return response;
}