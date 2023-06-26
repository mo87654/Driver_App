import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import '../../../shared/component/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PersonalInfo extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;







  @override
  void initState() {
    getUserData();


  }
  String getCurrentUserId(){
    final user = FirebaseAuth.instance.currentUser;
    return user!.uid;

  }


  void getUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    final userData = await FirebaseFirestore.instance
        .collection('Drivers')
        .doc()
        .get();
    _usernameController.text = userData['name'];
    _phoneNumberController.text = userData['tele-num'];




  }

  void saveUserData() async {


    await FirebaseFirestore.instance.collection('Drivers').doc(user!.uid).update({
      'name': _usernameController.text,
      'tele-num': _phoneNumberController.text,
    });
  }





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
        // backgroundColor: color(),
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
                  controller: _usernameController,
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
                  controller: _phoneNumberController,
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(backgroundColor: Colors.black38,
                          padding: EdgeInsets.symmetric(vertical: 18),
                          content: Text("  your profile details has been changed  ",style: TextStyle(fontSize: 20),)),);

                    FirebaseFirestore.instance.collection("Drivers");
                    if (formkey.currentState!.validate())
                    {
                      saveUserData();
                    }
                  },
                  child:Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,

                    ),

                  ),
                  color: Color(0xff515281),
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


