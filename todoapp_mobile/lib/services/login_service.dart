abstract class LoginService{
  Future<bool> authenticateUser(String username, String password);
  Future<bool> createUser(String username, String password);
}