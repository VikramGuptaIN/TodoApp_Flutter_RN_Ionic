import React from 'react';
import Icon from 'react-native-vector-icons/FontAwesome';
import { ListItem } from 'react-native-elements';
import TodoActionTypes from '../stores/TodoActionTypes';
import TodoDispatcher from '../stores/TodoDispatcher';

export default class TodoItem extends React.Component {
    render() {
        let iconsize = 20;

        return (
            <ListItem
                leftElement={this.props.item.id}
                title={this.props.item.title}
                rightAvatar={this.props.item.completed ? <Icon name="heart" color="#ff0000" size={iconsize} /> : <Icon name="heart-o" size={iconsize} />}
                onPress={() => this._completeTodo(this.props.item.id)}
            />
        );
    }

    _completeTodo(id) {
        TodoDispatcher.dispatch({
            type: TodoActionTypes.COMPLETE,
            data: { id }
        });
    }
}