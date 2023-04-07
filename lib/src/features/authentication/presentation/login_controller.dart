import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_riverpod_hooks/src/features/authentication/data/authRepository.dart';

class LoginScreenController extends StateNotifier<AsyncValue<dynamic>> {
  LoginScreenController({required this.authRepository})
      : super(const AsyncData(null));

  final AuthRepository authRepository;

  Future<dynamic> signIn(String name) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.login(name));
  }
}

final loginScreenControllerProvider =
    StateNotifierProvider.autoDispose<LoginScreenController, AsyncValue<dynamic>>(
        (ref) {
  return LoginScreenController(
    authRepository: ref.watch(authRepositoryProvider),
  );
});
