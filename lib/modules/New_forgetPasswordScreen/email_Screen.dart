
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class forgetPassword extends StatefulWidget {
  @override
  State<forgetPassword> createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  var formkey = GlobalKey<FormState>();
  bool isLoading = false;

  String verificationFailedMessage ="";

  TextEditingController emailController = TextEditingController();
  final emailRegex = RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(

            children: [
              SizedBox(height: 70,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: const Image(
                  image: AssetImage('assets/images/bus.jpg'),
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 70.0,
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
                      labelText:'enter your Email',


                      prefixIcon:Container(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 12, 15, 12),
                        child: Icon(Icons.mail),
                      ),
                    ),

                    keyboardType: TextInputType.emailAddress,
                    textAlignVertical: TextAlignVertical.top,
                    controller: emailController,
                    validator: (value)
                    {
                      if (value!.isEmpty){
                        setState(() {
                          isLoading = false;
                        });
                        return 'Please enter your Email';

                      }else if (value.length < 5){
                        setState(() {
                          isLoading = false;
                        });
                        return 'Please enter a valid your Email';
                      }else if (!emailRegex.hasMatch(value)) {
                        isLoading =false;
                        return 'Please enter a valid email address ';
                      }
                      return null;

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
                    try{
                      if (formkey.currentState!.validate()) {
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);

                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(),));
                        ScaffoldMessenger.of(context).
                        showSnackBar(SnackBar(backgroundColor: Colors.black38 ,
                          padding: EdgeInsets.symmetric(vertical: 18,horizontal: 4),
                          content: Text("  please check your gmail to reset your password",style: TextStyle(fontSize: 18,),),),);
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                    on FirebaseAuthException catch(e){
                      if(e.code == 'invalid-email'){

                        setState(() {
                          isLoading = false;
                        });

                        ScaffoldMessenger.of(context).
                        showSnackBar(SnackBar(content: Text("please enter a valid email"),),);

                      }else if(e.code == 'user-not-found'){
                        setState(() {
                          isLoading = false;
                        });
                        ScaffoldMessenger.of(context).
                        showSnackBar(SnackBar(content: Text("no user corresponding to this email address"),),);
                      }else  {
                        setState(() {
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.message ?? "" )),
                          );
                        });
                      }

                    }

                  },
                  color: const Color(0xff014EB8),
                  shape:RoundedRectangleBorder (
                    borderRadius: BorderRadius.circular (10.0), ),
                  child:isLoading
                      ? const SpinKitCircle(
                    color: Colors.white,
                    size: 50.0,
                  )
                      :  const Text(
                    'Reset Email',
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



