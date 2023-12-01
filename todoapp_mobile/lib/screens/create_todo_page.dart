import 'package:flutter/material.dart';

import '../controllers/todo_controller.dart';

class CreateTodoPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  CreateTodoPage({super.key});

  @override
  Widget build(BuildContext context) {

    final todoController = ModalRoute.of(context)!.settings.arguments as TodoController;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new To Do'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: (){
              todoController.postTodos(
                _titleController.text,
                _descriptionController.text,
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
              controller: _titleController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
              maxLines: 3,
              controller: _descriptionController,
            ),
          ],
        ),
      ),
    );
  }
}
