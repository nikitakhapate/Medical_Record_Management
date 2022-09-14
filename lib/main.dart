// import 'dart:convert';
//

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:medical_record_management/contract_linking.dart';
// // import 'package:medical_record_management/contract_linking.dart;
// import 'package:web3dart/web3dart.dart';
// import 'package:http/http.dart';
// import 'package:web_socket_channel/io.dart';
// import 'contract_linking.dart';
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   @override
//   void initState() {
//     // httpClient = Client();
//     // ethClient = Web3Client(infura_url, httpClient!);
//     super.initState();
//   }
//   Future<void> _incrementCounter() async {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter+=3;
//     });
//     // final String _rpcUrl = "http://192.168.43.175:7545";
//     // final String _wsUrl = "ws://192.168.43.175:7545/";
//     // Web3Client   _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
//     //   return IOWebSocketChannel.connect(_wsUrl).cast<String>();
//     // });
//     // addDoctor("sdfghjkl",_client);
//     loadContract();    print("deployed contract ");
//     addDoctor("0x569E5051aFd4D1Ce5ae6A381De14e22f1B58fc04","doctor","cc36222016ed0fade5767b542ff0e5a58149517ab128f6df25d337b41a061dba");
//     print("add doc contract ");
//     // print(result);
//     // _addPatient("0x99f342D34171a345C53D4731F032A35BBf8b44aE","pat","dde8e0bab6f4e476c8560f47e3008264f4a7c7d44c939f8d53e4bc890a53fc3b");
//     //
//
//     // _accessToDoctor("0x99f342D34171a345C53D4731F032A35BBf8b44aE","690dbe81614bba61b7cdd23923a492ced9a448e56c6dfd17edc3350b98651a83");
//     // _addPrescriptionOfPatient("0xac3a1268E06D3ce2C9dc3C1fB9d77Cd30Bed7EEc","he have cold","a9c7d8772debdcb1a9343f449e45e4f883b724511ce18d3dcc34084ea8a5dd79");
//     print("add pai contract ");
//     // String abi = await rootBundle.loadString('src/abis/HelloWorld.json');
//     // final contract = DeployedContract(ContractAbi.fromJson(abi, 'HelloWorld'),
//     //     EthereumAddress.fromHex("0xD0eAF8DBDa0188f0a2f5e4B14fA946D924a59eAc"));
//     // print("deployed contract ");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
// // Future<EthereumAddress> loadContract() async {
// //   String abi = await rootBundle.loadString('src/abis/medical_record_management.json');
// //   var jsonAbi = jsonDecode(abi);
// //   // _abiCode = jsonEncode(jsonAbi["abi"]);
// // String nik=jsonAbi["networks"]["5777"]["address"];
// //   var contractAddress =  EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
// //   // String contractAddress = contractAddress1;
// //   var contract = DeployedContract(ContractAbi.fromJson(abi, 'medical_record_management'),
// //       EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]));
// //   // return contract;
// //   return contractAddress;
// // }
// // Future<DeployedContract> loadContract() async {
// //   String abiStringFile =
// //   await rootBundle.loadString("src/abis/medical_record_management.json");
// //   var jsonAbi = jsonDecode(abiStringFile);
// //   var _abiCode = jsonEncode(jsonAbi["abi"]);
// //   var _contractAddress =
// //   EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
// //
// //   var _contract = DeployedContract(
// //       ContractAbi.fromJson(_abiCode, "medical_record_management"), _contractAddress);
// //   return _contract;
// // }
//
// // Future<void> getAbi() async {
// //   String abiStringFile =
// //   await rootBundle.loadString("src/abis/TodoList.json");
// //   var jsonAbi = jsonDecode(abiStringFile);
// //   _abiCode = jsonEncode(jsonAbi["abi"]);
// //   _contractAddress =
// //       EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
// //   print(_contractAddress);
// // }
//
// // Future<String> callFunction(String funcname, List<dynamic> args,
// //     Web3Client ethClient, String privateKey) async {
// //   EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
// //   DeployedContract contract = await loadContract();
// //
// //   final ethFunction = contract.function(funcname);
// //   print(args[1]);
// //   final result = await ethClient.sendTransaction(
// //       credentials,
// //       Transaction.callContract(
// //         contract: contract,
// //         function: ethFunction,
// //         parameters: args,
// //       ),
// //       chainId: null,
// //       fetchChainIdFromNetworkId: true);
// //   print(result);
// //   return result;
// // }
//
// // Future<DeployedContract> loadContract() async {
// //   String abi = await rootBundle.loadString('src/abis/medical_record_management.json');
// //   String contractAddress = "0x7011Ebc0ec24a63d00b0A1e0E2cc3dCE9223E63d";
// //   print("deploy contract ");
// //   final contract = DeployedContract(ContractAbi.fromJson(abi, 'medical_record_management'),
// //       EthereumAddress.fromHex(contractAddress));
// //   print("deployed contract ");
// //   return contract;
// // }
// //
// // Future<String> callFunction(String funcname, List<dynamic> args,
// //     Web3Client ethClient, String privateKey) async {
// //   EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
// //   DeployedContract contract = await loadContract(); print("loadContractsdfghjkl");
// //   final ethFunction = contract.function(funcname);
// //   print("ethfunction");
// //   final result = await ethClient.sendTransaction(
// //       credentials,
// //       Transaction.callContract(
// //         contract: contract,
// //         function: ethFunction,
// //         parameters: args,
// //       ),
// //       chainId: null,
// //       fetchChainIdFromNetworkId: true);
// //   print("object");
// //
// //   return result;
// // }
// // // Future<String> _addDoctor(String id, String   name,String owner) async {
// // //   final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
// // //     return IOWebSocketChannel.connect(_wsUrl).cast<String>();
// // //   });
// // //   var response =
// // //   await callFunction('addDoctor', [EthereumAddress.fromHex(id),name], ethClient,  owner);
// // //   print('doctor addedd successfully');
// // //   return response;
// // // }
// // Future<dynamic> addDoctor(String name, Web3Client ethClient) async {
// //   print("ethfunctionwertyuio");
// //   var response =
// //   await callFunction('addDoctor', [EthereumAddress.fromHex("0xce887cD412Ed7b895EE80Eb8379e96b12D4b2691"),name], ethClient, "81ea63e6c93073da10bdb0d2784ae3fd219903a541af815ad06ea24010ece9ef");
// //   print('Election started successfully');
// //   return response;
// // }
// // // function addDoctor(address id, string memory name) public onlyOwner{
// // // DoctorInfo[id]=doctor(name , id,true);
// // // emit DoctorAddedSuccesfully(msg.sender , id);
// // }
//
// final String _rpcUrl = "http://192.168.43.175:7545";
// final String _wsUrl = "ws://192.168.43.175:7545/";
// Future<Future<List>> addDoctor(String id, String   name,String owner) async {
//   final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
//     return IOWebSocketChannel.connect(_wsUrl).cast<String>();
//   });
//   print("response[0]");
//   DeployedContract contract = await  loadContract();
//   print("response[0]");
//   var response =  ethClient.call(
//       contract: contract, function: contract.function('Doctors'), params: [BigInt.from(1)]);
//   // var response =   await ethClient.call(
//   //     contract: contract, function: contract.function("Doctors"), params: [BigInt.from(0) ]);
//   // var response = await callFunction('addDoctor', [EthereumAddress.fromHex(id),name], ethClient,  owner);
//   // print(response[0] );
//   print('doctor addedd successfully');
//   return response;
// }
// Future<String> _addPatient(String id, String   name,String owner) async {
//   final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
//     return IOWebSocketChannel.connect(_wsUrl).cast<String>();
//   });
//   var response =
//   await callFunction('addPatient', [EthereumAddress.fromHex(id),name,[]], ethClient,  owner);
//   print('patient addedd successfully');
//   return response;
// }
// Future<String> _accessToDoctor(String id, String owner) async {
//   final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
//     return IOWebSocketChannel.connect(_wsUrl).cast<String>();
//   });
//   var response =
//   await callFunction('accessToDoctor', [EthereumAddress.fromHex(id)], ethClient,  owner);
//   print('doc got access');
//   return response;
// }
// Future<String> _addPrescriptionOfPatient(String id,String prescription, String owner) async {
//   final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
//     return IOWebSocketChannel.connect(_wsUrl).cast<String>();
//   });
//   var response =
//   await callFunction('addPrescriptionOfPatient', [EthereumAddress.fromHex(id),prescription], ethClient,  owner);
//   print('addPrescriptionOfPatient got access');
//   return response;
// }
// Future<String> _addPrescriptionOfPatient(String pat , String     prescription,String owner) async {
//   final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
//     return IOWebSocketChannel.connect(_wsUrl).cast<String>();
//   });
//   var response =
//       await callFunction('addPrescriptionOfPatient', [EthereumAddress.fromHex(pat),prescription], ethClient,  owner);
//   print('addPrescriptionOfPatient got access');
//   return response;
// }
import 'dart:convert';
import 'package:medical_record_management/screens/HomeScreen.dart';
import 'package:medical_record_management/screens/ViewPatients.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'contract_linking.dart';
import 'provider/BottomNavigationBar.dart';
import 'provider/admin_provider.dart';
List<dynamic>Prescription= [];
void main() => runApp((  MyApp()));


final nameController = TextEditingController();


class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      theme:   ThemeData(
        primarySwatch: Colors.teal,
      ),
      home:   HomeScreen(),
      // home:   BottomNavigationBarExample(),
      // routes: <String, WidgetBuilder>{
      // 'list': (BuildContext context) => BooklistScreen(),
      // 'details': (BuildContext context) => FlightDetailScreen(),
      // },
      routes: <String, WidgetBuilder>{
        // 'list': (BuildContext context) => BottomNavigationBarExample(),
        // 'details': (BuildContext context) => favprite(),
      },
    );
  }
}

// final nameController = TextEditingController();
