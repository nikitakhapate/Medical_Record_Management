import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/contracts.dart';

import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';

import '../Layers/config.dart';
import '../contract_linking.dart';
class addPrescription extends StatefulWidget {

  String OwnerPrivateKey,PatientAddress;
  addPrescription(this.PatientAddress,this.OwnerPrivateKey);
  @override
  State<addPrescription> createState() => addPrescriptionState( OwnerPrivateKey,PatientAddress);
}
class addPrescriptionState extends State<addPrescription> {

  String OwnerPrivateKey,PatientAddress;
  addPrescriptionState(this.OwnerPrivateKey,this.PatientAddress);
  TextEditingController Prescription = TextEditingController();
  void dispose() {
    Prescription.clear();
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
                  boxShadow: const [
                    BoxShadow(
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
                    const Positioned(
                        child: Text(
                          'ADD PRESCRIPTION',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.w700,
                              color: Colors.teal),
                        )),
                    SizedBox(height: 30,),
                    TextField(
                      controller: Prescription,
                      decoration: InputDecoration( enabledBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(50.0),
                      ),
                        labelText: 'Enter Patient\'s Prescription', fillColor: Colors.white,  filled: true,
                      ),
                    ),
SizedBox(height: 20,),

                    InkWell(
                      onTap:() async {
                        print("object");
                       await _addPrescription(PatientAddress ,Prescription.text,OwnerPrivateKey) ;

                        dispose(); },

                      child: Container(
                        width: 110,
                        height: 52,
                        decoration: BoxDecoration(
                          color: signInButton,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            'Add Prescription',
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


Future<String> _addPrescription(String Pat, String   pres,String owner ) async {
  // contract_linking listModel = Provider.of<contract_linking>(context);

  final ethClient =await Web3Client(rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect(wsUrl).cast<String>();
  });
  var response =
  await  callFunction('addPrescriptionOfPatient', [EthereumAddress.fromHex(Pat),pres], ethClient,  owner);
  print('addPrescriptionOfPatient addedd successfully');

  return response;
}