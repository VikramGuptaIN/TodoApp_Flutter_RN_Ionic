import 'package:equatable/equatable.dart';

import 'package:flutter_todo/models/todo.dart';

abstract class TodosState extends Equatable {
  TodosState([List props = const []]) : super(props);
}

class TodosUninitialized extends TodosState {
  @override
  String toString() => 'TodosUninitialized';
}

class TodosError extends TodosState {
  @override
  String toString() => 'TodosError';
}

class TodosLoaded extends TodosState {
  final List<Todo> todos;

  TodosLoaded({
    this.todos,
  }) : super([todos]);

  TodosLoaded copyWith({
    List<Todo> todos,
  }) {
    return TodosLoaded(
      todos: todos ?? this.todos,
    );
  }

  @override
  String toString() => 'TodosLoaded { todos: ${todos.length}}';
}
