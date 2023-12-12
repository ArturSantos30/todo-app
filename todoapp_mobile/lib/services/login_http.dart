import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import 'login_service.dart';

class LoginHTTP implements LoginService{
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  @override
  Future<bool> authenticateUser(String username, String password) async {
    final response = await http.post(
      Uri.parse(APIConstants.loginURL),
      body: {
        'username': username,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      final authToken = json.decode(response.body)['access'];
      await saveToken(authToken);
      return true;
    }
    return false;
  }

  @override
  Future<bool> createUser(String username, String password) async{
    final response = await http.post(
      Uri.parse(APIConstants.createUserURL),
      body: {
        'username': username,
        'password': password,
      },
    );
    return (response.statusCode == 201)? true: false;
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<bool> verifyToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse(APIConstants.verifyToken),
      body: {
        'token': prefs.getString('authToken'),
      },
    );
    if (response.statusCode != 200){
      await prefs.clear();
      return false;
    }
    return true;
  }
}
