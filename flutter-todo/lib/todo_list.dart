import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_todo/bloc/filtered_todos/filtered_todos.dart';
import 'package:flutter_todo/todo_list_item.dart';

class TodoList extends StatelessWidget {
  TodoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<FilteredTodosBloc>(context),
      builder: (BuildContext context, FilteredTodosState state) {
        if (state is FilteredTodosLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FilteredTodosLoaded) {
          if (state.filteredTodos.isEmpty) {
            return Center(
              child: Text('no todos'),
            );
          }
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return TodoListItem(todo: state.filteredTodos[index]);
              },
              itemCount: state.filteredTodos.length);
        }
      },
    );
  }
}
