import '../services/login_service.dart';

class LoginController {
  final LoginService service;

  LoginController(this.service);

  Future<bool> login({
    required String username,
    required String password
  }) async{
    return await service.authenticateUser(username, password);
  }

  Future<bool> signUp({
    required String username,
    required String password
  }) async{
    if (await service.createUser(username, password)){
      return await service.authenticateUser(username, password);
    }
    return false;
  }
}