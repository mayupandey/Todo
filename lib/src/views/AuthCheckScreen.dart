import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/src/views/LoadingScreen.dart';
import 'package:todoapp/src/views/LoginScreen.dart';
import 'package:todoapp/src/views/TodoScreen.dart';

import '../provider/FirebaseProvider.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer(
        builder: (context, watch, _) {
          final currentUserAsyncValue = watch.watch(currentUserProvider);

          return currentUserAsyncValue.when(
            data: (currentUser) {
              if (currentUser == null) {
                return const SigninScreen();
              } else {
                return const TodoScreen();
              }
            },
            loading: () => const Loading(),
            error: (error, stackTrace) => Text('Error: $error'),
          );
        },
      ),
    );
  }
}
