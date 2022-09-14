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

final String _rpcUrl = "http://192.168.43.175:7545";
final String _wsUrl = "ws://192.168.43.175:7545/";

class DoctorLIst extends StatefulWidget {

  @override
  State<DoctorLIst> createState() => DoctorLIstState( );
}

class DoctorLIstState extends State<DoctorLIst> {
  final ScrollController _scrollController = ScrollController();
  DoctorLIstState(){
    init();
  }
  init() async {
    await  getdoctors();
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
            title: Text("DOCTOR's LIST",style: TextStyle(fontWeight:FontWeight.bold ,
                fontSize: 20),),
          ),
          body:
          doctor==null?Container():cart()


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
                                backgroundImage: AssetImage('assets/img_1.png'), ),
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
                                    child: Text(   (doctor[index].length<10)?   doctor[index]:( doctor[index].substring(0,10)+"......."),style: TextStyle(fontWeight:FontWeight.bold ,
                                          fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(doctorAddress[index].toString().substring(0,20)+"......."),


                                ],
                              ),

                            ],
                          )
                          ,
                        ),
                      ),
                    ),

                  );
              },
              itemCount:doctor==null?0: doctor.length,

            ),
          ),
        ),
      ),
    );
  }


}
List<String> doctor = [];  List<EthereumAddress> doctorAddress = [];
getdoctors() async {
  final _client = Web3Client(rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect(wsUrl).cast<String>();
  });
  print("getdoctor");
  DeployedContract contract = await loadContract();
  List totalTasksList = await _client
      .call(contract: contract, function: contract.function("Doctor_count") , params: []);
  BigInt totalTasks = totalTasksList[0];
  int taskCount = totalTasks.toInt();
  print(totalTasks);
  print("getdoctor");

  doctor.clear() ;doctorAddress.clear();
  for (var i = 0; i < totalTasks.toInt(); i++) {
    var temp = await _client.call(
        contract: contract, function: contract.function("Doctors"), params: [BigInt.from(i)]);
    doctor.add( temp[0] );
    print("getdoctor");

    print(temp[1]);
    doctorAddress.add(  temp[1] );
  }
}
