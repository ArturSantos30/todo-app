class APIConstants{
  static const String baseURL = "http://192.168.100.117:8000/api";
  static const String loginURL = "$baseURL/token/";
  static const String getTodos = "$baseURL/get-todos/";
  static const String urlTodos = "$baseURL/todos/";
  static const String createUserURL = "$baseURL/register/";
  static const String contentType = 'application/json;charset=utf-8';
}