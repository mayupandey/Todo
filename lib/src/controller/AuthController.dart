import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/src/provider/FirebaseProvider.dart';
import 'package:todoapp/src/provider/LoadingProvider.dart';

import '../models/UserModel.dart';

class AuthController extends StateNotifier<UserModel?> {
  final Ref ref;

  AuthController(this.ref) : super(null);

  Future<void> signInWithEmail(String email, String password) async {
    final a = ref.watch(loadingProvider.state);
    try {
      final authResult = await ref
          .watch(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() => a.state = LoadingState.loaded);
      state =
          UserModel(email: authResult.user!.email!, uid: authResult.user!.uid);
    } catch (e) {
      debugPrint(e.toString());
      a.state = LoadingState.loaded;
      rethrow;
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    final a = ref.watch(loadingProvider.state);
    try {
      final authResult = await ref
          .watch(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() => a.state = LoadingState.loaded);
      state =
          UserModel(email: authResult.user!.email!, uid: authResult.user!.uid);
    } catch (e) {
      debugPrint(e.toString());
      a.state = LoadingState.loaded;

      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await ref.watch(firebaseAuthProvider).signOut();

      state = null;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}