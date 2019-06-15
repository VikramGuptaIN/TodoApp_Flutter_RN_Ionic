import React from 'react';
import { View, FlatList } from 'react-native';

import TodoStore from '../stores/TodoStore';
import TodoItem from './TodoItem'


export default class TodoList extends React.Component {
  constructor() {
    super();
    this.state = {
      todos: TodoStore.getAllCompleted(),
    }

    TodoStore.subscribeForUpdates(() => {
      this.setState({
        todos: TodoStore.getAllCompleted(),
      })
    })
  }

  render() {
    const { todos } = this.state;

    return (
      <View>
        <FlatList
          data={todos}
          extraData={this.state}
          keyExtractor={(item, index) => index.toString()}
          renderItem={({ item }) => <TodoItem item={item} />}
        />
      </View>
    );
  }
}