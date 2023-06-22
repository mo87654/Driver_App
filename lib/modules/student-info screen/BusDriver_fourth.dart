
import 'package:driver_app/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/colors.dart';
import '../../shared/components/driverMethods.dart';
import '../../shared/cubit/states.dart';

class BusdriverStudentInfo extends StatefulWidget {

  BusdriverStudentInfo({
   required this.index,
  });
int index;

  @override
  State<BusdriverStudentInfo> createState() => _BusdriverStudentInfoState(index);
}

class _BusdriverStudentInfoState extends State<BusdriverStudentInfo> {
  _BusdriverStudentInfoState(this.index);
  int index;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
          listener: (context, state){},
          builder: (context, state){
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: appColor(),
                  title: Text(
                      'Student information'
                  ),
                  leading: IconButton(
                    icon: Icon(
                        Icons.arrow_back
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
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
                    ),
                    SizedBox(height: 18,),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                            ),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppCubit.get(context).studentsData[index]['name'],
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400
                                  ),),
                                SizedBox(height: 8,),
                                Text(
                                  AppCubit.get(context).studentsData[index]['grad'],
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                  ),
                                )
                              ],
                            ),

                          ],)
                    ),
                    Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Parent's email :",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w400,

                        ),),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(100, 20, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              AppCubit.get(context).studentsData[index]['email'],
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w400,))
                        ],),
                    ),
                    SizedBox(height: 60,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Parent's tele-number :",style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w400,

                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(100, 20, 0, 0),
                      child: Column(
                        children: [
                          Text(
                              AppCubit.get(context).studentsData[index]['phone'],
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w400,))
                        ],),
                    ),
                  ],
                )
            );
          }
      ),
    );
  }
}
