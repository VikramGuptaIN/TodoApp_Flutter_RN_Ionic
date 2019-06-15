import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject } from 'rxjs';
import { Todo } from './models/todo';


@Injectable({
    providedIn: 'root',
})
export class TodoService {
    private $todos = new BehaviorSubject<Todo[]>([]);

    constructor(private http: HttpClient) {
        // Intiialize todos
        http.get('https://jsonplaceholder.typicode.com/todos').subscribe((todos: Todo[]) => {
            this.$todos.next(todos);
        })
    }

    listenForTodos() {
        return this.$todos.asObservable();
    }

    toggleTodo(todoId: string) {
        const newTodos = this.$todos.getValue().map(todo => {
            if (todo.id === todoId) {
                todo.completed = !todo.completed
            }
            return todo;
        })
        this.$todos.next(newTodos);
    }

    addTodo(todo: Todo) {
        const newTodos = this.$todos.getValue();
        newTodos.push(todo);
        this.$todos.next(newTodos);
    }
}