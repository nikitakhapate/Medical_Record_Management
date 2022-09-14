import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import '../main.dart';

final String _rpcUrl = "http://192.168.43.175:7545";
final String _wsUrl = "ws://192.168.43.175:7545/";


// final String _rpcUrl = "http://127.0.0.1:7545";
// final String _wsUrl = "ws://127.0.0.1:7545/";
Future<String> callFunction(String funcname, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await  loadContract();
  final ethFunction = contract.function(funcname);
  final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true);
  return result;
}
Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('src/abis/medical_record_management.json');
  var jsonAbi = jsonDecode(abi);
  final contract = DeployedContract(ContractAbi.fromJson(jsonEncode(jsonAbi["abi"]), 'Election'),
      EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]));

  return contract;
}



Future<String> _addDoctor(String id, String   name,String owner) async {
final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
  return IOWebSocketChannel.connect(_wsUrl).cast<String>();
});
var response =
await callFunction('addDoctor', [EthereumAddress.fromHex(id),name], ethClient,  owner);
print('doctor addedd successfully');
return response;
}
class contract_linking extends ChangeNotifier{
      int taskCount=0;
  List<String> doctor = [];

  // bool isLoading = false;
  contract_linking() {
  }
  Future<String> callfunction1(String funcname, List<dynamic> args,
      Web3Client ethClient, String privateKey) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(funcname);
    final result = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: ethFunction,
          parameters: args,
        ),
        chainId: null,
        fetchChainIdFromNetworkId: true);
    return result;
  }

  Future<String> _addPatient(String id, String   name,String owner) async {
    final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    var response =
    await callFunction('addPatient', [EthereumAddress.fromHex(id),name,[]], ethClient,  owner);
    print('patient addedd successfully');
    return response;
  }
  Future<String> _accessToDoctor(String id, String owner) async {
    final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    var response =
    await callFunction('accessToDoctor', [EthereumAddress.fromHex(id)], ethClient,  owner);
    print('_accessToDoctor got access');
    return response;
  }
  Future<String> _addPrescriptionOfPatient(String id,String prescription, String owner) async {
    final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    var response =
    await callFunction('addPrescriptionOfPatient', [EthereumAddress.fromHex(id),prescription], ethClient,  owner);
    print('addPrescriptionOfPatient got access');
    return response;
  }
  Future<String> _getDetailsOfPatient(String id , String owner) async {
    final ethClient = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    var response =
    await callFunction('getDetailsOfPatient', [EthereumAddress.fromHex(id)], ethClient,  owner);
    print('_getDetailsOfPatient got access');
    return response;
  }


}

// EthereumAddress nik='0x6DAa50f6aAfa3746029c89FED040E698c1b8ABDa' as EthereumAddress;