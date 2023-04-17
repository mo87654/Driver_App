
import 'package:flutter/material.dart';

var busid;
 List addresses=[];

Widget driverLeading({
   required Function? onpressedfun(),
})
{
  return IconButton(
      onPressed: onpressedfun,
      icon: Icon(
        Icons.arrow_back,
      )
  );
}