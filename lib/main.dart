import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_riverpod_hooks/src/features/authentication/presentation/state_controller.dart';
import 'package:login_riverpod_hooks/src/features/home/home_page.dart';
import 'package:login_riverpod_hooks/src/features/authentication/presentation/login_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLogged = ref.watch(userProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purpleAccent,
        primarySwatch: Colors.purple,
      ),
      home: userLogged == null
          ? LoginPage()
          : const HomePage(),
    );
  }
}
