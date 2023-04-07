
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/authRepository.dart';

class AuthController extends StateNotifier<AsyncValue<dynamic>> {
  AuthController({required this.authRepository}) : super(const AsyncData(null));

  final AuthRepository authRepository;

  Future<dynamic> checkToken(String token) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.checkToken(token));
  }
}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AsyncValue<dynamic>>(
        (ref) {
  return AuthController(authRepository: ref.watch(authRepositoryProvider));
});
