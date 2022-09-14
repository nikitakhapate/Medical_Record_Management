

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../contract_linking.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

import 'ViewPatients.dart';


TextEditingController DoctorAddress = TextEditingController();
TextEditingController DoctorPrivateKey = TextEditingController();
class Doctor extends StatefulWidget {
  @override
  State<Doctor> createState() => DoctorState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class DoctorState extends State<Doctor> {

  TextEditingController _Doctorname = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(

        home: Scaffold(
          appBar: AppBar(title: Text('  Doctor'),),
          body: Column(
            children: [
              Text("Patient Management"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox( width:  (MediaQuery.of(context).size.width-240)/3),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => addPatientPopUp(context),
                        );
                      },

                      child: Column(
                        children: [
                          (
                              const CircleAvatar(
                                backgroundImage: AssetImage('assets/img_1.png'),
                                backgroundColor: Colors.blueAccent,
                                radius:65  ,
                              )
                          ),
                          Text("Add Patient"),
                        ],
                      ),
                    ),
                  ),
                  // const Divider(
                  //   color: Colors.black,
                  //   height: 25,
                  //   thickness: 2,
                  //   indent: 5,
                  //   endIndent: 5,
                  // ),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  // Expanded(child: SizedBox()),
                  Expanded(
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => ViewPatients(),
                          );
                        },
                        child: (
                            Column(
                              children: [
                                (
                                    const CircleAvatar(
                                      backgroundImage: AssetImage('assets/img_1.png'),
                                      backgroundColor: Colors.blueAccent,
                                      radius:65  ,
                                    )
                                ),
                                Text("View Patients"),
                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox( width:  (MediaQuery.of(context).size.width-240)/3),

                ],
              ),

            ],
          ),
        )
    );

  }

  Widget addPatientPopUp(BuildContext context) {
    TextEditingController PatientName = TextEditingController();
    TextEditingController PatientAddress = TextEditingController();
    TextEditingController OwnerPrivateKey = TextEditingController();

    var listModel = Provider.of<contract_linking>(context);
    return AlertDialog(
      title: const Text('Add Patient'),

      content: Container(
        height: 2*( MediaQuery.of(context).size.height ) /5,
        decoration: const BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(1),
          ), boxShadow: [
          // BoxShadow(
          // color: Colors.lightBlue ,
          //   offset: Offset(2, 2),
          //   spreadRadius: 2,
          //   blurRadius: 1,
          // ),
        ],
        ),
        child: Column(
          children: [
            TextFormField(
              controller: PatientName,
              decoration: const  InputDecoration(
                labelText: 'Add Patient name',
                // errorText: 'Error message',

                border: OutlineInputBorder(),
                // suffixIcon: Icon(
                //   Icons.error,
                // ),
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller : PatientAddress ,

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

                print(PatientAddress.text );
                print(PatientName.text );
                print(OwnerPrivateKey.text );
                // _addDoctor("0xF39E12BbD1d1B7af59D7Fea10cE80FeA25698E46","dfghjk","0db7ccc5e09d3eb93700473087f303818964380259ea3be3643296f7b08651f0");

                await _addPatient(PatientAddress.text ,PatientName.text,OwnerPrivateKey.text,context);

                print(listModel.taskCount );
                // listModel.isLoading = true;
                print(OwnerPrivateKey.text );
                Navigator.of(context).pop();
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

  Future<String> _addPatient(String id, String   name,String owner,BuildContext context) async {

    final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    var response =
    await  callFunction('addPatient', [EthereumAddress.fromHex(id),name,[]], ethClient,  owner);
    print('patient addedd successfully');
    // listModel.isLoading = true;
    return response;
  }


// Widget addPatientPopUp(BuildContext context) {
//   TextEditingController DoctorName = TextEditingController();
//   TextEditingController DoctorAddress = TextEditingController();
//   TextEditingController OwnerPrivateKey = TextEditingController();
//
//   // final themeChange = Provider.of<DarkThemeProvider>(context);
//   return AlertDialog(
//     title: const Text('Add Patient '),
//
//     content: Column(
//       children: [
//         TextFormField(
//           controller: DoctorName,
//           decoration: const  InputDecoration(
//             labelText: 'Add Patient Name',
//             // errorText: 'Error message',
//
//             border: OutlineInputBorder(),
//             // suffixIcon: Icon(
//             //   Icons.error,
//             // ),
//           ),
//         ),
//         SizedBox(height: 20,),
//         TextFormField(
//           controller : DoctorAddress ,
//           // maxLength: 20,
//           // d
//           decoration: const  InputDecoration(
//             labelText: 'Patient Address',
//             // errorText: 'Error message',
//             border: OutlineInputBorder(),
//             // suffixIcon: Icon(
//             //   Icons.error,
//             // ),
//           ),
//         ),
//         SizedBox(height: 20,),
//         TextFormField(
//           controller: OwnerPrivateKey,
//           // maxLength: 20,
//           // d
//           decoration: const  InputDecoration(
//             labelText: 'Your Private Key(only Doctor)',
//             // errorText: 'Error message',
//             border: OutlineInputBorder(),
//             // suffixIcon: Icon(
//             //   Icons.error,
//             // ),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//
//             print(DoctorAddress.text );
//             print(DoctorName.text );
//             print(OwnerPrivateKey.text );
//             // _addDoctor("0xF39E12BbD1d1B7af59D7Fea10cE80FeA25698E46","dfghjk","0db7ccc5e09d3eb93700473087f303818964380259ea3be3643296f7b08651f0");
//             print(OwnerPrivateKey.text );
//             await _addPatient(DoctorAddress.text ,DoctorName.text,OwnerPrivateKey.text);
//             print(OwnerPrivateKey.text );
//             Navigator.of(context).pop();
//           },
//           // textColor: Theme.of(context).primaryColor,
//           child: Container(decoration: const BoxDecoration(
//
//           ),child: const Text('   ADD  ',style:TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold),)),
//         ),
//       ],
//     ),
//
//
//
//   );
// }
// Widget addPatientPopUp(BuildContext context) {
//   TextEditingController DoctorName = TextEditingController();
//   TextEditingController DoctorAddress = TextEditingController();
//   TextEditingController OwnerPrivateKey = TextEditingController();
//
//   // final themeChange = Provider.of<DarkThemeProvider>(context);
//   return AlertDialog(
//     title: const Text('Add Doctor '),
//
//     content: Column(
//       children: [
//         TextFormField(
//           controller: DoctorName,
//           decoration: const  InputDecoration(
//             labelText: 'ADD doctor name',
//             // errorText: 'Error message',
//
//             border: OutlineInputBorder(),
//             // suffixIcon: Icon(
//             //   Icons.error,
//             // ),
//           ),
//         ),
//         SizedBox(height: 20,),
//         TextFormField(
//           controller : DoctorAddress ,
//           // maxLength: 20,
//           // d
//           decoration: const  InputDecoration(
//             labelText: 'Label text',
//             // errorText: 'Error message',
//             border: OutlineInputBorder(),
//             // suffixIcon: Icon(
//             //   Icons.error,
//             // ),
//           ),
//         ),
//         SizedBox(height: 20,),
//         TextFormField(
//           controller: OwnerPrivateKey,
//           // maxLength: 20,
//           // d
//           decoration: const  InputDecoration(
//             labelText: 'Label text',
//             // errorText: 'Error message',
//             border: OutlineInputBorder(),
//             // suffixIcon: Icon(
//             //   Icons.error,
//             // ),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//
//             print(DoctorAddress.text );
//             print(DoctorName.text );
//             print(OwnerPrivateKey.text );
//             // _addDoctor("0xF39E12BbD1d1B7af59D7Fea10cE80FeA25698E46","dfghjk","0db7ccc5e09d3eb93700473087f303818964380259ea3be3643296f7b08651f0");
//             print(OwnerPrivateKey.text );
//             await _addPatient(DoctorAddress.text ,DoctorName.text,OwnerPrivateKey.text);
//             print(OwnerPrivateKey.text );
//             Navigator.of(context).pop();
//           },
//           // textColor: Theme.of(context).primaryColor,
//           child: Container(decoration: const BoxDecoration(
//
//           ),child: const Text('   ADD  ',style:TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold),)),
//         ),
//       ],
//     ),
//
//
//
//   );
// }

}



Future<String> _addDoctor(String id, String   name,String owner,BuildContext context) async {
  contract_linking listModel = Provider.of<contract_linking>(context);
  // listModel.isLoading = true;
  final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect(_wsUrl).cast<String>();
  });
  var response =
  await  callFunction('addDoctor', [EthereumAddress.fromHex(id),name], ethClient,  owner);
  print('doctor addedd successfully');
  return response;
}


final String _rpcUrl = "http://192.168.43.175:7545";
final String _wsUrl = "ws://192.168.43.175:7545/";
// final String _rpcUrl = "http://192.168.43.175:7545";
// final String _wsUrl = "ws://192.168.43.175:7545/";
// final String _rpcUrl = "http://127.0.0.1:7545";
// final String _wsUrl = "ws://127.0.0.1:7545/";
// Future<String> _getDetailsOfPatient(String id , String owner) async {
//   final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
//     return IOWebSocketChannel.connect(_wsUrl).cast<String>();
//   });
//   var response =
//   await callFunction('getDetailsOfPatient', [EthereumAddress.fromHex(id)], ethClient,  owner);
//   print('_getDetailsOfPatient got access');
//   return response;
// }
Future<String> _addPatient(String id, String   name,String owner,BuildContext context) async {
  contract_linking listModel = Provider.of<contract_linking>(context);
  final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect(_wsUrl).cast<String>();
  });
  var response =
  await callFunction('addPatient', [EthereumAddress.fromHex(id),name,[]], ethClient,  owner);
  print('patient addedd successfully');
  return response;
}