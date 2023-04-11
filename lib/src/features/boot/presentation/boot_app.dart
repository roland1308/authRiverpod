
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_riverpod_hooks/src/features/boot/presentation/user_controller.dart';

import '../../../services/shared_preferences/shared_preferences_controller.dart';
import '../../../utils/show_snackbar.dart';
import '../../authentication/presentation/auth_controller.dart';
import '../../authentication/presentation/login_controller.dart';
import '../../authentication/presentation/login_page.dart';
import '../../authentication/presentation/signin_page.dart';
import '../../home/presentation/home_page.dart';
import '../domain/user_model.dart';

class BootApp extends HookConsumerWidget {
  const BootApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        String? data = ref.read(sharedPreferencesProvider).getString("user");
        String token = "";
        if ((data ?? "null") != "null") {
          User storedUser = User.fromJson(json.decode(data!));
          ref.read(userControllerProvider.notifier).state = storedUser;
          token = storedUser.token;
        }
        ref.read(authControllerProvider.notifier).checkToken(token);
      });
      return null;
    }, [ref.watch(userControllerProvider)?.token]);

    final data = ref.watch(authControllerProvider);
    final isLogin = ref.watch(isLoginProvider);

    return SafeArea(
      child: data.when(
        data: (data) {
          if (data != null) {
            if (data) {
              return const HomePage();
            } else {
              return isLogin
                  ? LoginPage()
                  : SigninPage();
            }
          }
          return const Text("Login");
        },
        error: (error, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, error.toString());
          });
          return const Text("Login");
        },
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
