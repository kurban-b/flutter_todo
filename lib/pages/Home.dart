import 'package:flutter/material.dart';

class Todo {
  String? title;

  Todo(title) {
    this.title = title;
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List todos = [];

  @override
  void initState() {
    super.initState();
    todos.addAll([
      'hello',
      'by by by'
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список дел'),
        leading: Icon(Icons.assignment),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(todos[index]),
                child: Card(
                  child: ListTile(
                    title: Text(todos[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_rounded),
                      onPressed: () {
                        setState(() {
                          todos.removeAt(index);
                        });
                      },
                    ),
                  ),
                ),
              onDismissed: (direction) {
                setState(() {
                  todos.removeAt(index);
                });
              },
            );
          })
    );
  }
}
