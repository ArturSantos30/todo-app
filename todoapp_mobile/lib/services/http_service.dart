import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp_mobile/models/todo.dart';
import 'package:todoapp_mobile/services/todo_api.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class HttpService implements TodoApi {
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken')!;
  }

  @override
  fetchTodos() async {
    String authToken = await getToken();
    final response = await http.get(
      Uri.parse(APIConstants.getTodos),
      headers: {
        'Content-Type': APIConstants.contentType,
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  @override
  postTodos(Todo todo) async {
    String authToken = await getToken();
    final response = await http.post(
      Uri.parse(APIConstants.urlTodos),
      headers: {
        'Content-Type': APIConstants.contentType,
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({'title': todo.title, 'description': todo.description}),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create todo.');
    }
  }

  @override
  Future<bool> deleteTodo(int id) async {
    String authToken = await getToken();
    String url = '${APIConstants.urlTodos}$id/';
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': APIConstants.contentType,
        'Authorization': 'Bearer $authToken',
      },
    );
    return (response.statusCode == 204)? true: false;
  }

  @override
  Future<bool> updateTodo(Map data ,int id) async {
    String authToken = await getToken();
    String url = '${APIConstants.urlTodos}$id/';
    final response = await http.patch(
      Uri.parse(url),
      headers: {
        'Content-Type': APIConstants.contentType,
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(data),
    );
    return (response.statusCode == 200)? true: false;
  }
}
