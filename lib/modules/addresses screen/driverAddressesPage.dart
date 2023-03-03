import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverAddresses extends StatefulWidget {
  @override
  State<DriverAddresses> createState() => _DriverAddressesState();
}

class _DriverAddressesState extends State<DriverAddresses> {
  @override
  void initState() {
    super.initState();
  }
  static int _len = 10;
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
                  '22',
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
              child: ListView.separated(
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
                              'address ##################################',
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
                  itemCount: _len,
              ),
            )


          ],
        ),
      );

  }

}
