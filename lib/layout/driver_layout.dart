import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../modules/addresses screen/driverAddressesPage.dart';
import '../modules/home screen/BusDriver_firstScreen.dart';
import '../modules/my account screen/My_account.dart';
import '../modules/change password screen/change_password.dart';
import '../modules/help screen/help_screen.dart';
import '../modules/personal info screen/personal_info.dart';
import '../modules/students-list screen/BusDriver_third_StudensList.dart';
import '../shared/components/SignoutMessage.dart';
import '../shared/components/colors.dart';
import '../shared/components/components.dart';
import '../shared/components/local db methods.dart';

class DriverLayout extends StatefulWidget {

  @override
  State<DriverLayout> createState() => _DriverLayoutState();
}

class _DriverLayoutState extends State<DriverLayout> {

  @override
  void initState(){
    super.initState();
    createDB();
    getbusID().then((value) {
      getAddresses();
    });
    getJson(); //her lies json get <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  }
  double? height;
  double? width;
  var currentIndex = 3;
  List<Widget> driverScreens =[
    BusDriverHome(),
    BusdriverStudentList(),
    DriverAddresses(),
    MyAccount()
  ];
  List<String> title =[
    'Home',
    'Students List',
    'Addresses List',
    'My account'
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    List<Widget> leadingicon = [
      Text(' '),
      driverLeading(
          onpressedfun: (){
            //notification();
          }
      ),
      driverLeading(
          onpressedfun: (){
            Navigator.pop(context);
          }
      ),
      Builder(
          builder: (context) {
            return IconButton(icon: const Icon(Icons.menu), onPressed: () {  Scaffold.of(context).openDrawer(); },

            );
          }
      ),
    ];
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        backgroundColor: appColor(),
        leading: leadingicon[3 - currentIndex],
        title: Text(
          title[3 - currentIndex],
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

      ),
      drawer:   SafeArea(
        child: Drawer(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('User name ',
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),
                subtitle: const Text('E-mail address',
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Padding(
                padding: EdgeInsets.only(right: 24,top: 24, bottom: 16),
                child: Divider(
                  color: Colors.black26,
                  height: 1,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.perm_contact_cal_outlined),
                title: const Text(' Profile Details ',
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),

                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => PersonalInfo()
                      )
                  );
                },
              ),

              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.notification_important),
                      title: const Text('Notifications',
                        style: TextStyle(
                            fontSize: 17
                        ),

                      ),

                      onTap: () {
                        Navigator.pop(context);
                      },

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Switch(onChanged: (bool value) {  }, value: true, activeColor: appColor(),),
                  ),
                ],
              ),

              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Change Password',
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),

                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()
                      )
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  color: Colors.black26,
                  height: 1,
                ),
              ),

              ListTile(
                leading: const Icon(Icons.error),
                title: const Text('About us',
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),

                onTap: () {
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help!',
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),

                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => HelpPage()
                      )
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log Out',
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),

                onTap: () {showDialog(
                  context: context, builder: (BuildContext context) => SignOutMessage(),
                );
                  },
              ),
            ],
          ),


        ),
      ),
      body:driverScreens[3 - currentIndex] ,
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 35,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: currentIndex,
          backgroundColor: appColor(),
          type: BottomNavigationBarType.fixed,
          onTap: (index){
            setState(() {
              currentIndex = index;
            });
          },
          items:[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_box_outlined,
                ),
                label: ' ',
                activeIcon: Icon(
                  Icons.account_box,
                )
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.location_on_outlined,
                ),
                label: ' ',
                activeIcon: Icon(
                    Icons.location_on
                )
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list_alt,
                ),
                label: ' ',
                activeIcon: Icon(
                  Icons.view_list_outlined,
                )
            ),
            BottomNavigationBarItem(
                icon: Icon(

                  Icons.home_outlined,
                ),
                label: ' ',
                activeIcon: Icon(
                    Icons.home
                )
            ),
          ]
      ),
    );
  }

  Future getbusID() async {
    var user = FirebaseAuth.
    instance.currentUser;
    await FirebaseFirestore.
    instance.
    collection('Drivers').
    doc(user?.uid).
    get().then((value){
      busid = value.data()!['Bus id'];
      //getAddresses();
    }).catchError((Error){
      print(Error);
    });
  }
  void getAddresses () async {
    addresses.clear();
    await FirebaseFirestore.
    instance.
    collection('Students').
    where('Bus id',isEqualTo: busid).
    get().then((value){
      value.docs.forEach((element) {
        setState(() {
          addresses.add(element.data()['address']);
          MACaddress.add(element.data()['MAC-address']);
        });
      });
    }).catchError((error){
      print(error);
    });
  }
  Future notification() async {
    List existingMAC=[];
    for(var i = 0;i<macFromESP.length;i++)
      {
        for(var j=0;j<MACaddress.length;j++)
          {
            if(macFromESP[i]['MAC']==MACaddress[j])
              {
                await getStudentData(MACaddress[j]).then((value){
                  if(studentsData.isNotEmpty)
                  {
                    for(var k=0;k<studentsData.length;k++)
                    {
                      existingMAC.add(studentsData[k]['mac']);
                    }
                    if(existingMAC.contains(MACaddress[j]))
                    {
                     // print('student exist');
                    }else
                    {
                      pop_upMessage();
                     // print('not exist show pop up');
                    }
                  }else
                  {
                    pop_upMessage();
                   // print('first show pop up');
                  }
                });
              }
          }
      }
  }
  Future pop_upMessage(){
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: height! * .08,
                    width: width! * .87,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Status',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                           studentPopUpInfo[0]['Bus id'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: height! * .29,
                    width: width! * .53,
                    child: Image(
                      image: AssetImage('assets/images/student.png'),
                      fit:BoxFit.cover ,
                    ),

                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: height! * .17,
                    width: width! * .87,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            studentPopUpInfo[0]['name'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            studentPopUpInfo[0]['grad'],
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height! * .17 * .08,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              MaterialButton(
                                onPressed:(){
                                  /*insertdatabase(
                                    name: studentData[0]['name'],
                                    email: studentData[0]['email'],
                                    phone: studentData[0]['tele-num'],
                                    grad: studentData[0]['grad'],
                                    mac: studentData[0]['MAC-address'],
                                  );*/
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'APPROVE',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              MaterialButton(
                                onPressed:(){
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'DENY',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
  Future getStudentData(String MAC) async {
    await FirebaseFirestore.
    instance.
    collection('Students').
    where('MAC-address',isEqualTo: MAC).
    get().then((value){
      studentPopUpInfo.clear();
      value.docs.forEach((element) {
        setState(() {
          studentPopUpInfo.add(element.data());
        });
      });
    });
  }
}
