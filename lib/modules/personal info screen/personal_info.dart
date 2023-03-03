import 'package:flutter/material.dart';

import '../../../shared/components/colors.dart';

class PersonalInfo extends StatelessWidget {
  var formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(
        leading:  IconButton(icon:  Icon(Icons.arrow_back),
          onPressed: () {
          Navigator.pop(context);
          },
        ),
        title: Text (
            'Personal Info'
        ),
        backgroundColor: color(),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(height: 80.0),
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
                    border: OutlineInputBorder(),
                    labelText:'User name',
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textAlignVertical: TextAlignVertical.top,
                  textInputAction: TextInputAction.next,
                  validator: (value)
                  {
                    if (value!.isEmpty){
                      return 'User name required';
                    }
                    return null;
                  },

                ),
              ),
              SizedBox(height: 30.0),
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
                    border: OutlineInputBorder(),
                    labelText:'Tele_number',
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textAlignVertical: TextAlignVertical.top,
                  textInputAction: TextInputAction.done,
                  validator: (value)
                  {
                    if (value!.isEmpty){
                      return 'Tele_number required';
                    }
                    return null;
                  },

                ),
              ),
              SizedBox(height: 140.0),
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


