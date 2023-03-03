import 'package:flutter/material.dart';

import 'forgetPassword4.dart';

class ForgetPassword3 extends StatefulWidget {
  @override
  State<ForgetPassword3> createState() => _ForgetPassword3State();
}

class _ForgetPassword3State extends State<ForgetPassword3> {
var formkey = GlobalKey<FormState>();
bool showpassword1 = true;
bool showpassword2 = true;

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
                height: 40,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20,
                  end: 20,
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
                      labelText:'New Password',
                      prefixIcon: Icon(
                        Icons.lock_reset,
                      ),
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
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  textAlignVertical: TextAlignVertical.top,
                  validator: (value)
                  {
                    if (value!.isEmpty){
                      return 'Password required';
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
                  obscureText: true,
                  textAlignVertical: TextAlignVertical.top,
                  validator: (value)
                  {
                    if (value!.isEmpty){
                      return 'Password required';
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
                  onPressed: (){
                    if (formkey.currentState!.validate())
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>ForgetPassword4()
                          )
                      );
                    }
                  },
                  child:Text(
                    'Reset Password',
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
            ],
          ),
        ),
      ),
    );
  }
}
