import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../screens/archived_page/archive_page.dart';
import '../../screens/done_page/done_page.dart';
import '../../screens/new_taskes_page/new_taskes.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  int selected = 0;
  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  bool show = false;
  IconData? icona;

  List<Widget> screens = [
    const NewTaskes(),
    const DoneTaskes(),
    const ArchiveTaskes()
  ];
  List<String> titles = [
    "MofkRty (New Tasks)",
    "MofkRty (Done Tasks)",
    "MofkRty (Archive Tasks)"
  ];

  // ignore: non_constant_identifier_names
  void ChangeBottomSheet({required bool isShow, required IconData isIcona}) {
    show = isShow;
    icona = isIcona;
    emit(AppChangedBottomSheetState());
  }

  void changeIndex(int index) {
    selected = index;
    emit(AppChangedBottomNabBarState());
  }

  void createDatabase() {
    openDatabase("todo.db", version: 1, onCreate: (database, version) {
      database
          .execute(
              "CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT , date TEXT ,time TEXT, status TEXT)")
          .then((value) {
        // print("database is created");
      }).catchError((error) {
        // print("Error When Creating tabel ${error.toString()}");
      });
    },
        //   onUpgrade: (database,oldVersion,newVersion) async {
        //     print("database is upgraded");
        // database.execute(
        //     "CREATE TABLE test (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT , date TEXT ,time TEXT, status TEXT)");
        //   },
        onOpen: (database) {
      getDataFromDatabase(database);
      // print("database is opened");
    }).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  insertToDatabase(
      {required String title,
      required String time,
      required String date}) async {
    await database!.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks (title , date , time , status) VALUES ("$title" ,"$date" , "$time" , "new" )')
          .then((value) {
        // print("$value insert succssfully");
        emit(AppInsertDatabase());
        getDataFromDatabase(database!);
      }).catchError((error) {
        // print("Error When inserting new Record ${error.toString()}");
      });
    });
  }

  void getDataFromDatabase(Database database) {
    newTasks.clear();
    archiveTasks.clear();
    doneTasks.clear();

    database.query('tasks').then((value) {
      for (var element in value) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
      }
      emit(AppGetDatabase());
    });
    // print(data);
  }

  void updateDatabase({required String status, required int id}) async {
    await database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      getDataFromDatabase(database!);
      emit(AppUpdateDatabase());
    });

// print('updated: $count');
  }

  void deleteFromDatabase({required int id}) async {
    await database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]);
    emit(DeleteFromDatabase());
    getDataFromDatabase(database!);
  }
}
