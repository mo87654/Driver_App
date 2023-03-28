import 'package:driver_app/modules/login%20screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.autoScale(480, name: 'SM'),
          ResponsiveBreakpoint.autoScale(800, name: 'MD'),
          ResponsiveBreakpoint.autoScale(1000, name: 'LG'),
          ResponsiveBreakpoint.autoScale(1200, name: 'XL'),
          ResponsiveBreakpoint.autoScale(2460, name: '2XL'),
        ],),
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

