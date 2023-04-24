import 'package:driver_app/modules/student-info%20screen/BusDriver_fourth.dart';
import 'package:flutter/material.dart';
import '../../shared/components/local db methods.dart';
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
                    '${studentsData.length}',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                MaterialButton(
                  color: studentsData.isEmpty? Colors.grey: Colors.red,
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
                      'Delete List',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                    onPressed: (){
                    deletedatabase().then((value){
                      setState(() {

                      });
                    });
                    }
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
            child: studentsData ==null? const Text('hello')
                :ListView.builder(
                  itemBuilder: (context, index) =>
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context)=>BusdriverStudentInfo(index: index,)
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
                            const SizedBox(width: 10,),
                            Text(studentsData[index]['name'],
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400
                              ),),
                          ],),
                      )
                  ),
              itemCount: studentsData.length,
            ),
          )
        ],
      );

  }

}




