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
      var tasksList = List.from(response).map((e) => Todo.fromJson(e)).toList();
      var tasksDone = tasksList.where((task) => task.isDone == true).toList();
      var tasksPending = tasksList.where((task) => task.isDone == false).toList();
      todos.value =  tasksPending + tasksDone;
    }
  }

  void postTodos(String title, String description) async{
    Todo todo = Todo(
      title: title,
      description: description,
    );
    await api.postTodos(todo);
    getTodos();
  }

  Future<bool> deleteTodo(int id) async {
    bool isDeleted = await api.deleteTodo(id);
    if (isDeleted){
      getTodos();
    }
    return isDeleted;
  }

  Future<bool> updateTodo(Map data, int id) async {
    bool isUpdated = await api.updateTodo(data, id);
    if (isUpdated){
      getTodos();
    }
    return isUpdated;
  }
}