import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../../shared/components/local db methods.dart';

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

  static int _len = addresses.length;
  List<bool> isChecked = List.generate(_len, (index) => false);
  String _getTitle() =>
      "Checkbox Demo : Checked = ${isChecked.where((check) => check == true).length}, Unchecked = ${isChecked.where((check) => check == false).length}";
  String _title = "Checkbox Demo";
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  '${studentsData.length}',
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
              child:_len==0?Center(child: CircularProgressIndicator()):
              ListView.separated(
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.all(10),
                      //height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xffC1BDBD),
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                      _title = _getTitle();                  }

                                    );
                                  }
                              )
                          )
                        ],
                      ),
                    ) ;
                  },
                  separatorBuilder: (context, index){
                    return SizedBox(
                      height: 20,
                    );
                  },
                  itemCount: addresses.length,
              ),
            )


          ],
        ),
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
