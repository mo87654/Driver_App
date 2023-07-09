
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
            color: Colors.white,
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
                ),SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF4682B4),
                    borderRadius: BorderRadius.circular(7),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF014EB8), // Darker Blue
                        Color(0xFF4285F4), // Blue
                      ],
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Status indicator widget
                      Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: cubit.selectedColor,
                        ),
                      ),
                      SizedBox(
                          width:15
                      ),
                      Expanded(
                        child: Text(
                          '${cubit.selectedStatus}',
                          // textAlign: TextAlign.center,,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /* IconButton(onPressed: () async {startTimer(getJson(), 4);}, icon: Icon(Icons.play_circle,size: 40,)),
                SizedBox(height: 29,),
                IconButton(onPressed: () async {timer?.cancel();}, icon: Icon(Icons.pause_circle,size: 40,)),
                */
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
                    color: Color(0xFFC0C0C0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                      onPressed: () async {
                        if(cubit.widgetIndex == 1)
                          {
                            confirmationMessage(
                                task: 'Are you sure you want to finish the bus Commute to school?',
                                cubit: cubit,
                                context1: context,
                                position: 1
                            );
                          }else if(cubit.widgetIndex == 3)
                        {
                          confirmationMessage(
                              task: 'Are you sure you want to finish the bus Commute home?',
                              cubit: cubit,
                              context1: context,
                              position: 1
                          );
                        }else if(cubit.widgetIndex == 2)
                        {
                          confirmationMessage(
                              task: 'Are you sure that all students have boarded the bus?',
                              cubit: cubit,
                              context1: context,
                              position: 1
                          );
                        } else
                            {
                              destination(cubit, context);
                            }
                        /* if(cubit.widgetIndex == 1 || cubit.widgetIndex == 3)
                          {
                            cubit.updateDataBase(newIndex: 0, currentIndex: cubit.widgetIndex).then((value) async {
                              await Future.delayed(Duration(milliseconds: 500 ));
                              cubit.deleteDataBase();
                            });
                          }else if(cubit.widgetIndex == 2)
                            {
                              cubit.updateDataBase(newIndex: 3, currentIndex: 2).then((value) async {
                                await Future.delayed(Duration(milliseconds: 500 ));
                                startTimer(leavingNotification(context));
                              });
                            }*/
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
                          onPressed: () async {
                            Navigator.pop(context);
                            cubit.updateDataBase(newIndex: 2, currentIndex: 0).then((value) async {
                              await Future.delayed(Duration(milliseconds: 500 ));
                              startTimer(notification(context1, cubit), 1);
                            });
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
                        onPressed: () async {
                          Navigator.pop(context);
                          cubit.updateDataBase(newIndex: 1, currentIndex: 0).then((value) async {
                            await Future.delayed(Duration(milliseconds: 500 ));
                            startTimer(notification(context1, cubit), 1);
                          });
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


  /*Color getStatusColor(Status status) {
    switch (status) {
      case Status.stopped:
        return Colors.red;
      case Status.onTheWayToSchool:
        return Colors.green;
      case Status.onTheWayHome:
        return Colors.orange;
      default:
        return Colors.transparent;
    }
  }

  String getStatusText(State status) {
    switch (status) {
      case Status.stopped:
        return 'Bus Stopped';
      case Status.onTheWayToSchool:
        return 'On the Way to School';
      case Status.onTheWayHome:
        return 'On the Way Home';
      default:
        return '';
    }
  }
*/

}

