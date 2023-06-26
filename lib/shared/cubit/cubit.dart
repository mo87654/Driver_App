import 'package:bloc/bloc.dart';
import 'package:driver_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialState());
  static AppCubit get(context)=>BlocProvider.of(context);

  List<Map> studentsData = [];
  Database? database;
  var widgetIndex = 0;
  Widget? selectedText;

  Future createDB()async{
    await openDatabase(
        'local_database.db',
        version: 1,
        onCreate: (database,version)async{
          await database.execute('CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, grad TEXT, mac TEXT)');
        },
        onOpen: (database){
          getdatabase(database).then((value) {
            studentsData = value;
            emit(GetDataBaseState());
          });
        }
    ).then((value){
      database = value;
      emit(CreateDataBaseState());
    });
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
            emit(InsertDataBaseState());
            getdatabase(database!).then((value) {
              studentsData= value;
              emit(GetDataBaseState());
            });
      });

    });
  }

  Future getdatabase(Database database)async{
    return await database.rawQuery("SELECT * FROM students");
  }

  Future deletedatabase()async{
    await database?.execute('DROP TABLE IF EXISTS students').then((value){
      emit(DeleteDataBaseState());
    });
    await database?.execute('CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, grad TEXT, mac TEXT)').then((value){
      emit(RecreateTableState());
    });
    studentsData = [];
  }

  homeButton(){
    switch (widgetIndex) {
      case 0:
        selectedText = Text(
          'Start Bus Commute',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic
            )
        );
        break;
      case 1:
        selectedText = Text(
            'End Bus Commute',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic
            )
        );
        break;
      case 2:
        selectedText = Text(
            'Go',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic
            )
        );
    }
  }

   updateHomeBUttonValue(value){
    widgetIndex=value;
    emit(HomeButtonTextState());
  }
}