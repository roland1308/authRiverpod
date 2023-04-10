import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_riverpod_hooks/src/features/authentication/domain/user_model.dart';

import 'fake_auth_service.dart';

abstract class AuthService {
  Future<User?> login(String email, String password) {
    throw UnimplementedError();
  }

  Future<User?> signin(String email, String password) {
    throw UnimplementedError();
  }

  Future<bool> checkToken(String token) {
    throw UnimplementedError();
  }
}

final authServiceProvider =
    Provider<FakeAuthService>((ref) => FakeAuthService());
