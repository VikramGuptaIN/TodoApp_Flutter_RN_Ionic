import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_todo/bloc/todos/todos.dart';
import 'package:flutter_todo/models/todo.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final http.Client httpClient;

  TodosBloc({@required this.httpClient});

  // Setting the initial state of the block
  @override
  get initialState => TodosUninitialized();

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is CompleteTodo) {
      yield* _mapCompleteTodoToState(event);
    } else if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    }
  }

  Stream<TodosState> _mapLoadTodosToState() async* {
    try {
      List<Todo> todos = await _fetchTodos();
      yield TodosUninitialized();
      yield TodosLoaded(todos: todos);
      return;
    } catch (_) {
      yield TodosError();
    }
  }

  Stream<TodosState> _mapCompleteTodoToState(CompleteTodo event) async* {
    if (currentState is TodosLoaded) {
      final List<Todo> updatedTodos = (currentState as TodosLoaded).todos.map((todo) {
        if (todo.id == event.id) {
          todo.completed = !todo.completed;
        }
        return todo;
      }).toList();
      yield TodosUninitialized();
      yield TodosLoaded(todos: updatedTodos);
      // TODO: Update the backend here
    }
  }

  Stream<TodosState> _mapAddTodoToState(AddTodo event) async* {
    if (currentState is TodosLoaded) {
      final List<Todo> updatedTodos = List.from((currentState as TodosLoaded).todos)..add(event.todo);
      yield TodosUninitialized();
      yield TodosLoaded(todos: updatedTodos);
      // TODO: Update the backend here
    }
  }

  Future<List<Todo>> _fetchTodos() async {
    final response = await httpClient.get('https://jsonplaceholder.typicode.com/todos');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawTodo) {
        return Todo(id: rawTodo['id'], title: rawTodo['title'], completed: rawTodo['completed']);
      }).toList();
    } else {
      throw Exception('error fetching todos');
    }
  }
}
