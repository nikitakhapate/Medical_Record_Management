import 'package:flutter/material.dart';

import 'config.dart';


class DoctorlistButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
    Center(
      child: Container(
        width: 200,
        height: 40,
        decoration: const BoxDecoration(
          color: signInButton,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            ' View Doctor List',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins-Medium',
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}