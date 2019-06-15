import { Component } from '@angular/core';
import { Todo } from '../models/todo';
import { TodoService } from '../todo.service';

@Component({
  selector: 'app-tab2',
  templateUrl: 'tab2.page.html',
  styleUrls: ['tab2.page.scss']
})
export class Tab2Page {
  todos: Todo[];

  constructor(private todoService: TodoService) {
    this.todoService.listenForTodos()
      .subscribe(todos => {
        this.todos = todos.filter(x => !x.completed)
      })
  }

  onItemClick(todoId: string) {
    this.todoService.toggleTodo(todoId);
  }
}
