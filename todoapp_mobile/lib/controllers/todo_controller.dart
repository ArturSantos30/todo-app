import 'package:flutter/foundation.dart';

import '../models/todo.dart';

class TodoController{
  ValueNotifier<List<Todo>> todos = ValueNotifier([Todo(title: 'Task 1'),Todo(title: 'Task 2')]);


}