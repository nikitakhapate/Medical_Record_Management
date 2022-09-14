import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_record_management/contract_linking.dart';
import 'package:medical_record_management/screens/PatientHistory.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import '../Layers/config.dart';
import 'addPrescription.dart';

class PatientPrescription extends StatefulWidget {

  String OwnerPrivateKey,patientAddress ;
  PatientPrescription(this.patientAddress,this.OwnerPrivateKey);
  @override
  State<PatientPrescription> createState() => PatientPrescriptionState(patientAddress, OwnerPrivateKey);
}
class PatientPrescriptionState extends State<PatientPrescription> {
  String OwnerPrivateKey,patientAddress;
  final ScrollController _scrollController = ScrollController();
  PatientPrescriptionState(this.patientAddress,this.OwnerPrivateKey){
    init();
  }
  init() async {
    await  _getDetailsOfPatient(patientAddress,OwnerPrivateKey);
  }

  @override
  List<Color> _colors = [Colors.tealAccent.shade700, Colors.tealAccent.shade400,Colors.tealAccent,Colors.tealAccent.shade100];

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
              ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.teal[900]),

            //
            // padding: 2,
              textStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 23),
              ),),
                onPressed: ( ){   Navigator.pushReplacement(context,
                    MaterialPageRoute(builder:
                        (context) =>
                    // LogIn(),
                    //     addPrescription(patientAddress,OwnerPrivateKey ),
                        addPrescription(patientAddress,OwnerPrivateKey),
                    )
                );}, child:  Icon(
                Icons.add,
                color: Colors.white,
                size: 30.0,
              ),
              // Text("ADD"),
              ),
              SizedBox(width: 15,)
            ],
            title: Text("PRESCRIPTIONS",style: TextStyle(fontWeight:FontWeight.bold ,
                fontSize: 20),),
          ),
          body:
          Prescription==null?Container():cart()
      ),
    ) ;

  }
  cart() {
    List<Color> _colors = [Colors.teal.shade700, Colors.tealAccent.shade700,Colors.tealAccent,Colors.tealAccent.shade100];

    final ScrollController _scrollController = ScrollController();
    return Container(
      child: ListView.builder(
        itemBuilder: (context,index){

          return
            Flexible(
              child: InkWell(

                child: Container(
                  decoration: BoxDecoration(
                    color: _colors[index % 4],
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10, spreadRadius: 5)],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  // color: Colors.tealAccent,
                  child: Column(
                    children: [  SizedBox(height: 20,),
                      SizedBox(width:  MediaQuery.of(context).size.width,
                        child: Card(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 20,
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Text(   Prescription[index] ,style: TextStyle(fontWeight:FontWeight.bold ,
                                  fontSize: 20),
                              ), SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ),  SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),

            );
        },
        itemCount:Prescription==null?0: Prescription.length,

      ),
    );
  }
}
List<dynamic>Prescription= [];
Future<List> _getDetailsOfPatient(String id , String owner) async {
  final ethClient = Web3Client(rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect(wsUrl).cast<String>();
  });
  DeployedContract contract = await  loadContract();

  EthPrivateKey credentials = EthPrivateKey.fromHex(owner);
  var response = await ethClient.call(sender:credentials.address,contract: contract, function: contract.function('getDetailsOfPatient'), params: [EthereumAddress.fromHex(id)]);

  Prescription=response[2];
  return response;
}