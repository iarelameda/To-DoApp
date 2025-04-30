import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My To-Do App',
      home: ToDoHomePage(),
    );
  }
}

class ToDoHomePage extends StatefulWidget {
  @override
  _ToDoHomePageState createState() => _ToDoHomePageState();
}

class TaskItem {
  String text;
  String timeAdded;

  TaskItem({required this.text, required this.timeAdded});
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  List<TaskItem> tasks = [];
  TextEditingController taskController = TextEditingController();

  void addTask() {
    String text = taskController.text;
    if (text.isNotEmpty) {
      String timeNow = TimeOfDay.now().format(context);
      setState(() {
        tasks.add(TaskItem(text: text, timeAdded: timeNow));
      });
      taskController.clear();
    }
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 138, 181, 201),
      appBar: AppBar(
        title: Text('To-Do List'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: 'Enter your task',
                hintStyle: TextStyle(color: Colors.blue),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 168, 201, 226),
              ),
              child: Text('Add Task'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    color: Colors.lightBlue[100],
                    child: ListTile(
                      title: Text(tasks[index].text),
                      subtitle: Text('Added at: ${tasks[index].timeAdded}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          removeTask(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
