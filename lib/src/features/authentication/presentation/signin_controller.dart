import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/authRepository.dart';

class SigninController extends StateNotifier<AsyncValue<dynamic>> {
  SigninController({required this.authRepository})
      : super(const AsyncData(null));

  final AuthRepository authRepository;

  Future<dynamic> signIn(String name, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signin(name, password));
  }
}

final loginScreenControllerProvider =
StateNotifierProvider.autoDispose<SigninController, AsyncValue<dynamic>>(
        (ref) {
      return SigninController(
        authRepository: ref.watch(authRepositoryProvider),
      );
    });
