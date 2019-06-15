import { Component } from '@angular/core';
import { Todo } from '../models/todo';
import { TodoService } from '../todo.service';

@Component({
  selector: 'app-tab3',
  templateUrl: 'tab3.page.html',
  styleUrls: ['tab3.page.scss']
})
export class Tab3Page {
  todo = new Todo();

  constructor(private todoService: TodoService) { }

  addTodo() {
    this.todo.completed = false;
    this.todo.id = Date.now().toString();
    this.todoService.addTodo(this.todo);
    this.todo = new Todo();
  }

}
