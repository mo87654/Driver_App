import 'package:flutter/material.dart';
import '../modules/addresses screen/driverAddressesPage.dart';
import '../modules/home screen/BusDriver_firstScreen.dart';
import '../modules/my account screen/My_account.dart';
import '../modules/change password screen/change_password.dart';
import '../modules/help screen/help_screen.dart';
import '../modules/personal info screen/personal_info.dart';
import '../modules/students-list screen/BusDriver_third_StudensList.dart';
import '../shared/components/colors.dart';
import '../shared/components/components.dart';

class DriverLayout extends StatefulWidget {
  const DriverLayout({Key? key}) : super(key: key);

  @override
  State<DriverLayout> createState() => _DriverLayoutState();
}

class _DriverLayoutState extends State<DriverLayout> {
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
    List<Widget> leadingicon = [
      Text(' '),
      driverLeading(
          onpressedfun: (){
            Navigator.pop(context);
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

                onTap: () {
                  Navigator.pop(context);
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
}
