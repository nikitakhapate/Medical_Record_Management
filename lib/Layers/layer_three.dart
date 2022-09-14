import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'config.dart';
class LogIn extends StatefulWidget {

  String OwnerPrivateKey;
  LogIn(this.OwnerPrivateKey);
  @override
  LogInState createState() => LogInState(OwnerPrivateKey);
}

class LogInState extends State<LogIn>  {
  String OwnerPrivateKey;

  TextEditingController DoctorName = TextEditingController();
  TextEditingController DoctorAddress = TextEditingController();
  LogInState(this.OwnerPrivateKey);
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Container(
      height:3*MediaQuery.of(context).size.height/5,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          // Container(
          //   width: 310,
          //   child: TextField(
          //     decoration: InputDecoration(
          //       border: UnderlineInputBorder(),
          //       hintText: 'Enter Doctor\'s Address',
          //       hintStyle: TextStyle(color: hintText),
          //     ),
          //   ),
          // ),
          // Text(
          //   'Doctor Address',
          //   style: TextStyle(
          //       fontFamily: 'Poppins-Medium',
          //       fontSize: 24,
          //       fontWeight: FontWeight.w500),
          // ),
          // Text(
          //   'Doctor Name',
          //   style: TextStyle(
          //       fontFamily: 'Poppins-Medium',
          //       fontSize: 24,
          //       fontWeight: FontWeight.w500),
          // ),
          // Container(
          //   width: 310,
          //   child: TextField(
          //     decoration: InputDecoration(
          //       border: UnderlineInputBorder(),
          //       hintText: 'Enter Doctor\'s Name',
          //       hintStyle: TextStyle(color: hintText),
          //     ),
          //   ),
          // ),
          // Text(
          //   'Private Key',
          //   style: TextStyle(
          //       fontFamily: 'Poppins-Medium',
          //       fontSize: 24,
          //       fontWeight: FontWeight.w500),
          // ),
          // Positioned(
          //     left: 59,
          //     top: 229,
          //     child: Container(
          //       width: 310,
          //       child: TextField(
          //         decoration: InputDecoration(
          //           border: UnderlineInputBorder(),
          //           hintText: 'Enter Doctor\'s Name',
          //           hintStyle: TextStyle(color: hintText),
          //         ),
          //       ),
          //     )),
          // Positioned(
          //     right: 60,
          //     top: 296,
          //     child: Text(
          //       'Forgot Password',
          //       style: TextStyle(
          //           color: forgotPasswordText,
          //           fontSize: 16,
          //           fontFamily: 'Poppins-Medium',
          //           fontWeight: FontWeight.w600),
          //     )),
          // Positioned(
          //     left: 46,
          //     top: 361,
          //     child: Checkbox(
          //       checkColor: Colors.black,
          //       activeColor: checkbox,
          //       value: isChecked,
          //       onChanged: (bool? value) {
          //         isChecked = value!;
          //       },
          //     )),
          // Positioned(
          //     left: 87,
          //     top: 375,
          //     child: Text(
          //       'Remember Me',
          //       style: TextStyle(
          //           color: forgotPasswordText,
          //           fontSize: 16,
          //           fontFamily: 'Poppins-Medium',
          //           fontWeight: FontWeight.w500),
          //     )),

          Positioned(

            top: ( MediaQuery.of(context).size.height ) /60,
            right: ( MediaQuery.of(context).size.width ) /7,
            left: ( MediaQuery.of(context).size.width ) /7,
            child: Container(

              width: 3*( MediaQuery.of(context).size.width ) /5,
              height: 4*( MediaQuery.of(context).size.width ) /5,

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
              child: Container(padding: EdgeInsets.all(20),
                // height: 310,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white54,
                  boxShadow: [BoxShadow(
                    color: Colors.teal,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 5,),

                    Positioned(
                        top: 20,
                        left: 30,
                        child: Container(
                          child: const Text(
                            'ADD DOCTOR',
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Poppins-Medium',
                                fontWeight: FontWeight.w700,
                                color: Colors.teal),
                          ),
                        )),
                    // Text(
                    //   'Doctor Name           ',
                    //   style: TextStyle(
                    //       // fontFamily: 'Poppins-Medium',
                    //       fontSize: 24,
                    //       // fontWeight: FontWeight.w500
                    //   ),
                    //
                    //   ),


                    // TextFormField(
                    //   controller: DoctorName,
                    //   decoration: const  InputDecoration(
                    //     labelText: 'Enter doctor name',
                    //     // errorText: 'Error message',
                    //     fillColor: Colors.white,
                    //     border: OutlineInputBorder(),
                    //     // suffixIcon: Icon(
                    //     //   Icons.error,
                    //     // ),
                    //   ),
                    // ),
                    SizedBox(height: 30,),
                    TextField(
                      decoration: InputDecoration( enabledBorder: OutlineInputBorder(
                        // borderSide:

                        // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE

                        borderRadius: BorderRadius.circular(50.0),
                      ),
                        labelText: 'Enter doctor name', fillColor: Colors.white,  filled: true,
                      ),
                    ),
                    SizedBox(height: 20,),
                    // Text(
                    //   'Doctor Address                               ',
                    //   style: TextStyle(
                    //     // fontFamily: 'Poppins-Medium',
                    //     fontSize: 20,
                    //     // fontWeight: FontWeight.w500
                    //   ),
                    //
                    // ),
                    // TextField(
                    //   controller : DoctorAddress ,
                    //
                    //   // maxLength: 20,
                    //   // d
                    //   decoration: const  InputDecoration(
                    //     labelText: 'Enter Doctor Address',
                    //     // errorText: 'Error message',
                    //     enabledBorder: OutlineInputBorder(  ),
                    //     // suffixIcon: Icon(
                    //     //   Icons.error,
                    //     // ),
                    //   ),
                    // ),
                    TextField(
                      decoration: InputDecoration( enabledBorder: OutlineInputBorder(
                        // borderSide:

                        // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE

                        borderRadius: BorderRadius.circular(50.0),
                      ),
                        labelText: 'Enter Doctor Address', fillColor: Colors.white,  filled: true,
                      ),
                    ),
                    SizedBox(height: 15,),
                    // TextFormField(
                    //   controller: OwnerPrivateKey,
                    //   // maxLength: 20,
                    //   // d
                    //   decoration: const  InputDecoration(
                    //
                    //     // errorText: 'Error message',
                    //     border: OutlineInputBorder(),
                    //     // suffixIcon: Icon(
                    //     //   Icons.error,
                    //     // ),
                    //   ),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //
                    //     // print(DoctorAddress.text );
                    //     // print(DoctorName.text );
                    //     // print(OwnerPrivateKey.text );
                    //     // // _addDoctor("0xF39E12BbD1d1B7af59D7Fea10cE80FeA25698E46","dfghjk","0db7ccc5e09d3eb93700473087f303818964380259ea3be3643296f7b08651f0");
                    //     //
                    //     // await _addDoctor(DoctorAddress.text ,DoctorName.text,OwnerPrivateKey.text,context);
                    //     //
                    //     // print(listModel.taskCount );
                    //     //
                    //     // print(OwnerPrivateKey.text );
                    //     // Navigator.of(context).pop();
                    //   },
                    //   // textColor: Theme.of(context).primaryColor,
                    //   // child: Container(decoration: const BoxDecoration(
                    //   //
                    //   // ),child: const Text('   ADD  ',style:TextStyle(
                    //   //     fontSize: 20,
                    //   //     fontWeight: FontWeight.bold),)),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 1.75*MediaQuery.of(context).size.height/5,

              right: 80,
              child: Container(
                width: 99,
                height: 35,
                decoration: BoxDecoration(
                  color: signInButton,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    'Add Doctor',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )),
          Positioned(
              top: 432,
              left: 59,
              child: Container(
                height: 0.5,
                width: 310,
                color: inputBorder,
              )),
          Positioned(
              top: 482,
              left: 120,
              right: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Text(
                    'or',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins-Regular',
                        color: hintText),
                  ),
                  Container(
                    width: 59,
                    height: 48,
                    decoration: BoxDecoration(
                        border: Border.all(color: signInBox),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),

                  ),
                ],
              ))
        ],
      ),
    );
  }
}