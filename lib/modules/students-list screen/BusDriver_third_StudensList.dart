import 'package:driver_app/modules/student-info%20screen/BusDriver_fourth.dart';
import 'package:flutter/material.dart';
class Studmodel {
  final String name;
  Studmodel({
    required this.name
  });
}

class BusdriverStudentList extends StatefulWidget {


  @override
  State<BusdriverStudentList> createState() => _BusdriverStudentListState();
}

class _BusdriverStudentListState extends State<BusdriverStudentList> {
  List <Studmodel> student =[
    Studmodel(name: 'Student 1'),
    Studmodel(name: 'Student 2'),
    Studmodel(name: 'Student 3'),
    Studmodel(name: 'Student 4'),
    Studmodel(name: 'Student 5'),
    Studmodel(name: 'Student 6'),
    Studmodel(name: 'Student 7'),
    Studmodel(name: 'Student 8'),
    Studmodel(name: 'Student 9'),
    Studmodel(name: 'Student 10'),
    Studmodel(name: 'Student 11'),
    Studmodel(name: 'Student 12'),
  ];

  @override
  Widget build(BuildContext context) {
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
                Text(
                  '22',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey,

          ),

          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) =>
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>BusdriverStudentInfo()
                              )
                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: Text(
                                  '${index+1}'
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(student[index].name,style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400
                            ),),
                          ],),
                      )
                  ),
              itemCount: student.length,
            ),
          )
        ],
      );

  }
}




