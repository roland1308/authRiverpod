import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_riverpod_hooks/src/features/authentication/domain/user_model.dart';
import 'package:login_riverpod_hooks/src/features/authentication/presentation/auth_controller.dart';
import 'package:login_riverpod_hooks/src/features/authentication/presentation/login_controller.dart';
import 'package:login_riverpod_hooks/src/features/authentication/presentation/login_page.dart';
import 'package:login_riverpod_hooks/src/features/authentication/presentation/signin_page.dart';
import 'package:login_riverpod_hooks/src/features/home/presentation/home_page.dart';
import 'package:login_riverpod_hooks/src/features/home/presentation/user_controller.dart';
import 'package:login_riverpod_hooks/src/services/shared_preferences/shared_preferences_controller.dart';
import 'package:login_riverpod_hooks/src/utils/show_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purpleAccent,
        primarySwatch: Colors.purple,
      ),
      home: data.when(
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
          return null;
        },
        error: (error, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, error.toString());
          });
          return const Text("Login");
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
