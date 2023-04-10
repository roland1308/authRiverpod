import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_riverpod_hooks/src/features/authentication/presentation/login_controller.dart';

import '../../../services/shared_preferences/shared_preferences_controller.dart';
import '../../../utils/show_snackbar.dart';
import '../../home/presentation/user_controller.dart';

class SigninPage extends HookConsumerWidget {
  SigninPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final password2Controller = useTextEditingController(text: '');

    final data = ref.watch(loginScreenControllerProvider);

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
              controller: nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Username',
              ),
              validator: (value) =>
              (value?.length ?? 0) > 5 ? null : 'Username is too short',
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Password',
              ),
              validator: (value) =>
              (value ?? "") != "" ? null : 'Passwords is required',
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: password2Controller,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Repeat Password',
              ),
              validator: (value) =>
              (value ?? "") == passwordController.text ? null : 'Passwords is different',
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && !data.isLoading) {
                    ref
                        .read(loginScreenControllerProvider.notifier)
                        .signIn(nameController.text, passwordController.text);
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
                      return const Text("Sign in");
                    },
                    error: (error, _) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showSnackBar(context, error.toString());
                      });
                      return const Text("Sign in");
                    },
                    loading: () => const CircularProgressIndicator())),
            const SizedBox(height: 15),
            TextButton(
                onPressed: () => context.go('/'),
                child: const Text("Already registered? Sign in!"))
          ],
        ),
      ),
    );
  }
}
