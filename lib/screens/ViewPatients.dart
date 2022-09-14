
import 'package:flutter/material.dart';
import 'package:medical_record_management/provider/admin_provider.dart';
import 'package:medical_record_management/screens/PatientHistory.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart';
import '../Layers/config.dart';
import '../contract_linking.dart';
import '../contract_linking.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical_record_management/main.dart';


class ViewPatients extends StatefulWidget {
  @override
  State<ViewPatients> createState()  => ViewPatientsState();
}
var PatientCount;
// Define a corresponding State class.
// This class holds data related to the Form.
class ViewPatientsState extends State<ViewPatients> {
  ViewPatientsState(){
    initState();
  }  initState()   {
     getPatients();
    print(Patient.length);print("Patient.length");
  }
  @override
  Widget build(BuildContext context) {
        return  Scaffold(
       appBar: AppBar(
         title: Text("TODOLIST"),
       ),
          body  :
          // ( PatientCount<0)
          //     ? Center(
          //   child: CircularProgressIndicator(),
          // ) :
          Column(
         children: [
           Expanded(
             flex: 4,
             child: ListView.builder(
               itemCount:  Patient.length,
               itemBuilder: (context, index) => ListTile(
                 title: Text(Patient[index]),
                 onTap: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) =>   PatientHistory( address:
                     PatientAdress[index]
                     // "0x6DAa50f6aAfa3746029c89FED040E698c1b8ABDa"
                     )),
                   );
                 },
               ),
             ),
           ),

         ],
       ),
     );
  }

}
List< String > Patient = [];

List< EthereumAddress > PatientAdress = [];

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
   PatientCount = totalTasks.toInt();

  print(PatientCount);  print("PatientCount");
  Patient.clear();
  for (var i = 0; i < PatientCount.toInt(); i++) {
    var temp = await _client.call(
        contract: contract, function: contract.function("Patients"), params: [BigInt.from(i)]);
    print(temp[1]);
    print("temp[0]");
    Patient.add(  temp[0] );
    PatientAdress.add(  temp[1] );
  } print(":getPatient");
  return PatientCount;
}