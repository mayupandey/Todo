import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:todoapp/src/provider/FirebaseProvider.dart';
import 'package:todoapp/src/provider/LoadingProvider.dart';

import '../models/UserModel.dart';

class AuthController extends StateNotifier<UserModel?> {
  final Ref ref;

  AuthController(this.ref) : super(null);

  Future<void> signInWithEmail(String email, String password) async {
    final a = ref.read(loadingProvider.state);
    try {
      final authResult = await ref
          .read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((error) {
            toast("Something went wrong");
            a.state = LoadingState.loaded;
          })
          .whenComplete(() => a.state = LoadingState.loaded)
          .then((value) {
            if (value.user == null) {
              toast("Something went wrong");
              a.state = LoadingState.loaded;
            }
          });
      a.state = LoadingState.loaded;
      print(authResult);
    } on FirebaseAuthException catch (e) {
      a.state = LoadingState.loaded;
      print("exception $e");
      toast("Something went wrong");
      a.state = LoadingState.loaded;
      if (e.code == 'account-exists-with-different-credential') {
        toast("Account Exist");
        a.state = LoadingState.loaded;

        // ...
      } else if (e.code == 'invalid-credential') {
        toast("Invalid Credential");
        a.state = LoadingState.loaded;
      } else {
        a.state = LoadingState.loaded;
      }
    } catch (e) {
      debugPrint("${e}me yha hu");
      a.state = LoadingState.loaded;
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
    } on FirebaseAuthException catch (e) {
      print("exception $e");
      toast("Something went wrong");
      a.state = LoadingState.loaded;
      if (e.code == 'account-exists-with-different-credential') {
        toast("Account Exist");

        // ...
      } else if (e.code == 'invalid-credential') {
        toast("Invalid Credential");
      }
    } catch (e) {
      debugPrint("${e}me yha hu");
      a.state = LoadingState.loaded;
    }
  }

  Future<void> signOut() async {
    final a = ref.watch(loadingProvider.state);
    try {
      await ref.watch(firebaseAuthProvider).signOut();
      a.state = LoadingState.loaded;
      state = null;
    } catch (e) {
      toast(e.toString());
      debugPrint(e.toString());
      rethrow;
    }
  }
}
