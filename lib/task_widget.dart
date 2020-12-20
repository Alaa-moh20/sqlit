import 'package:flutter/material.dart';
import 'package:tababar/constants.dart';
import 'package:tababar/task_model.dart';

import 'db_helper.dart';

class TaskWidget extends StatefulWidget {
  Task2 task;

  Function function;
  TaskWidget(this.task, [this.function]);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // set up the buttons
                  Widget okButton = FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      taskList.remove(Task2(
                          taskName: widget.task.taskName,
                          isComplete: this.widget.task.isComplete));
                      DBHelper.dbHelper.deleteTask(Task2(
                          taskName: widget.task.taskName,
                          isComplete: this.widget.task.isComplete));
                      Navigator.of(context).pop();
                      setState(() {});
                      widget.function();
                    },
                  );
                  Widget noButton = FlatButton(
                    child: Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop(); // dismiss dialog
                    },
                  );
                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title: Text("Alert"),
                    content: Text("You will delete a task,are you sure?"),
                    actions: [
                      okButton,
                      noButton,
                    ],
                  );
                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }),
            Text(widget.task.taskName),
            Checkbox(
                value: widget.task.isComplete,
                onChanged: (value) {
                  DBHelper.dbHelper.updateTask(
                      Task2(taskName: widget.task.taskName, isComplete: value));
                  this.widget.task.isComplete = this.widget.task.isComplete;
                  setState(() {});
                  widget.function();
                })
          ],
        ),
      ),
    );
  }
}
