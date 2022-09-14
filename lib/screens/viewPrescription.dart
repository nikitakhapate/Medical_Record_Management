import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_record_management/contract_linking.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

import '../Layers/config.dart';

class viewPrescription extends StatefulWidget {

  String OwnerPrivateKey;
  viewPrescription(this.OwnerPrivateKey);
  @override
  State<viewPrescription> createState() => viewPrescriptionState( OwnerPrivateKey);
}
class viewPrescriptionState extends State<viewPrescription> {
  String OwnerPrivateKey;
  final ScrollController _scrollController = ScrollController();
  viewPrescriptionState(this.OwnerPrivateKey){
    init();
  }
  init() async {
    await  _getDetailsOfPatient( OwnerPrivateKey);
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

            ],
            title: Text("PRESCRIPTIONS" ),
          ),
          body:
          Prescription==null?Container():cart()


      ),
    ) ;
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Health Record",style: TextStyle(fontWeight:FontWeight.bold ,
    //         fontSize: 20),),
    //   ),
    //   body: ListView.builder(
    //     itemCount: 10,
    //     itemBuilder: (context, index) {
    //       return Expanded(
    //         child: Container(
    //           decoration: BoxDecoration(
    //             color: _colors[index % 4],
    //             boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10, spreadRadius: 5)],
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(40),
    //               topRight: Radius.circular(40),
    //             ),
    //           ),
    //           height: 100,
    //           alignment: Alignment.center,
    //             child: Card(
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(25),
    //           ),
    //
    //           elevation: 10,
    //           margin: EdgeInsets.all(10),
    //           child: Row(
    //
    //             children: [
    //               Expanded(child: Text("Prescrgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggiption" )),
    //             ],
    //
    //           ),
    //
    //         ),
    //
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
  cart() {
    List<Color> _colors = [Colors.teal.shade700, Colors.tealAccent.shade700,Colors.tealAccent,Colors.tealAccent.shade100];

    final ScrollController _scrollController = ScrollController();
    return ListView.builder(
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

    );
  }
}
List<dynamic>Prescription= [];
Future<List> _getDetailsOfPatient( String owner) async {
  final ethClient = Web3Client(rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect(wsUrl).cast<String>();
  });
  DeployedContract contract = await  loadContract();
  EthereumAddress address1=EthPrivateKey.fromHex(owner).address;
  var response = await ethClient.call(sender:address1,contract: contract, function: contract.function('getDetailsOfPatient'), params: [address1]);

  print('_getDetailsOfPatienot access');
  Prescription=response[2];
  return response;
}