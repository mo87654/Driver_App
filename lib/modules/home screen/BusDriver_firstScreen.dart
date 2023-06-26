
import 'dart:async';

import 'package:driver_app/shared/cubit/cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/driverMethods.dart';
import '../../shared/cubit/states.dart';
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
    //getIDs();
    AppCubit.get(context).homeButton();
    instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    });
  }

  Timer? timer;
  /*List studentData = [];
  List ids = [];
  //List students =[];
  var rand ;
  getIDs()async{
    ids.clear();
    await FirebaseFirestore
        .instance
        .collection('Students')
        .where('Bus id',isEqualTo: busNum)
        .get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          ids.add(element.id);
        });
      });

      //getData();
    });
  }
  getData()async{
    rand = null;
    rand = ids[Random().nextInt(ids.length)];
    var dataRef = await FirebaseFirestore
        .instance
        .collection('Students')
        .doc(rand).get();
    studentData.add(dataRef.data());
  }*/
  Widget build(BuildContext context) {
    AppCubit cubit = BlocProvider.of(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){
          cubit.homeButton();
        },
        builder: (context, state){
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
                      '${AppCubit.get(context).studentsData.length}',
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
                Expanded(
                  child: SizedBox(),
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  margin: EdgeInsetsDirectional.only(
                    start: 40,
                    end: 40,
                    bottom: 60,
                  ),
                  child: MaterialButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                      onPressed: (){
                        if(cubit.widgetIndex == 1)
                          {
                            cubit.updateHomeBUttonValue(0);
                            timer?.cancel();
                          }else if(cubit.widgetIndex == 2)
                            {
                              timer?.cancel();
                              setState(() {

                              });
                              cubit.updateHomeBUttonValue(1);
                              /*timer = Timer.periodic(Duration(seconds: 1), (timer) {
                                leavingNotification(context);
                              });*/
                              startTimer(timer, leavingNotification(context, timer));
                            }else{
                          destination(cubit, context);
                        }
                      },
                      child: cubit.selectedText
                  ),
                )
              ],),

          );
        }
    );
  }

  destination(cubit, context1){
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              iconPadding: EdgeInsetsDirectional.only(
                top: 10,
                end: 10,
              ),
              icon: Row(
                children: [
                  Expanded(child: SizedBox()),
                  IconButton(
                    alignment: AlignmentDirectional.topEnd,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ],
              ),
              title: Text(
                'Where are you heading?',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'To :',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        height: 50,
                        color: Colors.grey[300],
                        padding: EdgeInsetsDirectional.only(
                          start: .0001,
                          end: 25,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                          onPressed: (){
                            /*timer = Timer.periodic(Duration(seconds: 1), (timer) {
                              notification(context);
                            });*/
                            startTimer(timer, notification(context1, timer));
                            cubit.updateHomeBUttonValue(2);
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              CircleAvatar(
                                radius: 26,
                                child: Image(
                                  image: AssetImage('assets/images/homeicon.png'),
                                  fit: BoxFit.cover,
                                )
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              )
                            ],
                          ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      MaterialButton(
                        height: 50,
                        color: Colors.grey[300],
                        padding: EdgeInsetsDirectional.only(
                          start: .0001,
                          end: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: (){
                          /*timer = Timer.periodic(Duration(seconds: 1), (timer) {
                            notification(context);
                          });*/
                          startTimer(timer, notification(context1, timer));
                          cubit.updateHomeBUttonValue(1);
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            CircleAvatar(
                                radius: 26,
                                child: Image(
                                  image: AssetImage('assets/images/schoolicon.png'),

                                )
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'School',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}

