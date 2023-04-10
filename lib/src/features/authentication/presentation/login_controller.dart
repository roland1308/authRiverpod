import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_riverpod_hooks/src/features/authentication/data/authRepository.dart';

class LoginController extends StateNotifier<AsyncValue<dynamic>> {
  LoginController({required this.authRepository})
      : super(const AsyncData(null));

  final AuthRepository authRepository;

  Future<dynamic> login(String name, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.login(name, password));
  }
}

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, AsyncValue<dynamic>>(
        (ref) {
  return LoginController(
    authRepository: ref.watch(authRepositoryProvider),
  );
});

final isLoginProvider = StateProvider<bool>((ref) => true);
