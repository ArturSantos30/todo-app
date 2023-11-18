import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/todo_api.dart';

class TodoController{
  final TodoApi api;
  ValueNotifier<List<Todo>?> todos = ValueNotifier(null);

  TodoController(this.api){
    getTodos();
  }

  void getTodos() async{
    var response = await api.fetchTodos();
    if (response == null){
      todos.value = null;
    } else {
      todos.value = List.from(response).map((e) => Todo.fromJson(e)).toList();
    }
  }

  void postTodos(Todo todo) async{
    await api.postTodos(todo);
  }
}