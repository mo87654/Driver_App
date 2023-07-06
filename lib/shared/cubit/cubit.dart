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
  int? widgetIndex;

  Future createDB()async{
    await openDatabase(
        'local_database.db',
        version: 1,
        onCreate: (database,version)async{
          await database.execute('CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, busNum TEXT, phone TEXT, grad TEXT, mac TEXT)');
          await database.execute('CREATE TABLE variables (widgetIndex INTEGER)').then((value){
            database.transaction((txn)async {
              await txn.rawInsert(
                  'INSERT INTO variables(widgetIndex)VALUES(0)');
            });
          });
        },
        onOpen: (database){
          getDataBase(database);
        }
    ).then((value){
      database = value;
      emit(CreateDataBaseState());
    });
  }

  Future? insertDataBase({
    required String name,
    required String busNum,
    required String phone,
    required String grad,
    required String mac,
  }){
    database?.transaction((txn)async {
      await txn.rawInsert('INSERT INTO students(name, busNum, phone, grad, mac)VALUES("$name", "$busNum", "$phone", "$grad", "$mac")')
          .then((value) {
            emit(InsertDataBaseState());
            getDataBase(database!);
      });

    });
    return null;
  }

   getDataBase(Database database)async{
     await database.rawQuery("SELECT * FROM students").then((value){
      studentsData = value;
    });
     await database.rawQuery("SELECT * FROM variables").then((value) {
       widgetIndex = value[0]['widgetIndex'] as int?;
       emit(GetDataBaseState());
     });
  }

  Future updateDataBase({
    @required newIndex,
    @required currentIndex,
}) async {
    await database?.rawUpdate(
        'UPDATE variables SET widgetIndex = ? WHERE widgetIndex = ?',
        ['$newIndex', '$currentIndex']
    ).then((value) async {
      emit(UpdateDataBase());
      await database?.rawQuery("SELECT * FROM variables").then((value) {
        widgetIndex = value[0]['widgetIndex'] as int?;
        emit(GetDataBaseState());
      });
    });
    return null;
  }

  deleteDataBase()async{
    await database?.execute('DROP TABLE IF EXISTS students').then((value){
      emit(DeleteDataBaseState());
    });
    await database?.execute('CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, busNum TEXT, phone TEXT, grad TEXT, mac TEXT)').then((value){
      emit(RecreateTableState());
    });
    studentsData = [];
  }

  deleteRecord(id) async {
    await database?.rawDelete('DELETE FROM students WHERE id = ?', [id]).then((value){
      emit(DeleteRecord());
      getDataBase(database!);
    });
  }
////////////////////////////////////////////////////////////////////////////////
  Widget? selectedText;
  Color? selectedColor;
  String? selectedStatus;

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
        selectedColor= Colors.red;
        selectedStatus= 'You are currently not on a commute';
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
        selectedColor= Colors.green;
        selectedStatus='You are currently on your way to school';
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
        selectedColor = Colors.grey;
        selectedStatus = 'Wait for all students to get on the bus\nThen press "Go"';
        break;
      case 3:
        selectedText = Text(
            'End Bus Commute',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic
            )
        );
        selectedColor= Colors.orange;
        selectedStatus = 'You are currently on your way back home';
    }
  }

}