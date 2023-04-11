import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../services/shared_preferences/shared_preferences_controller.dart';
import '../../boot/presentation/user_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(sharedPreferencesProvider).clear();
                ref.read(userControllerProvider.notifier).state = null;
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: TextButton(
          child: Text(ref.read(userControllerProvider)?.name ?? "NADA"),
          onPressed: () => context.go('/details'),
        ),
      ),
    );
  }
}
