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
              itemBuilder: (context, index) => buildStudItem(student[index], index+1),
              itemCount: student.length,
            ),
          )
        ],
      );

  }
}
Widget buildStudItem(Studmodel student, var num) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: (){ print('kesdf');},
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            child: Text(
              '$num'
            ),
          ),
          SizedBox(width: 10,),
          Text(student.name,style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400
          ),),
        ],),
    )
);



