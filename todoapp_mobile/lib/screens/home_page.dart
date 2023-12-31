import 'package:flutter/material.dart';
import 'package:todoapp_mobile/controllers/todo_controller.dart';
import 'package:todoapp_mobile/services/http_service.dart';

import '../models/todo.dart';
import '../services/login_http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoController _controller = TodoController(HttpService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              LoginHTTP.logout().then((value) => Navigator.pushReplacementNamed(context, '/login'));
            },
            icon: const Icon(
              Icons.output,
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: ValueListenableBuilder<List<Todo>?>(
          valueListenable: _controller.todos,
          builder: (_, todos, __) {
            if (todos == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (todos.isEmpty) {
              return const Center(
                child: Text("Lista vazia"),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: todos.length,
              itemBuilder: (_, index) {
                return Card(
                  child: CheckboxListTile(
                    title: GestureDetector(
                      child: Text(todos[index].title),
                      onTap: () {
                        Navigator.pushNamed(context, '/view', arguments: {
                          'arg1': _controller,
                          'arg2': todos[index],
                        });
                      },
                    ),
                    value: todos[index].isDone,
                    onChanged: (bool? value) async{
                      Map data = {"is_done": value};
                      await _controller.updateTodo(data, todos[index].id!);
                    },
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/create_todo", arguments: _controller);
        },
        tooltip: 'New Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
