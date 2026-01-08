import 'package:flutter/material.dart';
import 'package:todo_list/util/my_button.dart';

class DialougeBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialougeBox({super.key, required this.controller, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.cyan,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder(), 
              hintText: 'Add a new task'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
             children: [
               // save button
              MyButton(text: 'Save', onPressed: onSave),
            //cancel button
            SizedBox(width: 60),
             MyButton(text: 'Cancel', onPressed: onCancel),
             ],
            ),
          ],
        ),
      ),
    );
  }
}