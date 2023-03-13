
import 'package:flutter/material.dart';

import '../../shared/components/colors.dart';

class BusdriverStudentInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
                  '22',
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
                    Text("Student",style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400
                    ),),
                    SizedBox(height: 8,),
                    Text(
                      "Grade",
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
            child: Text("Parent's email :",style: TextStyle(
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
              Text("356788@####.com",style: TextStyle(
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
                Text("012445566777",style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w400,))
              ],),
          ),
        ],
      )
    );
  }
}
