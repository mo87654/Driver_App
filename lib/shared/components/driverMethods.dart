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
   timer?.cancel();
   await Future.delayed(Duration(milliseconds: 1000 ));
   if(AppCubit.get(context).widgetIndex == 1 || AppCubit.get(context).widgetIndex == 2)
   {
     getJson().then((value){
       getMacList();
     });
    for (var i = 0; i < espMACsList.length; i++)
    {
      List existingMAC = [];
      for (var k = 0; k < AppCubit.get(context).studentsData.length; k++)
      {
        existingMAC.add(AppCubit.get(context).studentsData[k]['mac']);
      }
      for (var j = 0; j < MACaddress.length; j++)
      {
        Completer<void> completer = Completer<void>();
        if (espMACsList[i] == MACaddress[j] && (AppCubit.get(context).widgetIndex == 1 || AppCubit.get(context).widgetIndex == 2))
        {
          await getStudentData(MACaddress[j]).then((value) async {
            if (AppCubit.get(context).studentsData.isNotEmpty)
            {
              if (existingMAC.contains(MACaddress[j])) {
                await Future.delayed(Duration(seconds: 1));
                print('student exist');
              } else {
                popUpMessage(completer, context, 'Boarding The Bus', true);
                await completer.future;
                await Future.delayed(Duration(seconds: 1));
                print('not exist show pop up');
              }
            } else {
              print('first show pop up');
              popUpMessage(completer, context, 'Boarding The Bus', true);
              await completer.future;
              await Future.delayed(Duration(seconds: 1));
            }
          });
        }
      }
    }
    startTimer(notification(context), 1);
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
                                    )?.then((value){
                                    });
                                    Future.delayed(Duration(milliseconds: 500));
                                    updateState(newState: 1, mac: studentPopUpInfo[0]['MAC-address'],);
                                  }else
                                    {
                                      updateState(newState: 0, mac: AppCubit.get(context1).studentsData[sdbIndex]['mac']);
                                      await Future.delayed(Duration(seconds: 1));
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
                              if(cubit.widgetIndex == 1)
                                {
                                  updateAllStudentState(cubit, 2)?.then((value) async {
                                    await Future.delayed(Duration(milliseconds: 50 ));
                                  });
                                }else if(cubit.widgetIndex == 3)
                                  {
                                    updateAllStudentState(cubit, 0)?.then((value) async {
                                      await Future.delayed(Duration(milliseconds: 50 ));
                                    });
                                  }
                              cubit.updateDataBase(newIndex: 0, currentIndex: cubit.widgetIndex).then((value) async {
                                await Future.delayed(Duration(milliseconds: 500 ));
                                cubit.deleteDataBase();
                              });
                            }else if(cubit.widgetIndex == 2)
                            {
                              cubit.updateDataBase(newIndex: 3, currentIndex: 2).then((value) async {
                                await Future.delayed(Duration(milliseconds: 500 ));
                                startTimer(leavingNotification(context1), 1);
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
  timer?.cancel();
  await Future.delayed(Duration(milliseconds: 1000 ));
  if(AppCubit.get(context).widgetIndex == 3)
  {
    getJson().then((value){
      getMacList();
    });
    for (var i = 0; i < AppCubit.get(context).studentsData.length; i++) {
      Completer<void> completer2 = Completer<void>();
      if (espMACsList.contains(AppCubit.get(context).studentsData[i]['mac']) && AppCubit.get(context).widgetIndex == 3) {
        //student still ridding the bus
        await Future.delayed(Duration(seconds: 1));
      } else {
        popUpMessage(completer2, context, 'Leaving The Bus', false, i);
        await completer2.future;
        await Future.delayed(Duration(seconds: 1));
      }
    }
    startTimer(leavingNotification(context), 20);
  }
}

startTimer(function, time){
  timer = Timer.periodic(Duration(seconds: time), (timer) {
    function;
  });
}

Future getStudentID(mac) async {
  String? id;
   await FirebaseFirestore
      .instance
      .collection('Students')
      .where('MAC-address',isEqualTo: mac)
      .get().then((value) {
    value.docs.forEach((element) {
      id = element.id;
    });
  });
   return id;
}

Future? updateState({
  required newState,
  required mac,
}){
  getStudentID(mac).then((value) async {
    print(value);
    await FirebaseFirestore
        .instance
        .collection('Students')
        .doc(value)
        .update({
          'state' : newState.toString()
        });
  });
  return null;
}

Future? updateAllStudentState(cubit, newstate){
  for(var i=0;i<cubit.studentsData.length;i++)
    {
      updateState(newState: newstate, mac: cubit.studentsData[i]['mac']);
    }
  return null;
}

//dangerous !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
deleteAllDataBase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'local_database.db');
  await deleteDatabase(path);
  print('database has been deleted');
}

//==========json file function============
List<dynamic> macFromESP=[];
List<dynamic> allStudents=[
  {'MAC': 'c8:8f:66:c3:1f:36'},
  {'MAC': '86:36:46:c8:86:f0'},
  {'MAC': '79:fc:d1:36:08:7d'},
  {'MAC': 'd9:e3:80:22:9a:66'},
  ["59:2b:3b:3e:28:bf", "80:cf:a2:19:db:cf"]
];



var json;
List<dynamic> espMACsList = []; // Change the type to List<dynamic>

Future<void> getJson() async {
  var url = Uri.parse("https://script.google.com/macros/s/AKfycbwVY1lj4BwWAMxEhSiSrAoheBNfFreaERFLJ6K61pafvSntMVzgWzc0cFTEVcxjsu1aPg/exec");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    json = response.body;
    macFromESP = jsonDecode(json);
  } else {
    print('Failed to fetch JSON data');
  }
}

void getMacList() {
  espMACsList.clear();

  for (var item in macFromESP) {
    var macValue = item['MAC'];
    if (macValue != null && macValue.isNotEmpty) {
      if (macValue.startsWith('[') && macValue.endsWith(']')) {
        var macList = jsonDecode(macValue);
        espMACsList.addAll(macList.map((value) => value.toString())); // Explicitly cast to String
      } else {
        espMACsList.add(macValue.toString()); // Explicitly cast to String
      }
    }
  }
}



/*
void getMacList() {
  espMACsList.clear();
  for(var i=0;i<macFromESP.length;i++)
    {
      espMACsList.addAll(macFromESP[i]['MAC']);
    }
  */
/*for (var map in macFromESP) {
    for (var values in map.values) {
      espMACsList.addAll(values.cast<dynamic>());
    }
  }*//*

  print(espMACsList);
}
*/


/*
var json;
Future getJson ()async{
  // timer?.cancel();
  var url=Uri.parse("https://script.google.com/macros/s/AKfycbwbgZVazPngFDkTj2inxZJkGiIr-fzS0vgIDKR-PSAzik8ghUeSmjIjexPIM5hVewuWzg/exec");
  json = await http.get(url).then((value){
    macFromESP = jsonDecode(value.body);
  }).catchError((error){
    print(error);
  });
  print(macFromESP);
  getMacList();
  return null;
}
List espMACsList= [];
getMacList(){
  espMACsList.clear();
  for (var map in macFromESP) {
    for (var values in map.values) {
      espMACsList.addAll(values);
    }
  }
  print(espMACsList);
}
*/

/*
Future<void> getJson() async {
  var url = Uri.parse(
      'https://script.google.com/macros/s/AKfycbzMlP_FMH_lHKAr7oksb_gQbyGjl7ePTZ9eWt4Ykt5vsF39mpuJ_DQ2mQ5eqGxLVJRT/exec');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    macFromESP = jsonDecode(response.body);
    print(macFromESP);
    print(macFromESP.length);
  } else {
    print('Failed to fetch JSON data');
  }
  await Future.delayed(Duration(seconds: 3));
  startTimer(getJson);
}
*/


