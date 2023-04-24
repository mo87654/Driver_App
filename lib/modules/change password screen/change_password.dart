
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../shared/components/colors.dart';
import '../my account screen/My_account.dart';




class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  var formkey = GlobalKey<FormState>();



  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  bool showpassword1 = true;
  bool showpassword2 = true;
  bool showpassword3 = true;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  ChangePassword123()async{
    try{
      final user = FirebaseAuth.instance.currentUser;
      final email = user!.email;


      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString(),
        password: currentPasswordController.text,
      );
      await user.updatePassword(newPasswordController.text.trim());

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAccount(),));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.black38,
            padding: EdgeInsets.symmetric(vertical: 18),
            content: Text("  your password has been changed successfully ",style: TextStyle(fontSize: 20),)),);


    }on FirebaseAuthException catch(e){
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.black38,
              padding: EdgeInsets.symmetric(vertical: 18),
              content: Text(e.message ??"",style: TextStyle(fontSize: 15),)),);
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
        backgroundColor: appColor(),



      ),

      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40.0),
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
                      labelText:'Current Password',
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              showpassword1 = !showpassword1;
                            });
                          },
                          icon: showpassword1? Icon(
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
                  controller: currentPasswordController,
                  obscureText: showpassword1,

                  validator: (value)
                  {
                    if (value!.isEmpty){
                      return 'Password required';
                    }else if (value.length < 6 ){
                      return "password should be at least 6 characters";

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
                    }else if (value.length < 6 ){
                      return "password should be at least 6 characters";

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
                    }else if (value.length < 6 ){
                      return "password should be at least 6 characters";

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
                  },
                  child:Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,

                    ),

                  ),
                  color: Color(0xff515281),
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
}
