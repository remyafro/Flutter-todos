import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _todoItems = [];
  String horseUrl = 'https://i.stack.imgur.com/Dw6f7.png';

  void _addTodoItem(String todo) {
    if (todo.length > 0) {
      setState(() {
        _todoItems.add(todo);
      });
    }
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add a new task'),
            ),
            body: new TextField(
              autofocus: true,
              onSubmitted: (val) {
                _addTodoItem(val);
                Navigator.pop(context);
              },
              decoration: new InputDecoration(
                hintText: "Enter something to do...",
                contentPadding: const EdgeInsets.all(20),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TodoList',
        ),
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
          ),
          new ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(horseUrl),
            ),
            title: Text(
              todoText,
            ),
            subtitle: Text(
              index.toString(),
            ),
            trailing: Icon(Icons.backspace),
            onTap: () => _promptRemoveTodoItem(index),
          ),
        ],
      ),
    );
  }
    void _removeTodoitem(int index){
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text("Mark ${_todoItems[index]} as done?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("CANCEL"),
            ),
            FlatButton(
              onPressed: () {
                _removeTodoitem(index);
                Navigator.of(context).pop();
              },
              child: Text('MARK AS DONE'),
            ),
          ],
        );
      },
    );
  }


}
