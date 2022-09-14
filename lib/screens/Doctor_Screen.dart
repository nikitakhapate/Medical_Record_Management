import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_record_management/contract_linking.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import '../Layers/config.dart' ;
import 'PatientLIst.dart';
class DoctorScreen extends StatefulWidget {

  String OwnerPrivateKey;
  DoctorScreen(this.OwnerPrivateKey);
  @override
  State<DoctorScreen> createState() => DoctorScreenState(OwnerPrivateKey);
}

class DoctorScreenState extends State<DoctorScreen>  {
  String OwnerPrivateKey;

  TextEditingController PatientName = TextEditingController();
  TextEditingController PatientAddress = TextEditingController();
  DoctorScreenState(this.OwnerPrivateKey);
  void dispose() {
    // Clean up the controller when the widget is disposed.
    PatientAddress.clear();
    PatientName.clear();
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
          title: Text("DOCTOR"),
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
                          'ADD PATIENT',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.w700,
                              color: Colors.teal),
                        )),
                    SizedBox(height: 30,),
                    TextField(
                      controller: PatientName,
                      decoration: InputDecoration( enabledBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(50.0),
                      ),
                        labelText: 'Enter Patient Name', fillColor: Colors.white,  filled: true,
                      ),
                    ),

                    SizedBox(height: 15,),
                    TextField(
                      controller: PatientAddress,
                      decoration: InputDecoration( enabledBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(50.0),
                      ),
                        labelText: 'Enter Patient Address', fillColor: Colors.white,  filled: true,
                      ),
                    ),
                    SizedBox(height: 25,),
                    InkWell(
                      onTap:(){
                        print("object");
                        _addPatient(PatientAddress.text ,PatientName.text,OwnerPrivateKey) ;
                        dispose(); print("object");
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
                            'Add Patient',
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
                          MaterialPageRoute(builder: (context) =>   PatientList(OwnerPrivateKey)),
                        ); dispose();

                      }, child: const    Text(
                      ' View Patient\'s List',
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


Future<String> _addPatient(String id, String   name,String owner) async {
  final ethClient = Web3Client( rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect( wsUrl).cast<String>();
  });
  var response =
  await callFunction('addPatient', [EthereumAddress.fromHex(id),name,[]], ethClient,  owner);
  print('patient addedd successfully');
  return response;
}