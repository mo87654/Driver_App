
import 'package:driver_app/shared/cubit/cubit.dart';
import 'package:driver_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../../shared/components/driverMethods.dart';

class BusdriverStudentList extends StatefulWidget {
  const BusdriverStudentList({super.key});


  @override
  State<BusdriverStudentList> createState() => _BusdriverStudentListState();
}

class _BusdriverStudentListState extends State<BusdriverStudentList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = BlocProvider.of(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state){
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        '${cubit.studentsData.length}',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                   /* MaterialButton(
                        color: cubit.studentsData.isEmpty? Colors.grey: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),),
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 25,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Delete DataBase',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        onPressed: () async {}
                    )*/
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,

              ),
              Expanded(
                child: cubit.studentsData.isEmpty?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_off,
                          size: 100,
                          color: Colors.grey,
                        ),
                        Text(
                          'There is no student yet!',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey
                          ),
                        )
                      ],
                    )
                    :ListView.builder(
                     itemBuilder: (context, index) =>
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              studentInformation(cubit, index, context);
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  child: Text(
                                      '${index+1}'
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Text(cubit.studentsData[index]['name'],
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400
                                  ),),
                              ],),
                          )
                      ),
                  itemCount: cubit.studentsData.length,
                ),
              )
            ],
          );
        }
    );
  }

  studentInformation(cubit, index, context1){
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context){
          return WillPopScope(
            onWillPop: () => Future.value(true),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),

              title: Text(
                'Studnt Information',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              content: Column(
                 mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image(
                          image: AssetImage('assets/images/student.png'),
                          fit:BoxFit.cover ,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.studentsData[index]['name'],
                            style: TextStyle(
                              fontSize: 22
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            cubit.studentsData[index]['grad'],
                            style: TextStyle(
                              fontSize: 18
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Parent Number',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                            UrlLauncher.launchUrl(Uri.parse('tel:+${cubit.studentsData[index]['phone']}'));
                          },
                          child: Text(
                            cubit.studentsData[index]['phone'],
                            style: TextStyle(
                              fontSize: 20
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 100));
                      Navigator.pop(context);
                      await Future.delayed(Duration(milliseconds: 500));
                      confirmationMessage(
                        task: 'Are you sure you want to delete this student?',
                        cubit: cubit,
                        context1: context1,
                        position: 2,
                        id: cubit.studentsData[index]['id']
                    );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Delete Student',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
              actionsPadding: EdgeInsetsDirectional.only(bottom: 20),
            ),
          );
        }
    );
  }


  /*void makePhoneCall(phone) async {
    String phoneNumber = 'tel:+$phone';
    if (await canLaunchUrl(phoneNumber as Uri)) {
      await launchUrl(phoneNumber as Uri);
    } else {
      print('Could not make phone call');
    }
  }*/


}




