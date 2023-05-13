import 'package:driver_app/modules/login%20screen/login.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/components/buttons.dart';

class gmailMessage extends StatelessWidget {
  launchGmail() async {
    const url = 'googlegmail:///co?to=&subject=&body=';
    const fallbackUrl = "https://mail.google.com/";
    if (await canLaunch(url)) {
      await launch(url);
    } else{
      await launch(fallbackUrl);
    }
  }

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
                    height: width * .85 * .21,),
                   Icon(
                    Icons.check_circle_rounded,
                    size: 70,
                    color: Color(0xff4d6aaa),
                  ),
                  SizedBox(
                    height: height * .85 * .1,
                  ),
                  Text(
                    'We have sent you a message to reset your password.',
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
                    'please check your gmail',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,

                  ),
                  SizedBox(
                    height: height * .85 * .13,
                  ),
                  // appButton(
                  //
                  //   buttonColor:  Color(0xff818181),
                  //   text: 'go to Gmail',
                  //
                  //   function: (){
                  //     Navigator.pop(context);
                  //   },
                  //
                  // ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.only(start: 20,end: 20),

                    child: MaterialButton(
                      onPressed: (){
                        launchGmail();
                      },
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'go to Gmail',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.mail,color: Colors.orange,)
                        ],
                      ),
                      color: Color(0xff4d6aaa),
                      shape:RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular (10.0), ),
                    ),

                  ),
                   SizedBox(
                    height: 40,
                  ),
                  TextButton(onPressed:(){
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => Login(),), (route) => false);
                  } ,
                      child: Text("cancel",style: TextStyle(color: Colors.grey,fontSize: 17),)),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}