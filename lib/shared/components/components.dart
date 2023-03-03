
import 'package:flutter/material.dart';

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