
import 'package:sqflite/sqflite.dart';

List<Map> names = [];
Database? database;

Future createDB()async{
  database = await openDatabase(
      'local_database.db',
      version: 1,
      onCreate: (database,version)async{
        await database.execute('CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, grad TEXT)');
      },
      onOpen: (database){
        getdatabase(database).then((value) {
          names = value;
        });
      }
  );
}

Future? insertdatabase({
  required String name,
  required String email,
  required String phone,
  required String grad,
}){
  database?.transaction((txn)async {
    await txn.rawInsert('INSERT INTO students(name, email, phone, grad)VALUES("$name", "$email", "$phone", "$grad")')
    .then((value) {
      getdatabase(database!).then((value) {
        names= value;
      });
    });

  });
}

Future getdatabase(Database database)async{
  return await database.rawQuery("SELECT * FROM students");
}

Future deletedatabase()async{
  await database?.execute('DROP TABLE IF EXISTS students');
  await database?.execute('CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, grad TEXT)');
  names = [];
}
