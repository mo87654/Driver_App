
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'forgetpassword2.dart';


class ForgetPassword1 extends StatefulWidget {
  @override
  State<ForgetPassword1> createState() => _ForgetPassword1State();
}

class _ForgetPassword1State extends State<ForgetPassword1> {
  var formkey = GlobalKey<FormState>();
  bool isLoading = false;

  String verificationFailedMessage ="";

  TextEditingController phoneNumController = TextEditingController();

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
        child: Form(
          key: formkey,
          child: Column(
            children: [
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
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20,
                  end: 20,
                ),
                child: TextFormField(
                    style:  TextStyle(
                      fontSize: 20,
                    ),

                    decoration:  InputDecoration(
                      floatingLabelStyle: TextStyle(
                        fontSize: 18,
                      ),
                      border: const OutlineInputBorder(),
                      labelText:'Tele-Number',


                      prefixIcon:Container(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 12, 15, 12),
                        child: InkWell(
                          onTap: (){
                            showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(bottomSheetHeight: 500),
                              onSelect: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              },);
                          },
                          child: Text("${selectedCountry.flagEmoji}+${selectedCountry.phoneCode}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),

                    keyboardType: TextInputType.phone,
                    textAlignVertical: TextAlignVertical.top,
                    controller: phoneNumController,
                    validator: (value)
                    {
                      if (value!.isEmpty){
                        setState(() {
                          isLoading = false;
                        });
                        return 'Please enter your phone number';
                      }return null;

                    }

                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Container(
                height: 45,
                width: double.infinity,
                padding: const EdgeInsetsDirectional.only(start: 20,end: 20),
                child: MaterialButton(
                  onPressed: ()async{
                    setState(() {
                      isLoading = true;
                    });

                    if (formkey.currentState!.validate()) {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: "+${selectedCountry.phoneCode}"+phoneNumController.text,
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {

                          setState(() {
                            isLoading = false;
                          });
                          setState(() {
                            verificationFailedMessage = e.message ??"";
                          });

                        },
                        codeSent: (String verificationId, int? resendToken) {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => ForgetPassword2(phoneNumber: phoneNumController.text, verificationId: verificationId),));
                        },
                        // Navigator.of(context)
                        //     .pushReplacement(PageRouteBuilder(
                        // pageBuilder: (_,__,___) =>ForgetPassword2(phoneNumber:phoneNumController.text ,verificationId: verificationId)));
                        // },

                        codeAutoRetrievalTimeout: (String verificationId) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgetPassword2(phoneNumber: phoneNumController.text, verificationId: verificationId),));

                        },
                      );
                    }
                  },
                  color: const Color(0xff014EB8),
                  shape:RoundedRectangleBorder (
                    borderRadius: BorderRadius.circular (10.0), ),
                  child:isLoading
                      ? SpinKitCircle(
                    color: Colors.white,
                    size: 50.0,
                  )
                      :  Text(
                    'Verify Tele-number',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),

                ),

              ),
              const SizedBox(
                height: 60.0,
              ),

              Text(verificationFailedMessage)

            ],
          ),
        ),
      ),
    );
  }
}