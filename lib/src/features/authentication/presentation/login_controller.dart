import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/authService.dart';

class LoginController extends StateNotifier<AsyncValue<dynamic>> {
  LoginController({required this.authService})
      : super(const AsyncData(null));

  final AuthService authService;

  Future<dynamic> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authService.login(email, password));
  }
}

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, AsyncValue<dynamic>>(
        (ref) {
  return LoginController(
    authService: ref.watch(authServiceProvider),
  );
});

final isLoginProvider = StateProvider<bool>((ref) => true);
