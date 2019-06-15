import React from 'react';
import { View, Button, StyleSheet } from 'react-native';

import TodoActionTypes from '../stores/TodoActionTypes';
import TodoDispatcher from '../stores/TodoDispatcher';
import { Input } from 'react-native-elements';


export default class TodoDetails extends React.Component {
  constructor() {
    super();
    this.state = {
      title: ''
    }
  }
  render() {
    return (
      <View style={styles.container}>
        <Input
          placeholder='Enter your todo here'
          style={styles.basic}
          onChangeText={(text) => this.setState({ title: text })}
          value={this.state.title}
        />
        <Button
          style={styles.basic}
          onPress={() => this._addTodo(this.state.title)}
          title="Add Todo"
        />
      </View>
    );
  }
  _addTodo(todoTitle) {
    if (!todoTitle) { return; }
    TodoDispatcher.dispatch({
      type: TodoActionTypes.ADD,
      data: { todo: { title: todoTitle, completed: false } }
    });
    this.setState({ todo: '' })
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 3,
    justifyContent: 'center',
  },
  basic: {
    padding: 20,
    margin: 20
  },
});