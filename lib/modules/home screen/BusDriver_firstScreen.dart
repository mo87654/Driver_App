
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../layout/driver_layout.dart';
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
    getIDs();
    instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    });


  }
  List studentData = [];
  List ids = [];
  List students =[];
  var rand ;
  getIDs()async{
    ids.clear();
    await FirebaseFirestore
        .instance
        .collection('Students')
        .get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          ids.add(element.id);
        });
      });
      rand = ids[Random().nextInt(ids.length)];
      //getData();
    });
  }
  getData()async{
    var dataRef = await FirebaseFirestore
        .instance
        .collection('Students')
        .doc(rand).get();
    studentData.add(dataRef.data());
  }
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
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
            FloatingActionButton(
                onPressed: ()async{
                  await getData();
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context){
                        return WillPopScope(
                          onWillPop: () => Future.value(false),
                          child: AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
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
                                          studentData[0]['Bus id'],
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
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: height * .17,
                                  width: width * .87,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          studentData[0]['name'],
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: Text(
                                          studentData[0]['grad'],
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * .17 * .08,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            MaterialButton(
                                              onPressed:(){
                                                students.add(studentData[0]['name']);
                                                DriverLayout(names: students,);
                                                Navigator.pop(context);
                                                print(students);
                                              },
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
                                              onPressed:(){
                                                Navigator.pop(context);
                                              },
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
                          ),
                        );
                      }
                  );
                })
          ],),
      ),
    );
  }
}

