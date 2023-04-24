
import 'package:driver_app/layout/driver_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../New_forgetPasswordScreen/email_Screen.dart';


class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  var formkey = GlobalKey<FormState>();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool showpassword = true;
  bool isLoading = false;
  final emailRegex = RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');
  //String? selectedItem;
  @override
  String? selectedItem = 'User';

  signin() async {
    if (formkey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,);
        setState(() {
          isLoading = true;
        });

        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          print("not valid email");
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.black38,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  content: Text(e.message ??"",style: TextStyle(fontSize: 15),)),);
          });

        }
        else if (e.code == 'wrong-password') {
          print("not valid email");
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.black38,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  content: Text(e.message ??"",style: TextStyle(fontSize: 15),)),);
          });
        }
      }catch (e) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.black38,
                padding: EdgeInsets.symmetric(vertical: 18),
                content: Text(e.toString(),style: TextStyle(fontSize: 15),)),);
        });
      }
    } else{return null;}
  }
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: 70,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Image(
                    image: AssetImage('assets/images/bus.jpg'),
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 20,
                      end: 20
                  ),
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                      prefixIcon: Icon(
                          Icons.mail
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textAlignVertical: TextAlignVertical.top,
                    textInputAction: TextInputAction.next,
                    controller: emailcontroller,
                    onSaved: (value) {
                      emailcontroller.text = value!;
                    },

                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          isLoading = false;
                        });
                        return 'E-mail address required';
                      }
                      else if (value.length < 5) {
                        setState(() {
                          isLoading = false;
                        });
                        return "please, write a valid Email ";
                      }else if (!emailRegex.hasMatch(value)) {
                        isLoading =false;
                        return 'Please enter a valid email address ';
                      }

                    },
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
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
                          //contentPadding: EdgeInsetsDirectional.only(top: 10,start: 10,end: 10, bottom: 10 ),
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showpassword = !showpassword;
                                });
                              },
                              icon: showpassword
                                  ? Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )
                                  : Icon(
                                Icons.visibility,
                              )
                          )
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordcontroller,
                      obscureText: showpassword,
                      textAlignVertical: TextAlignVertical.top,
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            isLoading = false;
                          });
                          return 'Password required';

                        }
                        else if (value.length < 6) {
                          setState(() {
                            isLoading = false;
                          });
                          return "password can't be less than 6 ";
                        }
                        return null;
                      }
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: EdgeInsetsDirectional.only(end: 20),
                  height: 35,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => forgetPassword()
                          )
                      );
                    },
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                  child: MaterialButton(

                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      var user =  await signin();
                      if (user != null) {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => DriverLayout(),));

                      }



                    },
                    child:isLoading
                        ? SpinKitCircle(
                      color: Colors.white,
                      size: 50.0,
                    )
                        :  Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    color: Color(0xff014EB8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),),


                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//hello