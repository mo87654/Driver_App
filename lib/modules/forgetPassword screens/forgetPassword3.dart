
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'forgetPassword4.dart';


class ForgetPassword3 extends StatefulWidget {
  ForgetPassword3();
  // final String verificationId;
  // final String phoneNumber;
  // final String smsCode;


  @override
  State<ForgetPassword3> createState() => _ForgetPassword3State();
}


class _ForgetPassword3State extends State<ForgetPassword3> {
  var formkey = GlobalKey<FormState>();
  bool showpassword1 = true;
  bool showpassword2 = true;

  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool isLoading = false;

  User? user = FirebaseAuth.instance.currentUser;


  // Future changePassword() async {
  //    try{
  //      FirebaseAuth auth = FirebaseAuth.instance;
  //      await auth.signInWithPhoneNumber();
  //      final AuthCredential credential = PhoneAuthProvider.credential(
  //        verificationId: widget.,
  //        smsCode: widget., // User entered SMS code
  //      );
  //      await auth.currentUser!.updatePassword(newPasswordController.text);
  //      setState(() {
  //        isLoading = true;
  //      });
  //
  //    }on FirebaseAuthException catch (e){
  //      if (e.code == 'wrong-password') {
  //        setState(() {
  //          isLoading = false;
  //        });
  //        return(e.message ??"") ;
  //    }
  //
  //  }catch (e) {
  //      setState(() {
  //        isLoading = false;
  //      });
  //      return(e.toString());
  //    }
  //  return null;
  //  }
  changePassword({newPassword, confirmNewPassword}) async {
    try {
      // if(user != null){
      // AuthCredential credential = EmailAuthProvider.credential(email: user.email, password:confirmNewPassword );

      // await user!.reauthenticateWithCredential(credential).then((value) {
      user!.updatePassword(newPassword);
      // }).catchError((e){

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    // }
    on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ??"")));
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ??"")));
      }

    } catch (e) {
      return(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: const Image(
                  image: AssetImage('assets/images/bus.jpg'),
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              // Padding(
              //   padding: const EdgeInsetsDirectional.only(
              //     start: 20,
              //     end: 20,
              //   ),
              //   child: TextFormField(
              //     style: const TextStyle(
              //       fontSize: 20,
              //     ),
              //     decoration: InputDecoration(
              //       floatingLabelStyle: TextStyle(
              //         fontSize: 18,
              //       ),
              //       border: OutlineInputBorder(),
              //       labelText: 'E-mail',
              //       prefixIcon: Icon(
              //           Icons.mail
              //       ),
              //     ),
              //     keyboardType: TextInputType.emailAddress,
              //     textAlignVertical: TextAlignVertical.top,
              //     textInputAction: TextInputAction.next,
              //     controller: emailController,
              //     onSaved: (value) {
              //       emailController.text = value!;
              //     },
              //
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         setState(() {
              //           isLoading = false;
              //         });
              //         return 'E-mail address required';
              //       }
              //       else if (value.length < 5) {
              //         setState(() {
              //           isLoading = false;
              //         });
              //         return "please, write a valid Email ";
              //       }
              //       // final emailRegex = RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');
              //       // if (!emailRegex.hasMatch(value)) {
              //       //   isLoading =false;
              //       //   return 'Please enter a valid email address ';
              //       //}
              //
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: 25,
              // ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20,
                  end: 20,
                ),
                child: TextFormField(
                  controller: newPasswordController,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      floatingLabelStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      //contentPadding: EdgeInsetsDirectional.only(top: 10,start: 10,end: 10, bottom: 10 ),
                      border: OutlineInputBorder(),
                      labelText:'New Password',
                      prefixIcon: const Icon(
                        Icons.lock_reset,
                      ),
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              showpassword1 = !showpassword1;
                            });
                          },
                          icon: showpassword1
                              ? const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,)
                              : Icon(
                              Icons.visibility)

                      )

                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: showpassword1,
                  textInputAction: TextInputAction.next,
                  textAlignVertical: TextAlignVertical.top,
                  validator: (value)
                  {
                    if (value!.isEmpty){
                      setState(() {
                        isLoading = false;
                      });
                      return 'Password required';
                    }
                    if (value.length < 6) {
                      setState(() {
                        isLoading = false;
                      });

                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 20,
                    end: 20
                ),
                child: TextFormField(
                  controller: confirmPasswordController,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(
                        fontSize: 18,
                      ),
                      //contentPadding: EdgeInsetsDirectional.only(top: 10,start: 10,end: 10, bottom: 10 ),
                      border: OutlineInputBorder(),
                      labelText:'Confirm New Password',
                      prefixIcon: Icon(
                        Icons.lock_reset,
                      ),
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              showpassword2 = !showpassword2;
                            });
                          },
                          icon: showpassword2
                              ? Icon(
                            Icons.visibility_off,
                            color: Colors.grey,)
                              :Icon(
                              Icons.visibility)

                      )
                  ),
                  onSaved:  (newValue) => confirmPasswordController.text,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: showpassword2,
                  textAlignVertical: TextAlignVertical.top,
                  validator: (value)
                  {
                    if (value!.isEmpty){
                      setState(() {
                        isLoading = false;
                      });

                      return 'Password required';

                    }if (newPasswordController.text != confirmPasswordController.text) {
                      setState(() {
                        isLoading = false;
                      });
                      return  "please enter the correct password";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                height: 45,
                width: double.infinity,
                padding: const EdgeInsetsDirectional.only(start: 20,end: 20),
                child: MaterialButton(
                  onPressed: () async{
                    if (formkey.currentState!.validate()) {
                      var auth = await changePassword();

                      if (auth != null) {
                        print("changed");
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) => ForgetPassword4(),));
                      }
                    }
                  },
                  child: isLoading
                      ? SpinKitCircle(
                    color: Colors.white,
                    size: 50.0,
                  ):Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  color: Color(0xff014EB8),
                  shape:RoundedRectangleBorder (
                    borderRadius: BorderRadius.circular (10.0),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}