import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


Widget appButton({
  required function,
  required String text,
  double height = 45,
  double width = double.infinity,
  double radius = 10.0,
  Color buttonColor = Colors.blueAccent,
  bool isLoading = false,


}) =>

Container(
  height: height,
  width: width,
  padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
  child: MaterialButton(

    onPressed: function,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),),
    color: buttonColor,


    child:isLoading
        ? SpinKitCircle(
      color: Colors.white,
      size: 50.0,
    )
        :  Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
    ),


  ),
);

