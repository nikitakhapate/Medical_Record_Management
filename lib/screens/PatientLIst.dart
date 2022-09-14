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

import 'Patients_prescription.dart';
import 'viewPrescription.dart';

class PatientList extends StatefulWidget {

  String OwnerPrivateKey;
  PatientList(this.OwnerPrivateKey);
  @override
  State<PatientList> createState() => PatientListState( OwnerPrivateKey);
}

class PatientListState extends State<PatientList> {

  String OwnerPrivateKey;
  final ScrollController _scrollController = ScrollController();
  PatientListState(this.OwnerPrivateKey){
    init();
  }
  init() async {
    await  getPatients();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/Picsart_22-09-12_14-34-03-896.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            actions: <Widget>[

            ],
            title: Text("PATIENT's  LIST" ),
          ),
          body:
          patient==null?Container():cart()


      ),
    ) ;
  }
  cart() {

    final ScrollController _scrollController = ScrollController();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,

      child: Container(

        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,

          child: Expanded(
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,

              // scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){

                return

                  Flexible(
                    child: InkWell(

                      child: Expanded(
                        child: Card(
                          color: Colors.teal[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),

                          elevation: 10,
                          margin: EdgeInsets.all(10),
                          child: Row(

                            children: [
                              CircleAvatar(   radius: 50,
                                backgroundImage: AssetImage('assets/img_3.png'), ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  // Container(child: Text(doctor[index])),
                                  Container(
                                    // color: Colors.teal[200],
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                      boxShadow: const [
                                        BoxShadow(
                                          // color: Colors.black,
                                          blurRadius: 2.0,
                                          spreadRadius: 0.0,
                                          offset: Offset(0.5, 0.5), // shadow direction: bottom right
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(25),
                                    // ),
                                    height: 30,
                                    width: MediaQuery.of(context).size.width-210,

                                    child: Center(
                                      child: Text(   (patient[index].length<10)?   patient[index]:( patient[index].substring(0,10)+"......."),style: TextStyle(fontWeight:FontWeight.bold ,
                                          fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(patientAddress[index].toString().substring(0,20)+"......."),


                                ],
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                  onTap: (){
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                            (context) =>
                                        // LogIn(),
                                            PatientPrescription(patientAddress[index].toString(),OwnerPrivateKey),
                                        )
                                    );
                                  },
                                  child: Icon(Icons.arrow_forward_ios)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
              },
              itemCount:patient==null?0: patient.length,

            ),
          ),
        ),
      ),
    );
  }


}
List<String> patient = [];  List<EthereumAddress> patientAddress = [];
Future<int> getPatients() async {
  print(":getPatients");
  final _client = Web3Client(rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect(wsUrl).cast<String>();
  });
  DeployedContract contract = await loadContract();

  List totalTasksList = await _client
      .call(contract: contract, function: contract.function("Patient_count") , params: []);
// print("ghj"+totalTasksList[0] );
  BigInt totalTasks = totalTasksList[0];
  int PatientCount = totalTasks.toInt();

  print(PatientCount);  print("PatientCount");
  patient.clear();
  for (var i = 0; i < PatientCount.toInt(); i++) {
    var temp = await _client.call(
        contract: contract, function: contract.function("Patients"), params: [BigInt.from(i)]);
    print(temp[1]);
    print("temp[0]");
    patient.add(  temp[0] );
    patientAddress.add(  temp[1] );
  } print(":getPatient");
  return PatientCount;
}

