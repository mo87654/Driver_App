
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login screen/login.dart';

class BusDriverHome extends StatefulWidget {

  @override
  State<BusDriverHome> createState() => _BusDriverHomeState();
}

class _BusDriverHomeState extends State<BusDriverHome> {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    });


  }
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        color: Color(0xffEBEBEB),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '22',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey,

            ),
           SizedBox(
             height: height * .07,
           ),
           Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               color: Colors.white,

             ),
             child: Column(
               children: [
                 Container(
                   padding: EdgeInsetsDirectional.only(
                     start: 10,
                     top: 5
                   ),
                   height: height * .08,
                   width: width * .87,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Expanded(
                         child: Text(
                           'Status',
                           style: TextStyle(
                             fontSize: 18,
                           ),
                         ),
                       ),
                       Expanded(
                         child: Text(
                         'Bus number',
                         style: TextStyle(
                           fontSize: 14,
                           color: Colors.grey,
                         ),
                       ),
                       )
                     ],
                   ),
                 ),
                 Container(
                   height: height * .29,
                   width: width * .53,
                   child: Image(
                     image: AssetImage('assets/images/student.png'),
                     fit:BoxFit.cover ,
                   ),

                 ),
                 Container(
                   padding: EdgeInsetsDirectional.only(
                     start: 10,
                     top: 5
                   ),
                   height: height * .17,
                   width: width * .87,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         'Student Name',
                         style: TextStyle(
                           fontSize: 20,
                         ),
                       ),
                       SizedBox(
                         height: 10,
                       ),
                       Text(
                         'Student grad',
                         style: TextStyle(
                           fontSize: 15,
                         ),
                       ),
                       SizedBox(
                         height: height * .17 * .08,
                       ),
                       Expanded(
                         child: Row(
                           children: [
                             MaterialButton(
                               onPressed:(){},
                               child: Text(
                                 'APPROVE',
                                 style: TextStyle(
                                   fontSize: 17,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.green,
                                 ),
                               ),
                             ),
                             SizedBox(
                               width: 20,
                             ),
                             MaterialButton(
                               onPressed:(){},
                               child: Text(
                                 'DENY',
                                 style: TextStyle(
                                   fontSize: 17,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.red,
                                 ),
                               ),
                             ),
                           ],
                         ),
                       )
                     ],
                   ),
                 )
               ],
             ),
           )




        ],),
      );
  }
}

