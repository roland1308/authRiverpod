import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/shared_preferences/shared_preferences_controller.dart';
import '../boot/presentation/user_controller.dart';


class DetailsPage extends ConsumerWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Page"),
      ),
      body: Center(
        child: Text(
          ref.read(userControllerProvider)?.name ?? "NADA",
        ),
      ),
    );
  }
}
