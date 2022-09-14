import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminProvider with ChangeNotifier {
  late String _currentAddress  ;

  get GetDoctorAddress => _currentAddress;

  set DoctorAddress(String address) {
    _currentAddress = address;
    notifyListeners();
  }
}