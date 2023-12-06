import 'package:todoapp_mobile/models/todo.dart';

abstract class TodoApi {
  fetchTodos();
  postTodos(Todo todo);
  deleteTodo(int id);
}
