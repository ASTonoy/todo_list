import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
List toDoList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  // run first time ever

void createInitialData() {
    toDoList = [
      ['Make Tutorial', false],
      ['Listening Test', false],
    ];
  }

  // load data from database
  void loadData() {

    toDoList = _myBox.get('TODOLIST');
  }

  // update database
  void updateDataBase() {
     _myBox.put('TODOLIST', toDoList);
  }

}