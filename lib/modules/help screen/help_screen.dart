import 'package:flutter/material.dart';
import '../../../shared/components/colors.dart';
import '../my account screen/My_account.dart';
class HelpPage extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(


      appBar:AppBar(
        leading:  IconButton(icon:  Icon(Icons.arrow_back),
          onPressed: () {
          Navigator.pop(context);
          },
        ),
        title: Text ('Help!'),
        backgroundColor: color(),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(height: 40.0),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                //width: 300.0,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value)
                  {
                    if (value!.isEmpty){
                      return 'E-mail required';
                    }
                    return null;
                  },
                  decoration:  InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13)
                      ),
                      prefixIcon: Icon(
                          Icons.email
                      )
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                decoration: BoxDecoration(
                  //shape: (BoxShape.circle),
                  //border: ()
                ),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                //width: 300.0,
                //padding: EdgeInsets.all(50),
                //padding: EdgeInsets.all(50.0),
                height: 300,

                child: TextFormField(
                  maxLines: 7,
                  validator: (value)
                  {
                    if (value!.isEmpty){
                      return 'Problem description required';
                    }
                    return null;
                  },
                  // style: TextStyle(height: 5.0 ),
                  decoration:  InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    hintText: 'Problem description......',
                    //alignLabelWithHint: true,
                    //hintStyle: TextStyle(fontSize:5,),
                    //hintStyle: Alignment.topLeft,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 220.0),
              Container(
                height: 45,
                width: double.infinity,
                padding: const EdgeInsetsDirectional.only(start: 20,end: 20),
                child: MaterialButton(
                  onPressed: (){
                    if (formkey.currentState!.validate())
                    {

                    }
                  },
                  child:Text(
                    'Save',
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
              SizedBox(
                height: 25,
              ),
              Container(
                height: 45,
                width: double.infinity,
                padding: const EdgeInsetsDirectional.only(start: 20,end: 20),
                child: MaterialButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child:Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,

                    ),

                  ),
                  color: Color(0xff818181),
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

