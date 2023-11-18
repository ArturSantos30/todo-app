import 'dart:convert';

import 'package:todoapp_mobile/models/todo.dart';
import 'package:todoapp_mobile/services/todo_api.dart';
import 'package:http/http.dart' as http;

class HttpService implements TodoApi {
  static const String baseUrl = 'http://192.168.100.117:8000/api/v1/';
  // static const String baseUrl = 'http://45657.168.100.787867:8000/api/v1/';

  @override
  fetchTodos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  @override
  postTodos(Todo todo) async{
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': todo.title,
        'description': todo.description
      }),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create todo.');
    }
  }
}
