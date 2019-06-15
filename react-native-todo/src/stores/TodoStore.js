import TodoActionTypes from './TodoActionTypes';
import TodoDispatcher from './TodoDispatcher';
import flux from 'flux'


const emitter = new flux.Dispatcher();
class TodoStore {
    todos = [];
    constructor() {
        this.fetchTodos();
    }
    getAll() {
        return this.todos;
    }
    getAllActive(){
        return this.todos.filter(x => !x.completed)
    }
    getAllCompleted() {
        return this.todos.filter(x => x.completed)
    }
    subscribeForUpdates(callback) {
        emitter.register(callback);
    }
    fetchTodos() {
        fetch('https://jsonplaceholder.typicode.com/todos')
            .then((response) => response.json())
            .then((responseJson) => {
                this.todos = responseJson;
                emitter.dispatch();
            })
            .catch((error) => {
                console.error(error);
            });
    }
}

const todoStore = new TodoStore;

// Registering the callbacks for the dispatcher
TodoDispatcher.register((payload) => {
    switch (payload.type) {
        case TodoActionTypes.ADD:
            payload.data.todo.id = Date.now();
            todoStore.todos = [payload.data.todo].concat(todoStore.todos);
            emitter.dispatch();
            break
        case TodoActionTypes.COMPLETE:
            const todo = todoStore.todos.find(x => x.id === payload.data.id);
            todo.completed = todo.completed ? false : true;
            emitter.dispatch();
            break
        default:
            return // irrelevant payload
    }
})



export default todoStore;