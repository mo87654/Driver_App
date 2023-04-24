import 'package:flutter/material.dart';

import 'forgetPassword3.dart';
class ForgetPassword2 extends StatelessWidget {
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              height: 30.0,
            ),
            Form(
              key: formkey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.only(start: 0),
                    width: 40,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        counterText: ""  ,          //hide the counter

                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      validator: (value)
                      {
                        if (value!.isEmpty){
                          return ' ';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(start: 13),
                    width: 53,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        counterText: ""  ,          //hide the counter
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      validator: (value)
                      {
                        if (value!.isEmpty){
                          return ' ';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(start: 13),
                    width: 53,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        counterText: ""  ,          //hide the counter
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      validator: (value)
                      {
                        if (value!.isEmpty){
                          return ' ';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(start: 13),
                    width: 53,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        counterText: ""  ,          //hide the counter
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      validator: (value)
                      {
                        if (value!.isEmpty){
                          return ' ';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(start: 13),
                    width: 53,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        counterText: ""  ,          //hide the counter
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      validator: (value)
                      {
                        if (value!.isEmpty){
                          return ' ';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(start: 13),
                    width: 53,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        counterText: ""  ,          //hide the counter
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.done,
                      validator: (value)
                      {
                        if (value!.isEmpty){
                          return ' ';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Didn\'t get the code?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                TextButton(
                    onPressed: (){},
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
              ],
            ),
            SizedBox(
              height: 30,
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
                            builder: (context)=>ForgetPassword3()
                        )
                    );
                  }

                },
                child:Text(
                  'Verify Code',
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
    );
  }
}
