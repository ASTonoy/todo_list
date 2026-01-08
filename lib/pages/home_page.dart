import 'package:flutter/material.dart';
import 'package:todo_list/util/dialouge_box.dart';
import 'package:todo_list/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // text controller
  final _controller = TextEditingController();
  // todo list
  List toDoList = [
    ['Make Tutorial', false],
    ['Listening Test', false],
    ['Writing Test', false],
    ['Speaking', false],
  ];

  // check box was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];

      });
  }
  // save new task
  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
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
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
          );
            },
      ),
    );
  }
}