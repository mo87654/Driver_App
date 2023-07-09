import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/shared/cubit/cubit.dart';
import 'package:driver_app/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/buttons.dart';
import '../../shared/components/components.dart';
import '../../shared/components/driverMethods.dart';

class DriverAddresses extends StatefulWidget {
  @override
  State<DriverAddresses> createState() => _DriverAddressesState();
}

class _DriverAddressesState extends State<DriverAddresses> {
  @override
  void initState() {
    super.initState();
    // getAddresses();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
        builder: (context, state){
          return Container(
            color: Color(0xFFCCCCCC),
            padding: EdgeInsets.all(10),
            width: double.infinity,
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
                  height: 20,
                ),
                Expanded(
                  child:addresses.isEmpty?Center(child: CircularProgressIndicator()):
                  ListView.separated(
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          setState(() {
                            isChecked[index]=!isChecked[index];
                            if(isChecked[index]==true)
                            {
                              checkColor[index]=Colors.grey[400]!;
                            }else
                            {
                              checkColor[index]=Colors.white;
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsetsDirectional.only(
                            top: 10,
                            end: 10
                          ),
                          decoration: BoxDecoration(
                            color: checkColor[index],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(1, 3),
                              ),
                            ]
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  addresses[index],
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                  //maxLines: 2,
                                ),
                              ),
                              Transform.scale(
                                  scale:1.5,
                                  child: Checkbox(
                                      value: isChecked[index] ,
                                      onChanged: (checked){
                                        setState ((){
                                          isChecked[index] = checked!;
                                          if(isChecked[index]==true)
                                            {
                                              checkColor[index]=Colors.grey[400]!;
                                            }else
                                              {
                                                checkColor[index]=Colors.white;
                                              }
                                          }
                                        );
                                      }
                                  )
                              )
                            ],
                          ),
                        ),
                      ) ;
                    },
                    separatorBuilder: (context, index){
                      return SizedBox(
                        height: 30,
                      );
                    },
                    itemCount: addresses.length,
                  ),
                )


              ],
            ),
          );
        }
    );

  }

 /* void getAddresses () async {
    await FirebaseFirestore.
    instance.
    collection('Students').
    get().then((value){
      value.docs.forEach((element) {
        setState(() {
          addresses.add(element.data()['address']);
        });
      });
    }).catchError((error){
      print(error);
    });
  }*/

}
