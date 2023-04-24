
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

List<Map> studentsData = [];
Database? database;

Future createDB()async{
  database = await openDatabase(
      'local_database.db',
      version: 1,
      onCreate: (database,version)async{
        await database.execute('CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, grad TEXT, mac TEXT)');
      },
      onOpen: (database){
        getdatabase(database).then((value) {
          studentsData = value;
        });
      }
  );
}

Future? insertdatabase({
  required String name,
  required String email,
  required String phone,
  required String grad,
  required String mac,
}){
  database?.transaction((txn)async {
    await txn.rawInsert('INSERT INTO students(name, email, phone, grad, mac)VALUES("$name", "$email", "$phone", "$grad", "$mac")')
    .then((value) {
      getdatabase(database!).then((value) {
        studentsData= value;
      });
    });

  });
}

Future getdatabase(Database database)async{
  return await database.rawQuery("SELECT * FROM students");
}

Future deletedatabase()async{
  await database?.execute('DROP TABLE IF EXISTS students');
  await database?.execute('CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, grad TEXT, mac TEXT)');
  studentsData = [];
}
//==========json file function============
List<dynamic> macFromESP=[];
var json;
Future getJson ()async{
  var url=Uri.parse("https://script.googleusercontent.com/macros/echo?user_content_key=-txHhINBYG_HjSvyno1jrTZeb1ilWM4YBuGLlB17c6QnK4wLQAwAYc9pHY5EeHisDy7g8psalO0zZUUhVh7hC-OtQxlk86Jem5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnHqnKnpp1zTdfFN17X2Kveefnko7KPRe5NqUQQgRuFkDHB_7otA1G7S3cJotgUotvvcCCXpHvgrsZrYxGGIXmoCq0UjEOUCR1Nz9Jw9Md8uu&lib=MuaA7e0PjPiH0jPT4P62uuWSLqXWK-X04");
  json = await http.read(url).then((value){
    macFromESP = jsonDecode(value);
  });
}
