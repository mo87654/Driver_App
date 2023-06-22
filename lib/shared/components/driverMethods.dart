import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../cubit/cubit.dart';

double? height;
double? width;
var busNum;
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

Future notification(context) async {
 var i = 0;
 while(i < 1){
   List existingMAC=[];
   existingMAC.clear();
   for(var k=0;k<AppCubit.get(context).studentsData.length;k++)
   {
     existingMAC.add(AppCubit.get(context).studentsData[k]['mac']);
   }
   for(var i = 0;i<macFromESP.length;i++)
   {
     for(var j=0;j<MACaddress.length;j++)
     {
       Completer<void> completer = Completer<void>();
       if(macFromESP[i]['MAC']==MACaddress[j])
       {
         await getStudentData(MACaddress[j]).then((value) async {
           if(AppCubit.get(context).studentsData.isNotEmpty)
           {
             if(existingMAC.contains(MACaddress[j]))
             {
               // print('student exist');
             }else
             {
               popUpMessage(completer, context, 'Boarding The Bus', true);
               await completer.future;
               // print('not exist show pop up');
             }
           }else
           {
             popUpMessage(completer, context, 'Boarding The Bus', true);
             await completer.future;
             //print('first show pop up');
           }
         });
       }
     }
   }
   i++;
 }
}

Future popUpMessage(completer, context1, status, bool state){
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
                      Expanded(
                        child: Text(
                          ("Bus number: ${studentPopUpInfo[0]['Bus_number']}"),
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
                      Expanded(
                        child: Text(
                          studentPopUpInfo[0]['name'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Text(
                          studentPopUpInfo[0]['grad'],
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
                              onPressed:(){
                                if (state==true)
                                  {
                                    AppCubit.get(context1).insertdatabase(
                                      name: studentPopUpInfo[0]['name'],
                                      email: studentPopUpInfo[0]['email'],
                                      phone: studentPopUpInfo[0]['tele-num'],
                                      grad: studentPopUpInfo[0]['grad'],
                                      mac: studentPopUpInfo[0]['MAC-address'],
                                    );
                                  }else
                                    {}
                                Navigator.pop(context);
                                completer.complete();
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

Future getStudentData(String MAC) async {
  await FirebaseFirestore.
  instance.
  collection('Students').
  where('MAC-address',isEqualTo: MAC).
  get().then((value){
    studentPopUpInfo.clear();
    value.docs.forEach((element) {
        studentPopUpInfo.add(element.data());
    });
  });
}

leavingNotification(context) async {
  List espMac = [];
  //espMac.clear();
  for(var j=0;j<macFromESP.length;j++ )
  {
    espMac.add(macFromESP[j]['MAC']);
  }
  for(var i=0;i<allStudents.length;i++)
    {
      Completer<void> completer = Completer<void>();
      if(espMac.contains(allStudents[i]['MAC']))
        {
          print('student still ridding the bus');
        }else
          {
            getStudentData(allStudents[i]['MAC']).then((value) async {
              popUpMessage(completer, context, 'Leaving The Bus', false);
              await completer.future;
              print('student leave the bus');
            });
          }
    }
  print(espMac);
}

//==========json file function============
List<dynamic> macFromESP=[
  {'MAC': 'c8:8f:66:c3:1f:36'},
  {'MAC': '86:36:46:c8:86:f0'},
  {'MAC': '79:fc:d1:36:08:7d'},
];
List<dynamic> allStudents=[
  {'MAC': 'c8:8f:66:c3:1f:36'},
  {'MAC': '86:36:46:c8:86:f0'},
  {'MAC': '79:fc:d1:36:08:7d'},
  {'MAC': 'd9:e3:80:22:9a:66'}
];
var json;
/*Future getJson ()async{
  var url=Uri.parse("https://script.googleusercontent.com/macros/echo?user_content_key=-txHhINBYG_HjSvyno1jrTZeb1ilWM4YBuGLlB17c6QnK4wLQAwAYc9pHY5EeHisDy7g8psalO0zZUUhVh7hC-OtQxlk86Jem5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnHqnKnpp1zTdfFN17X2Kveefnko7KPRe5NqUQQgRuFkDHB_7otA1G7S3cJotgUotvvcCCXpHvgrsZrYxGGIXmoCq0UjEOUCR1Nz9Jw9Md8uu&lib=MuaA7e0PjPiH0jPT4P62uuWSLqXWK-X04");
  json = await http.read(url).then((value){
    macFromESP = jsonDecode(value);
  });
}*/
