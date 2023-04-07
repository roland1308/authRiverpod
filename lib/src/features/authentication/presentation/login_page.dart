import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_riverpod_hooks/src/features/authentication/presentation/login_controller.dart';
import 'package:login_riverpod_hooks/src/features/home/user_controller.dart';

import '../../../services/shared_preferences/shared_preferences_controller.dart';
import '../../../utils/show_snackbar.dart';

class LoginPage extends HookConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: '');

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
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && !data.isLoading) {
                    ref
                        .read(loginScreenControllerProvider.notifier)
                        .signIn(nameController.text);
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
                      return const Text("Login");
                    },
                    error: (error, _) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showSnackBar(context, error.toString());
                      });
                      return const Text("Login");
                    },
                    loading: () => const CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }
}
