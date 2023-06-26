
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import '../../shared/component/buttons.dart';
import '../../shared/component/colors.dart';
import '../../shared/components/buttons.dart';



class HelpPage extends StatefulWidget {
  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  var formkey = GlobalKey<FormState>();

  TextEditingController _controllerEmail = TextEditingController();

  TextEditingController _controllerProblem = TextEditingController();

  bool isLoading = false;

  Widget build(BuildContext context) {
    return Scaffold(


      appBar:AppBar(
        leading:  IconButton(icon:
        Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text ('Help!'),
       // backgroundColor: app_Color(),
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
                  controller: _controllerEmail,
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
                  controller: _controllerProblem,
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
              SizedBox(height: 220.0),
              appButton(

                isLoading: isLoading,
                text: 'Save',
                function: ()async{
                  if (formkey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    Map<String,String> dataToSave={
                      'Email':_controllerEmail.text ,
                      'ProblemDescription' :_controllerProblem.text
                    };
                    FirebaseFirestore.instance.collection('problems').add(dataToSave);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(backgroundColor: Colors.black38,
                          padding: EdgeInsets.symmetric(vertical: 18),
                          content: Text("  your problem has been sent succesfully ",style: TextStyle(fontSize: 20),)),);


                    setState(() {
                      isLoading = false;
                    });

                    //Navigator.pop(context);
                  }
                },
              ),

              SizedBox(
                height: 25,
              ),
              appButton(
                buttonColor:  Color(0xff818181),
                text: 'Cancel',
                function: (){
                  Navigator.pop(context);
                },

              ),
            ],
          ),
        ),
      ),

    );
  }
}