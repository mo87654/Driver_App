import 'package:flutter/material.dart';

import 'forgetpassword2.dart';

class ForgetPassword1 extends StatelessWidget {
  var formkey = GlobalKey<FormState>();

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
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(),
                    labelText:'Tele-Number',
                    prefixIcon:Icon(
                        Icons.phone_android
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.top,
                  validator: (value)
                  {
                    if (value!.isEmpty){
                      return 'Tele-Number required';
                    }
                    return null;
                  },

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
                  onPressed: (){
                    if (formkey.currentState!.validate())
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword2()
                          )
                      );
                    }


                  },
                  child:Text(
                    'Verify Tele-number',
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
