import React from 'react';
import { createBottomTabNavigator, createAppContainer } from 'react-navigation';

import TodoDetails from './TodoDetails';
import TodoList from './TodoList';
import CompletedTodoList from './CompletedTodoList';
import Icon from 'react-native-vector-icons/MaterialIcons';

const TabNavigator = createBottomTabNavigator(
  {
    Done: { screen: CompletedTodoList },
    Active: { screen: TodoList },
    Add: { screen: TodoDetails, },
  },
  {
    defaultNavigationOptions: ({ navigation }) => ({
      tabBarIcon: () => {
        const { routeName } = navigation.state;
        let iconsize = 28;
        let iconName;
        if (routeName === 'Done') {
          iconName = 'check';
        } else if (routeName === 'Active') {
          iconName = 'local-florist'
        } else if (routeName === 'Add') {
          iconName = 'exposure-plus-1';
        }
        return <Icon name={iconName} size={iconsize} />;
      },
    })
  }
);

export default createAppContainer(TabNavigator);