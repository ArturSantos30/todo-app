import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp_mobile/services/login_http.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    isAuthenticated().then((value){
      String route = (value)? '/home': '/login';
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<bool> isAuthenticated() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('authToken') != null){
      return await LoginHTTP.verifyToken();
    }
    return false;
  }
}
