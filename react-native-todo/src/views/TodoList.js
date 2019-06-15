import React from 'react';
import { View, FlatList } from 'react-native';

import TodoStore from '../stores/TodoStore';
import TodoItem from './TodoItem'

export default class TodoList extends React.PureComponent {
  constructor() {
    super();
    this.state = {
      todos: TodoStore.getAllActive(),
      changeDetection: false,
    }

    TodoStore.subscribeForUpdates(() => {
      this.setState({
        todos: TodoStore.getAllActive(),
        changeDetection: !this.state.changeDetection
      })
    })
  }

  render() {
    const { todos } = this.state;

    return (
      <View>
        <FlatList
          data={todos}
          extraData={this.state.changeDetection}
          keyExtractor={(item) => item.id}
          renderItem={({ item }) => <TodoItem item={item} />}
        />
      </View>
    );
  }
}