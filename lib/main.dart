import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tababar/constants.dart';
import 'package:tababar/db_helper.dart';
import 'package:tababar/new_task.dart';
import 'package:tababar/task_model.dart';
import 'package:tababar/task_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.dbHelper.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBarPage(User('Ala\'a', 'Ala\'a@gmail.com')), //Todo App
    );
  }
}

class TabBarPage extends StatefulWidget {
  User user;
  TabBarPage(this.user);
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return NewTask();
              },
            ));
          }),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: Text(widget.user.name[0].toUpperCase()),
                ),
                accountName: Text(widget.user.name),
                accountEmail: Text(widget.user.email)),
            ListTile(
              onTap: () {
                tabController.animateTo(0);
                Navigator.pop(context);
              },
              title: Text('All Tasks'),
              subtitle: Text('All user\'s taska'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: () {
                tabController.animateTo(1);
                Navigator.pop(context);
              },
              title: Text('Complete Tasks'),
              subtitle: Text('All user\'s Complete taska'),
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              onTap: () {
                tabController.animateTo(2);
                Navigator.pop(context);
              },
              title: Text('InComplete Tasks'),
              subtitle: Text('All user\'s InComplete taska'),
              trailing: Icon(Icons.arrow_right),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Todo'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: 'All Tasks',
            ),
            Tab(
              text: 'Complete Tasks',
            ),
            Tab(
              text: 'InComplete Tasks',
            )
          ],
          isScrollable: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
                controller: tabController,
                children: [AllTasks(), CompleteTasks(), InCompleteTasks()]),
          ),
        ],
      ),
    );
  }
}

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Task2>>(
        future: DBHelper.dbHelper.selectAllTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            taskList = snapshot.data;
            return Container(
              child: SingleChildScrollView(
                child: Column(
                    children:
                        taskList.map((e) => TaskWidget(e, myFun)).toList()),
              ),
            );
          }
        },
      ),
    );
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Task2>>(
        future: DBHelper.dbHelper.selectSpeciphicTask(1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            taskList = snapshot.data;
            return Container(
              child: SingleChildScrollView(
                child: Column(
                    children:
                        taskList.map((e) => TaskWidget(e, myFun)).toList()),
              ),
            );
          }
        },
      ),
    );
  }
}

class InCompleteTasks extends StatefulWidget {
  @override
  _InCompleteTasksState createState() => _InCompleteTasksState();
}

class _InCompleteTasksState extends State<InCompleteTasks> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Task2>>(
        future: DBHelper.dbHelper.selectSpeciphicTask(0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            taskList = snapshot.data;
            return Container(
              child: SingleChildScrollView(
                child: Column(
                    children:
                        taskList.map((e) => TaskWidget(e, myFun)).toList()),
              ),
            );
          }
        },
      ),
    );
  }
}

class User {
  String name;
  String email;
  User(this.name, this.email);
}
