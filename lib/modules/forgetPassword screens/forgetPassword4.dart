import 'package:flutter/material.dart';

import '../login screen/login.dart';

class ForgetPassword4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
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
          Container(
            color: Colors.black.withOpacity(.7),
          ),
          Center(
            child: Container(
              width: width * .85,
              height: height * .66,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)
              ),
              //clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(

                children: [
                  SizedBox(
                    height: width * .85 * .21,
                  ),
                  Icon(
                    Icons.check_circle_rounded,
                    size: 70,
                    color: Color(0xff014EB8),
                  ),
                  SizedBox(
                    height: height * .85 * .1,
                  ),
                  Text(
                    'Password has been changed successfully',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'You have just reset your password ,click on the button below to log in',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,

                  ),
                  SizedBox(
                    height: height * .85 * .13,
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.only(start: 20,end: 20),
                    /*decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(44),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,*/
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Login(),), (route) => false);
                      },
                      child:Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,

                        ),

                      ),
                      color: Color(0xff014EB8),
                      shape:RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular (10.0), ),


                    ),
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}