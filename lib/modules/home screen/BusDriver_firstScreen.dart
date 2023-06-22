
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
    return BlocConsumer<AppCubit, AppStates>(
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
                SizedBox(
                  height: 300,
                ),
                IconButton(
                    onPressed: (){
                      notification(context);
                    },
                    icon: Icon(
                        Icons.add
                    )
                )
                /*FloatingActionButton(
              backgroundColor: Color(0xff4d6aaa),
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
                                                AppCubit.get(context).insertdatabase(
                                                    name: studentData[0]['name'],
                                                    email: studentData[0]['email'],
                                                    phone: studentData[0]['tele-num'],
                                                    grad: studentData[0]['grad'],
                                                    mac: studentData[0]['MAC-address'],
                                                );
                                                setState(() {});
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
                }),*/
                /*IconButton(onPressed: ()async{
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),), (route) => false);

            },
                icon: Icon(Icons.logout))*/
              ],),

          );
        },
        listener: (context, state){}
    );
  }
}

