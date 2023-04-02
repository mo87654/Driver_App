//import 'package:admin_app/modules/login%20screen/login.dart';
import 'package:driver_app/modules/login%20screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:user_app/modules/login%20screen/login.dart';
//import '../../shared/component/colors.dart';




class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  var formkey = GlobalKey<FormState>();



  @override
  void dispose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  bool showpassword1 = true;
  bool showpassword2 = true;
  bool showpassword3 = true;

  String errorMessage = "";

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;

  ChangePassword123()async{
    try{
      await currentUser!.updatePassword(newPasswordController.text.trim());
      FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login(),), (route) => false);


      //ScaffoldMessenger.of(context).showSnackBar(
      //SnackBar(content: Text("password changed successfully please login again")),);


    }on FirebaseAuthException catch(e){
      setState(() {
        errorMessage = e.message!;
      });


    }

  }

  Widget build(BuildContext context) {
    return Scaffold(


      appBar:AppBar(
        leading:  IconButton(icon:  Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text ('Change Password'),
        backgroundColor: app_color(),



      ),

      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40.0),
              // Padding(
              //   padding: const EdgeInsetsDirectional.only(
              //       start: 20,
              //       end: 20
              //   ),
              //   child: TextFormField(
              //     style: TextStyle(
              //       fontSize: 20,
              //     ),
              //     decoration: InputDecoration(
              //       floatingLabelStyle: TextStyle(
              //         fontSize: 18,
              //       ),
              //       border: OutlineInputBorder(),
              //       labelText:'Current Password',
              //         suffixIcon: IconButton(
              //             onPressed: (){
              //               setState(() {
              //                 showpassword1 = !showpassword1;
              //               });
              //             },
              //             icon: showpassword1? Icon(
              //                 Icons.visibility
              //             ) :
              //             Icon(
              //               Icons.visibility_off,
              //               color: Colors.grey,
              //             )
              //         )
              //     ),
              //     keyboardType: TextInputType.visiblePassword,
              //     textAlignVertical: TextAlignVertical.top,
              //     textInputAction: TextInputAction.next,
              //     obscureText: showpassword1,
              //
              //     validator: (value)
              //     {
              //       if (value!.isEmpty){
              //         return 'Password required';
              //       }
              //       return null;
              //     },
              //
              //   ),
              // ),
              // SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 20,
                    end: 20
                ),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(),
                      labelText:'New Password',
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              showpassword2 = !showpassword2;
                            });
                          },
                          icon: showpassword2? Icon(
                              Icons.visibility
                          ) :
                          Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )
                      )
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textAlignVertical: TextAlignVertical.top,
                  textInputAction: TextInputAction.next,
                  obscureText: showpassword2,
                  controller: newPasswordController,
                  validator: (value)
                  {
                    if (value!.isEmpty){
                      return 'New password required';
                    }
                    return null;
                  },

                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 20,
                    end: 20
                ),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(),
                      labelText:'Confirm New Password',
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              showpassword3 = !showpassword3;
                            });
                          },
                          icon: showpassword3? Icon(
                              Icons.visibility
                          ) :
                          Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )
                      )
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textAlignVertical: TextAlignVertical.top,
                  textInputAction: TextInputAction.done,
                  obscureText: showpassword3,
                  controller: confirmNewPasswordController,
                  validator: (value)
                  {
                    if (value!.isEmpty){
                      return 'Confirm New Password required';

                    } else if (value != newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },

                ),
              ),            //3
              SizedBox(
                  height: 130.0
              ),
              Container(
                height: 45,
                width: double.infinity,
                padding: const EdgeInsetsDirectional.only(start: 20,end: 20),
                child: MaterialButton(
                  onPressed: ()async{
                    if (formkey.currentState!.validate()) {
                      ChangePassword123();

                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("password changed successfully please login again")),);

                  },
                  child:Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,

                    ),
                  ),
                  color: Color(0xff014EB8),
                  shape:RoundedRectangleBorder (
                    borderRadius: BorderRadius.circular (10.0), ),


                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 45,
                width: double.infinity,
                padding: const EdgeInsetsDirectional.only(start: 20,end: 20),
                child: MaterialButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child:Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,

                    ),

                  ),
                  color: Color(0xff818181),
                  shape:RoundedRectangleBorder (
                    borderRadius: BorderRadius.circular (10.0), ),


                ),
              ),            //cancel




            ],
          ),
        ),
      ),
    );
  }

  app_color() {}
}

