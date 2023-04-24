
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'forgetPassword3.dart';
class ForgetPassword2 extends StatefulWidget {
  ForgetPassword2({required this.phoneNumber,required this.verificationId});
  final String verificationId;
  final String phoneNumber;
  @override
  State<ForgetPassword2> createState() => _ForgetPassword2State();
}

class _ForgetPassword2State extends State<ForgetPassword2> {
  var formkey = GlobalKey<FormState>();


  bool isLogin = false;

  List<TextEditingController> codeControllers = [];

  final FirebaseAuth auth = FirebaseAuth.instance;
  String verificationFailedMessage = "";

  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      codeControllers.add(TextEditingController());
    }
  }
  Country selectedCountry = Country(
      phoneCode: "20",
      countryCode: "EG",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Egypt",
      example: "Egypt",
      displayName: "Egypt",
      displayNameNoCountryCode: "EG",
      e164Key: ""
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: const Image(
                image: AssetImage('assets/images/bus.jpg'),
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),

            Form(
              key: formkey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 6; i++)
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: codeControllers[i],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        onChanged: (value) {
                          if (i < 5 && value.isNotEmpty) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (i == 5 && value.isNotEmpty) {
                            FocusScope.of(context).unfocus();
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Didn\'t get the code?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                TextButton(
                    onPressed: ()async{
                      setState(() {
                        isLogin =true;
                      });
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: "+${selectedCountry.phoneCode}"+widget.phoneNumber,
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {

                          setState(() {
                            isLogin = false;
                          });
                          setState(() {
                            verificationFailedMessage = e.message ??"";
                          });

                        },
                        codeSent: (String verificationId, int? resendToken) {
                          setState(() {
                            isLogin = false;
                          });

                        },

                        codeAutoRetrievalTimeout: (String verificationId) {
                          setState(() {
                            verificationFailedMessage = verificationId.toString();
                          });
                        },
                      );
                    },
                    child: Text("Resend Code",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 45,
              width: double.infinity,
              padding: const EdgeInsetsDirectional.only(start: 20,end: 20),
              child: MaterialButton(
                onPressed: ()async{
                  setState(() {
                    isLogin = true;
                  });
                  if (formkey.currentState!.validate()) {
                    String verificationCode = "";
                    for (int i = 0; i < codeControllers.length; i++) {
                      verificationCode += codeControllers[i].text;
                    }
                    try{
                      PhoneAuthCredential credential = PhoneAuthProvider
                          .credential(verificationId: widget.verificationId, smsCode: verificationCode);


                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);

                    }on FirebaseAuthException catch(e){
                      setState(() {
                        verificationFailedMessage = e.code;
                      });
                    }

                    setState(() {
                      isLogin = false;
                    });

                    if(auth.currentUser != null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) =>
                              ForgetPassword3(),));
                    }
                  }
                },
                color: const Color(0xff014EB8),
                shape:RoundedRectangleBorder (
                  borderRadius: BorderRadius.circular (10.0), ),
                child:isLogin
                    ? SpinKitCircle(color: Colors.white,
                  size: 50.0,)

                    :const Text(
                  'Verify Code',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Text(verificationFailedMessage)
          ],
        ),
      ),
    );
  }
}