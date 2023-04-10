import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/authService.dart';

class AuthController extends StateNotifier<AsyncValue<dynamic>> {
  AuthController({required this.authService}) : super(const AsyncData(null));

  final AuthService authService;

  Future<dynamic> checkToken(String token) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authService.checkToken(token));
  }
}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AsyncValue<dynamic>>(
        (ref) {
  return AuthController(authService: ref.watch(authServiceProvider));
});
