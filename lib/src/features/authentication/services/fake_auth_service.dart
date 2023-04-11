import '../../../utils/personal_exception.dart';
import '../../boot/domain/user_model.dart';
import 'authService.dart';

class FakeAuthService extends AuthService{
  @override
  Future<User?> login(String email, String password) async {
    try {
      /// Simulate login request
      await Future.delayed(const Duration(seconds: 3));
      if (email == "Renato" && password == "r") {
        return User(name: email, token: "FAKE token");
      } else {
        /// Wrong credentials
        throw PersonalException('Credentials not valid');
      }
    } catch (e) {
      throw PersonalException(e);
    }
  }

  @override
  Future<User?> signin(String email, String password) async {
    try {
      /// Simulate register request
      await Future.delayed(const Duration(seconds: 3));
      if (email == "Renato") {
        return User(name: email, token: "FAKE token");
      } else {
        /// Error registration (f.e. user already exists)
        throw PersonalException('User already registered');
      }
    } catch (e) {
      throw PersonalException(e);
    }
  }

  @override
  Future<bool> checkToken(String token) async {
    try {
      /// Simulate check request
      await Future.delayed(const Duration(seconds: 3));
      if (token == "FAKE token") {
        return true;
      } else {
        /// Wrong token
        return false;
      }
    } catch (e) {
      throw PersonalException(e);
    }
  }
}
