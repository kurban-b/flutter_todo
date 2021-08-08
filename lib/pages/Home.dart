import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List todos = [];
  String _titleOfTodo = '';

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
      body: StreamBuilder<QuerySnapshot> (
        stream: FirebaseFirestore.instance.collection('todos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Text('список дел пуст');
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data.docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text(snapshot.data.docs[index].get('todo')),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_rounded),
                        onPressed: () {
                          setState(() {
                            FirebaseFirestore.instance.collection('todos').doc(snapshot.data.docs[index].id).delete();
                          });
                        },
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    FirebaseFirestore.instance.collection('todos').doc(snapshot.data.docs[index].id).delete();
                  },
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Добавить дело'),
              content: TextField(
                onChanged: (String value) {
                  _titleOfTodo = value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: () {
                  FirebaseFirestore.instance.collection('todos').add({'todo': _titleOfTodo});

                  Navigator.of(context).pop();
                }, child: Text('Добавить'))
              ],
            );
          });
        },
      ),
    );
  }
}
