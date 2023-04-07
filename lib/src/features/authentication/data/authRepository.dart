import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_riverpod_hooks/src/features/authentication/domain/user_model.dart';

import '../../../utils/personal_exception.dart';

class AuthRepository {
  Future<User?> login(String? name) async {
    try {
      /// Simulate login request
      await Future.delayed(const Duration(seconds: 3));
      if (name == "Renato") {
        return User(name: name ?? "NADA");
      } else {
        /// Wrong credentials
        throw PersonalException('Credentials not valid');
      }
    } catch (e) {
      throw PersonalException(e);
    }
  }
}

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository());
