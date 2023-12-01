import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    isAuthenticated().then((value) => {
      if (value){
        Navigator.pushReplacementNamed(context, '/home')
      } else{
        Navigator.pushReplacementNamed(context, '/login')
      }
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
    return (prefs.getString('authToken') != null)? true: false;
  }
}
