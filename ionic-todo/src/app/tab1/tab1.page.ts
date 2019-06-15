import { Component } from '@angular/core';
import { TodoService } from '../todo.service';
import { Todo } from '../models/todo';

@Component({
  selector: 'app-tab1',
  templateUrl: 'tab1.page.html',
  styleUrls: ['tab1.page.scss']
})
export class Tab1Page {
  todos: Todo[];

  constructor(private todoService: TodoService) {
    this.todoService.listenForTodos()
      .subscribe(todos => {
        this.todos = todos.filter(x => x.completed)
      })
  }

  onItemClick(todoId: string) {
    this.todoService.toggleTodo(todoId);
  }
}
