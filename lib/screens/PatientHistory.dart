import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/contracts.dart';

import 'package:flutter/material.dart';
import 'package:medical_record_management/provider/admin_provider.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart';
import '../Layers/config.dart';
import '../contract_linking.dart';
import '../contract_linking.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical_record_management/main.dart';
import 'package:medical_record_management/Global.dart';
class PatientHistory extends StatefulWidget {
  EthereumAddress address;
    PatientHistory({super.key, required this.address});
  @override
  State<PatientHistory> createState() => PatientHistoryState(address);
}

// Define a corresponding State class.
// This class holds data related to the Form.
class PatientHistoryState extends State<PatientHistory> {
  EthereumAddress address;
    PatientHistoryState(this.address){
      print(address);
      _getDetailsOfPatient(address,"f3415b1cc6e00f8f7d9817313c4147f132cc30ea4600a3319fd70bf9f008d806");
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("address"),
      ),
      body: Center(
        child:Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => addPrescriptionPopUp(context)
                );
              },
              // textColor: Theme.of(context).primaryColor,
              child: Container(decoration: const BoxDecoration(

              ),child: const Text('   ADD  Prescription ',style:TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),)),
            ),
          ],
        ),
      ),
    );
    // throw UnimplementedError();
  }



}
Widget addPrescriptionPopUp(BuildContext context) {
  TextEditingController Prescription = TextEditingController();
  TextEditingController PatientAddress = TextEditingController();
  TextEditingController OwnerPrivateKey = TextEditingController();

  return AlertDialog(
    title: const Text('Add Doctor '),

    content: Container(
      height: 2*( MediaQuery.of(context).size.height ) /5,
      decoration: const BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(1),
        ), boxShadow: [
      ],
      ),
      child: Column(
        children: [
          TextFormField(
            controller: PatientAddress,
            decoration: const  InputDecoration(
              labelText: 'ADD PatientAddress',
              // errorText: 'Error message',

              border: OutlineInputBorder(),
              // suffixIcon: Icon(
              //   Icons.error,
              // ),
            ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            controller : Prescription ,

            // maxLength: 20,
            // d
            decoration: const  InputDecoration(
              labelText: 'Prescription text',
              // errorText: 'Error message',
              border: OutlineInputBorder(),
              // suffixIcon: Icon(
              //   Icons.error,
              // ),
            ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            controller: OwnerPrivateKey,
            // maxLength: 20,
            // d
            decoration: const  InputDecoration(
              labelText: 'Label text',
              // errorText: 'Error message',
              border: OutlineInputBorder(),
              // suffixIcon: Icon(
              //   Icons.error,
              // ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await _addPrescription(PatientAddress.text ,Prescription.text,OwnerPrivateKey.text);
            },
            // textColor: Theme.of(context).primaryColor,
            child: Container(decoration: const BoxDecoration(

            ),child: const Text('   ADD  ',style:TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold),)),
          ),
        ],
      ),
    ),



  );
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

Future<List> _getDetailsOfPatient(EthereumAddress id , String owner) async {
  final ethClient = Web3Client(rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect(wsUrl).cast<String>();
  });
  DeployedContract contract = await  loadContract();
  // var response =
  // await callFunction('getDetailsOfPatient', [ id], ethClient,  owner);
  var response = await ethClient.call(sender:EthereumAddress.fromHex("0x5147Df93bAD09d12E77F3Ae567525758b30520aF"),contract: contract, function: contract.function('getDetailsOfPatient'), params: [EthereumAddress.fromHex("0x6DAa50f6aAfa3746029c89FED040E698c1b8ABDa")]);

  return response;
}