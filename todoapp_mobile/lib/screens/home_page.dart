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
            onPressed: (){
              LoginHTTP.logout().then((value) =>
                  Navigator.pushReplacementNamed(context, '/login'));
            },
            icon: const Icon(Icons.output,),
          ),
          const SizedBox(width: 15,)
        ],
      ),
      body: ValueListenableBuilder<List<Todo>?>(
          valueListenable: _controller.todos,
          builder: (_, todos, __) {
            if (todos == null){
              return const Center(
                child: Text("Algo deu errado"),
              );
            }
            if (todos.isEmpty){
              return const Center(
                child: Text("Lista vazia"),
              );
            }
            if (todos.isNotEmpty){
              return ListView.builder(
                shrinkWrap: true,
                itemCount: todos.length,
                itemBuilder: (_, index){
                  return Card(
                    child: CheckboxListTile(
                      title: Text(todos[index].title),
                      value: false,
                      onChanged: (bool? value) {  },
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, "/create_todo", arguments: _controller);
        },
        tooltip: 'New Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
