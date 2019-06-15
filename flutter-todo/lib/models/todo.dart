import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String title;
  bool completed;

  Todo({this.id, this.title, this.completed}) : super([id, title, completed]);

  @override
  String toString() => 'Post { id: $id }';
}