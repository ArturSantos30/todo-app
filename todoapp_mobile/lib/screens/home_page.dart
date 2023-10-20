import 'package:flutter/material.dart';
import 'package:todoapp_mobile/controllers/todo_controller.dart';

import '../models/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoController _controller = TodoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder<List<Todo>>(
          valueListenable: _controller.todos,
          builder: (_, todos, __) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: todos.length,
              itemBuilder: (_, index){
                return Card(
                  child: CheckboxListTile(
                    title: Text(todos[index].title),
                    value: todos[index].isDone,
                    onChanged: (bool? value) {
                      setState(() {
                        todos[index].isDone = !todos[index].isDone;
                      });
                    },
                  ),
                );
              },
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
