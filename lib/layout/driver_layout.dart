import 'dart:async';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/shared/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
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
import '../shared/components/driverMethods.dart';
import '../shared/cubit/cubit.dart';

class DriverLayout extends StatefulWidget {

  @override
  State<DriverLayout> createState() => _DriverLayoutState();
}
class _DriverLayoutState extends State<DriverLayout> {



  Future<void> checkLocationService ()async{

    Location location = new Location();


    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    // LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        SystemNavigator.pop();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        SystemNavigator.pop();

      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      String userId = FirebaseAuth.instance.currentUser!.uid.toString();
      DocumentReference ref = FirebaseFirestore.instance
          .collection("Drivers").doc(userId);
      ref.update({
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude,

      }).then((value) {
      }).catchError((error) {
      });
    });


  }


  @override
  void initState(){
    super.initState();
    getbusNum().then((value) {
      getAddresses();
      checkLocationService();
    });
    //getJson(); //her lies json get <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  }


  // var currentIndex = 3;
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
  int _currentIndex = 3;
  final List<IconData> _iconList = [
    Icons.account_box_outlined,
    Icons.location_on,
    Icons.view_list_outlined,
    Icons.home_outlined,

  ];

  final user =  FirebaseAuth.instance.currentUser!;


  Future<Object> getuserinfo() async {
    final CollectionReference users = FirebaseFirestore.instance.collection('Drivers');
    final String uid = user.uid;
    final result = await  users.doc(uid).get();
    return result.data()??['name'];

  }
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    List<Widget> leadingicon = [
      Text(' '),
      driverLeading(
          onpressedfun: (){
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
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDB(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
          builder: (context, state) {
            return Scaffold(
              drawerEnableOpenDragGesture: false,
              appBar: AppBar(
                backgroundColor: appColor(),
                leading: leadingicon[3 - _currentIndex],
                title: Text(
                  title[3 - _currentIndex],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),
              drawer: SafeArea(
                child: Drawer(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: FutureBuilder(
                          future: getuserinfo(),
                          builder: (_, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Text(snapshot.data['name'].toString(),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,

                              ),
                            );
                          },
                        ),

                        subtitle: FutureBuilder(
                          future: getuserinfo(),
                          builder: (_, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Text(snapshot.data['email'].toString(),

                            );
                          },
                        ),
                        onTap: () {

                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            right: 24, top: 24, bottom: 16),
                        child: Divider(
                          color: Colors.black26,
                          height: 1,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.perm_contact_cal_outlined),
                        title: const Text(' Edit Profile ',
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
                            child: Switch(onChanged: (bool value) {},
                              value: true,
                              activeColor: appColor(),),
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

                        onTap: () {
                          showDialog(
                            context: context, builder: (BuildContext context) =>
                              SignOutMessage(),
                          );
                        },
                      ),
                    ],
                  ),


                ),
              ),
              body: driverScreens[3 - _currentIndex],
              bottomNavigationBar: AnimatedBottomNavigationBar(
                splashRadius: 50,
                iconSize: 30,
                inactiveColor: Colors.white,
                activeColor: Colors.white,
                backgroundColor: Color(0xff4d6aaa),
                splashColor: Colors.cyan,
                icons: _iconList,
                activeIndex: _currentIndex,
                splashSpeedInMilliseconds: 500,
                gapLocation: GapLocation.none,
                leftCornerRadius: 32,
                rightCornerRadius: 32,
                notchSmoothness: NotchSmoothness.defaultEdge,
                shadow: const BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 15,
                  spreadRadius: 0.7,
                  color: Color(0xff4d6aaa),
                ),


                onTap: (index) => setState(() => _currentIndex = index),

              ),

            );

          }
      ),
    );
  }

}
