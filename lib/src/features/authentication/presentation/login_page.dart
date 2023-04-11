import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_riverpod_hooks/src/features/authentication/presentation/login_controller.dart';

import '../../../services/shared_preferences/shared_preferences_controller.dart';
import '../../../utils/show_snackbar.dart';
import '../../boot/presentation/user_controller.dart';

class LoginPage extends HookConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');

    final data = ref.watch(loginControllerProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Email',
              ),
              validator: (value) =>
                  (value?.length ?? 0) > 5 ? null : 'Email is too short',
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Password',
              ),
              validator: (value) =>
                  (value ?? "") != "" ? null : 'Password is required',
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && !data.isLoading) {
                    ref
                        .read(loginControllerProvider.notifier)
                        .login(emailController.text, passwordController.text);
                  }
                },
                child: data.when(
                    data: (data) {
                      if (data != null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ref
                              .read(sharedPreferencesProvider)
                              .setString('user', json.encode(data));
                          ref.read(userControllerProvider.notifier).state =
                              data;
                        });
                      }
                      return const Text("Log in");
                    },
                    error: (error, _) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showSnackBar(context, error.toString());
                      });
                      return const Text("Log in");
                    },
                    loading: () => const CircularProgressIndicator())),
            const SizedBox(height: 15),
            TextButton(
                onPressed: () {
                  ref.read(isLoginProvider.notifier).state = false;
                },
                child: const Text("Not yet registered? Sign in!"))
          ],
        ),
      ),
    );
  }
}
