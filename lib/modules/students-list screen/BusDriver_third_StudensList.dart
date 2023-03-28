import 'package:driver_app/modules/student-info%20screen/BusDriver_fourth.dart';
import 'package:flutter/material.dart';

class BusdriverStudentList extends StatefulWidget {
  BusdriverStudentList({
     this.names,
});
  List? names;

  @override
  State<BusdriverStudentList> createState() => _BusdriverStudentListState(names);
}

class _BusdriverStudentListState extends State<BusdriverStudentList> {
  _BusdriverStudentListState(
    this.names,
);
  List? names;

  @override
  void initState() {
    super.initState();
    print(names);
  }

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
            child: names ==null? Text('hello')
                :ListView.builder(
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
                            Text(names?[index],
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400
                              ),),
                          ],),
                      )
                  ),
              itemCount: names!.length,
            ),
          )
        ],
      );

  }
}




