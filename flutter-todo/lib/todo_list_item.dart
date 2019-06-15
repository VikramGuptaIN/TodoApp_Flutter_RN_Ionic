import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_todo/bloc/todos/todos.dart';
import 'package:flutter_todo/models/todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  TodoListItem({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        leading: Text(
          '${todo.id}',
          style: TextStyle(fontSize: 10.0),
        ),
        trailing: Icon(
          todo.completed ? Icons.favorite : Icons.favorite_border,
          color: todo.completed ? Colors.red : null,
        ),
        title: Text(todo.title),
        dense: true,
      ),
      onTap: () => BlocProvider.of<TodosBloc>(context).dispatch(CompleteTodo(todo.id)),
    );
  }
}
