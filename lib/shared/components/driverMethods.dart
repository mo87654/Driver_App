import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../cubit/cubit.dart';
import 'package:path/path.dart';


double? height;
double? width;
var busNum;
Timer? timer;
List addresses=[];
List MACaddress= [];
List studentPopUpInfo = [];

Future getbusNum() async {
  var user = FirebaseAuth.
  instance.currentUser;
  await FirebaseFirestore.
  instance.
  collection('Drivers').
  doc(user?.uid).
  get().then((value){
    busNum = value.data()!['Bus_number'];
    //getAddresses();
  }).catchError((Error){
    print(Error);
  });
}

void getAddresses () async {
  addresses.clear();
  await FirebaseFirestore.
  instance.
  collection('Students').
  where('Bus_number',isEqualTo: busNum).
  get().then((value){
    value.docs.forEach((element) {
        addresses.add(element.data()['address']);
        MACaddress.add(element.data()['MAC-address']);
    });
  }).catchError((error){
    print(error);
  });
}

 notification(context) async {
   //await Future.delayed(Duration(milliseconds: 1000 ));
   if(AppCubit.get(context).widgetIndex == 1 || AppCubit.get(context).widgetIndex == 2)
   {
    timer?.cancel();
    List existingMAC = [];
    existingMAC.clear();
    for (var k = 0; k < AppCubit.get(context).studentsData.length; k++) {
      existingMAC.add(AppCubit.get(context).studentsData[k]['mac']);
    }
    for (var i = 0; i < macFromESP.length; i++) {
      for (var j = 0; j < MACaddress.length; j++) {
        Completer<void> completer = Completer<void>();
        if (macFromESP[i]['MAC'] == MACaddress[j]) {
          await getStudentData(MACaddress[j]).then((value) async {
            if (AppCubit.get(context).studentsData.isNotEmpty) {
              if (existingMAC.contains(MACaddress[j])) {
                // print('student exist');
              } else {
                popUpMessage(completer, context, 'Boarding The Bus', true);
                await completer.future;
                await Future.delayed(Duration(seconds: 1));
                // print('not exist show pop up');
              }
            } else {
              popUpMessage(completer, context, 'Boarding The Bus', true);
              await completer.future;
              await Future.delayed(Duration(seconds: 1));
              // print('first show pop up');
            }
          });
        }
      }
    }
    startTimer(notification(context));
  }
}


Future popUpMessage(completer, context1, status, bool state, [sdbIndex]){

  return showDialog(
      barrierDismissible: false,
      context: context1,
      builder: (context){
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: height! * .08,
                  width: width! * .87,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      state == true?
                      Expanded(
                        child: Text(
                          ("Bus number: ${studentPopUpInfo[0]['Bus_number']}"),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ) :
                      Expanded(
                            child: Text(
                              ("Bus number: ${AppCubit.get(context1).studentsData[sdbIndex]['busNum']}"),
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
                  height: height! * .29,
                  width: width! * .53,
                  child: Image(
                    image: AssetImage('assets/images/student.png'),
                    fit:BoxFit.cover ,
                  ),

                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: height! * .17,
                  width: width! * .87,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state == true?
                      Expanded(
                        child: Text(
                          studentPopUpInfo[0]['name'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ) :
                      Expanded(
                              child: Text(
                                AppCubit.get(context1).studentsData[sdbIndex]['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                      state == true?
                      Expanded(
                        child: Text(
                          studentPopUpInfo[0]['grad'],
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ):
                      Expanded(
                        child: Text(
                          AppCubit.get(context1).studentsData[sdbIndex]['grad'],
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height! * .17 * .08,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            MaterialButton(
                              onPressed:() async {
                                if (state==true)
                                  {
                                    await AppCubit.get(context1).insertDataBase(
                                      name  : studentPopUpInfo[0]['name'],
                                      busNum: studentPopUpInfo[0]['Bus_number'],
                                      phone : studentPopUpInfo[0]['tele-num'],
                                      grad  : studentPopUpInfo[0]['grad'],
                                      mac   : studentPopUpInfo[0]['MAC-address'],
                                    );
                                  }else
                                    {
                                      AppCubit.get(context1).deleteRecord(AppCubit.get(context1).studentsData[sdbIndex]['id']);
                                    }
                                completer.complete();
                                Navigator.pop(context);
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
                                completer.complete();
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
}

confirmationMessage({
  required String task,
  required cubit,
  required context1,
  required int position,
  id,
}){
  return showDialog(
      barrierDismissible: false,
      context: context1,
      builder: (context){
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            title: Text(
              'Confirmation',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  task,
                  style: TextStyle(
                      fontSize: 23
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      height: 50,
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        if(position == 1)
                          {
                            if(cubit.widgetIndex == 1 || cubit.widgetIndex == 3)
                            {
                              cubit.updateDataBase(newIndex: 0, currentIndex: cubit.widgetIndex).then((value) async {
                                await Future.delayed(Duration(milliseconds: 500 ));
                                cubit.deleteDataBase();
                              });
                            }else if(cubit.widgetIndex == 2)
                            {
                              cubit.updateDataBase(newIndex: 3, currentIndex: 2).then((value) async {
                                await Future.delayed(Duration(milliseconds: 500 ));
                                startTimer(leavingNotification(context1));
                              });
                            }
                          }else
                            {
                              cubit.deleteRecord(id);
                            }
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    MaterialButton(
                      height: 50,
                      color: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'No',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white
                        ),
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

Future getStudentData(String MAC) async {
  studentPopUpInfo.clear();
  await FirebaseFirestore.
  instance.
  collection('Students').
  where('MAC-address',isEqualTo: MAC).
  get().then((value){
   // studentPopUpInfo.clear();
    value.docs.forEach((element) {
        studentPopUpInfo.add(element.data());
    });
  });
}

leavingNotification(context) async {
  if(AppCubit.get(context).widgetIndex == 3)
  {
    timer?.cancel();
    List espMac = [];
    for (var j = 0; j < macFromESP.length; j++) {
      espMac.add(macFromESP[j]['MAC']);
    }
    for (var i = 0; i < AppCubit.get(context).studentsData.length; i++) {
      Completer<void> completer2 = Completer<void>();
      if (espMac.contains(AppCubit.get(context).studentsData[i]['mac'])) {
        //student still ridding the bus
        await Future.delayed(Duration(seconds: 1));
      } else {
        popUpMessage(completer2, context, 'Leaving The Bus', false, i);
        await completer2.future;
        await Future.delayed(Duration(seconds: 1));
      }
    }
    startTimer(leavingNotification(context));
  }
}

startTimer(function){
  timer = Timer.periodic(Duration(seconds: 1), (timer) {
    function;
  });
}

//dangerous !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
deleteAllDataBase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'local_database.db');
  await deleteDatabase(path);
  print('database has been deleted');
}

//==========json file function============
List<dynamic> macFromESP=[
  {'MAC': 'c8:8f:66:c3:1f:36'},
  {'MAC': '86:36:46:c8:86:f0'},

];
List<dynamic> allStudents=[
  {'MAC': 'c8:8f:66:c3:1f:36'},
  {'MAC': '86:36:46:c8:86:f0'},
  {'MAC': '79:fc:d1:36:08:7d'},
  {'MAC': 'd9:e3:80:22:9a:66'}
];
var json;
Future getJson ()async{
  var url=Uri.parse("https://script.googleusercontent.com/macros/echo?user_content_key=-txHhINBYG_HjSvyno1jrTZeb1ilWM4YBuGLlB17c6QnK4wLQAwAYc9pHY5EeHisDy7g8psalO0zZUUhVh7hC-OtQxlk86Jem5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnHqnKnpp1zTdfFN17X2Kveefnko7KPRe5NqUQQgRuFkDHB_7otA1G7S3cJotgUotvvcCCXpHvgrsZrYxGGIXmoCq0UjEOUCR1Nz9Jw9Md8uu&lib=MuaA7e0PjPiH0jPT4P62uuWSLqXWK-X04");
  json = await http.read(url).then((value){
    macFromESP = jsonDecode(value);
  });
}


