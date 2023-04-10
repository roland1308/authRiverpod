import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/authService.dart';

class SigninController extends StateNotifier<AsyncValue<dynamic>> {
  SigninController({required this.authService})
      : super(const AsyncData(null));

  final AuthService authService;

  Future<dynamic> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authService.signin(email, password));
  }
}

final signinControllerProvider =
    StateNotifierProvider.autoDispose<SigninController, AsyncValue<dynamic>>(
        (ref) {
  return SigninController(
    authService: ref.watch(authServiceProvider),
  );
});
