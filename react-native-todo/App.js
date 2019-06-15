import React, { Component } from 'react';
import HomeScreen from './src/views/HomeScreen';
var TodoStore = require('./src/stores/TodoStore');

export default class HelloWorldApp extends Component {
  render() {
    return (
      <HomeScreen/>
    );
  }
}
