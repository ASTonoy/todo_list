import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/data/database.dart';
import 'package:todo_list/util/dialouge_box.dart';
import 'package:todo_list/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  @override
  void initState() {
     // if this is the first time create default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();
  

  // check box was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];

      });
      db.updateDataBase();
  }
  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }
  //create new task
  void createNewTask() {
   showDialog(
    context: context, 
    builder: (context) {
     return DialougeBox(controller: _controller,
     onSave: saveNewTask,
     onCancel: () => Navigator.of(context).pop());
   },
   );
  }
   //delete task
   void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
            },
      ),
    );
  }
}