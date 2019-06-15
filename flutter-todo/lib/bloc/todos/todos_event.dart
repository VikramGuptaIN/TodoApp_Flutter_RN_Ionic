import 'package:equatable/equatable.dart';
import 'package:flutter_todo/models/todo.dart';

abstract class TodosEvent extends Equatable {
  TodosEvent([List props = const []]) : super(props);
}

class LoadTodos extends TodosEvent {
  @override
  String toString() => 'LoadTodos';
}

class CompleteTodo extends TodosEvent {
  final int id;

  CompleteTodo(this.id) : super([id]);

  @override
  String toString() => 'CompleteTodo { id: $id }';
}

class AddTodo extends TodosEvent {
  final Todo todo;

  AddTodo(this.todo) : super([todo]);

  @override
  String toString() => 'AddTodo { todo: $todo }';
}