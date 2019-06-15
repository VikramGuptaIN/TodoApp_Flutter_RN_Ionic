import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_todo/bloc/todos/todos.dart';
import 'package:flutter_todo/bloc/filtered_todos/filtered_todos.dart';
import 'package:flutter_todo/bloc/tab/tab.dart';
import 'package:flutter_todo/models/visibility_filter.dart';
import 'package:flutter_todo/models/app_tab.dart';
import 'package:flutter_todo/todo_list.dart';
import 'package:flutter_todo/tab_selector.dart';
import 'package:flutter_todo/todo_add.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TabBloc _tabBloc = TabBloc();
  FilteredTodosBloc _filteredTodosBloc;

  @override
  void initState() {
    _filteredTodosBloc = FilteredTodosBloc(todosBloc: BlocProvider.of<TodosBloc>(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _tabBloc,
      builder: (BuildContext context, AppTab activeTab) {
        return BlocProviderTree(
          blocProviders: [
            BlocProvider<TabBloc>(bloc: _tabBloc),
            BlocProvider<FilteredTodosBloc>(bloc: _filteredTodosBloc),
          ],
          child: Scaffold(
            body: bodySelector(activeTab),
            bottomNavigationBar: TabSelector(
              activeTab: activeTab,
              onTabSelected: (tab) => onTabSelected(_tabBloc, _filteredTodosBloc, tab),
            ),
          ),
        );
      },
    );
  }

  Widget bodySelector(tab) {
    if (tab == AppTab.active) {
      return TodoList();
    } else if (tab == AppTab.completed) {
      return TodoList();
    } else {
      return TodoAdd();
    }
  }

  onTabSelected(TabBloc tabBloc, FilteredTodosBloc filteredTodosBloc, tab) {
    tabBloc.dispatch(UpdateTab(tab));

    // Could move the dispatches to the todo_list widgets build function to prevent spamming.
    if (tab == AppTab.active) {
      filteredTodosBloc.dispatch(UpdateFilter(VisibilityFilter.active));
    } else if (tab == AppTab.completed) {
      filteredTodosBloc.dispatch(UpdateFilter(VisibilityFilter.completed));
    } else {
      filteredTodosBloc.dispatch(UpdateFilter(VisibilityFilter.all));
    }
  }

  @override
  void dispose() {
    _filteredTodosBloc.dispose();
    _tabBloc.dispose();
    super.dispose();
  }
}
