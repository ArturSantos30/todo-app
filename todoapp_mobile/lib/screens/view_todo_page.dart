import 'package:flutter/material.dart';
import 'package:todoapp_mobile/controllers/todo_controller.dart';

class ViewTodoPage extends StatefulWidget {
  const ViewTodoPage({super.key});

  @override
  State<ViewTodoPage> createState() => _ViewTodoPageState();
}

class _ViewTodoPageState extends State<ViewTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final todoController = args['arg1'] as TodoController;
    final todo = args['arg2'];

    _titleController.text = todo.title;
    _descriptionController.text = todo.description;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View To Do'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()){
                Map data = {
                  'title': _titleController.text,
                  'description': _descriptionController.text
                };
                todoController.updateTodo(data, todo.id).then((value){
                  if (value) {
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Something went wrong')),
                    );
                  }
                });
              }
              // Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              todoController.deleteTodo(todo.id).then((value){
                if (value) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Something went wrong')),
                  );
                }
              });
            },
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                controller: _titleController,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
                maxLines: 3,
                controller: _descriptionController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
