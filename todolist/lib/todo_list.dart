import 'package:flutter/material.dart';
import 'package:todolist/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todos = [];

  TextEditingController controller = new TextEditingController();

  _toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];

    return CheckboxListTile(
      value: todo.isDone,
      onChanged: (bool? isChecked) {
        if (isChecked != null) {
          _toggleTodo(todo, isChecked);
        }
      },
    );
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    backgroundColor: Colors.blue,
    padding: EdgeInsets.all(8),
  );

  _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Todo'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              style: flatButtonStyle,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              style: flatButtonStyle,
              onPressed: () {
                setState(() {
                  final todo = new Todo(title: controller.value.text);

                  todos.add(todo);
                  controller.clear();

                  Navigator.of(context).pop();
                });
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }
}