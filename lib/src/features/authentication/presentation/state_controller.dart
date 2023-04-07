import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_riverpod_hooks/src/features/authentication/data/login_repository.dart';

import '../domain/user_model.dart';

final userProvider = StateProvider<User?>((ref) => null);
final nameProvider = StateProvider<String?>((ref) => null);

final userRepositoryProvider =
    StateProvider<LoginRepository>((ref) => LoginRepository());
final userData = FutureProvider<User?>((ref) async {
  final name = ref.watch(nameProvider);
  return ref.watch(userRepositoryProvider).login(name);
});
