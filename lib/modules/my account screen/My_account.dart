import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool status = false;
  PickedFile? _imageFile;
  String? image64;

  final user =  FirebaseAuth.instance.currentUser!;


  Future<Object> getuserinfo() async {
    final CollectionReference users = FirebaseFirestore.instance.collection('Drivers');
    final String uid = user.uid;
    final result = await  users.doc(uid).get();
    return result.data()??['name'];

  }

  final ImagePicker picker = ImagePicker();
  Color purple = const Color.fromRGBO(38, 107, 128, 0.9490196078431372);
  Color lpurplet = const Color.fromRGBO(0, 102, 128, 0.9490196078431372);
  Color white = const Color.fromRGBO(254, 254, 254, 1.0);
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
               height: 260 ,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.bottomCenter,

                  children:<Widget> [
                    Align(

                      alignment: AlignmentDirectional.topStart,
                      child: Container(child: Image.asset('assets/images/background2.png',
                        fit: BoxFit.cover ,),
                        width: double.infinity,
                        height: 200,
                      ),
                    ),

                    Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                     clipBehavior: Clip.none,
                      children:<Widget>[
                    CircleAvatar(
                        radius: 64,
                        backgroundImage: _imageFile == null ?
                         AssetImage("assets/images/User3.jpg")
                            : FileImage(File(_imageFile!.path)) as ImageProvider),

                    CircleAvatar(
                      backgroundColor:  const Color(0xff515281),
                      radius: 16,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (context) => bottomSheet(),
                            );
                          });
                        },
                        child: Icon(Icons.edit, color: white),
                      ),
                    ),
          ]

          ),
                  ],
                ),
              ),
            ],

          ),





          Padding(
            padding: const EdgeInsets.only(top: 25, left: 15),
            child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: FutureBuilder(
                      future: getuserinfo(),
                      builder: (_, AsyncSnapshot snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        nameController.text = snapshot.data['name'].toString();
                        return TextFormField(

                          controller: nameController,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'your name',
                          ),
                          readOnly: true,
                          style: TextStyle
                            (
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),

                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child:FutureBuilder(
                      future: getuserinfo(),
                      builder: (_, AsyncSnapshot snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        // تعيين النص المستلم من قاعدة البيانات في حقل Textformfield
                        emailController.text = snapshot.data['email'].toString();
                        return TextFormField(

                          controller: emailController,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'your email',
                          ),
                          readOnly: true,
                            style: TextStyle
                             (
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                                  ),

                        );
                      },
                    ),

                  ),

                ]

            ),
          ),



        ],

      );








  }

  Widget bottomSheet() {
    return Container(
      color: const Color.fromRGBO(159, 148, 171, 1.0),
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose profile photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlinedButton.icon(

                icon: const Icon(Icons.camera,
                  color: Colors.black,
                ),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: const Text("Camera",
                  style: TextStyle(
                    color: Colors.black,

                  ),
                ),
              ),
              OutlinedButton.icon(

                icon: const Icon(Icons.image,
                  color: Colors.black,
                ),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: const Text("Gallery",
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),

              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile ?? '' as PickedFile;
      print(_imageFile?.path);
    });
  }

  pickPicture() async {
    _imageFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);

    print(_imageFile);

    if(_imageFile != null) {
      final File newImage = File(_imageFile!.path);

      List<int> imageBytes = newImage.readAsBytesSync();
      image64 = base64Encode(imageBytes);
    }
  }
}

