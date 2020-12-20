import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tababar/constants.dart';
import 'package:tababar/db_helper.dart';
import 'package:tababar/task_model.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  bool isComplete = false;
  String taskName;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onChanged: (value) {
                this.taskName = value;
              },
            ),
            Checkbox(
                value: isComplete,
                onChanged: (value) {
                  this.isComplete = value;
                  setState(() {});
                }),
            RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Add New Task',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  taskList.add(Task2(
                      taskName: this.taskName, isComplete: this.isComplete));
                  DBHelper.dbHelper.insertNewTask(Task2(
                      taskName: this.taskName, isComplete: this.isComplete));
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
