import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/src/constant/constants.dart';

import '../controller/TodoController.dart';
import '../models/TodoModel.dart';
import 'FirebaseProvider.dart';

final todoProvider =
    StateNotifierProvider<TodoController, List<TodoModel>>((ref) {
  final userId = ref.watch(firebaseAuthProvider).currentUser!.uid;
  return TodoController(ref.read, userId);
});

final itemsProvider = StreamProvider<List<TodoModel>>(
  (ref) => ref
      .watch(firebaseFirestoreProvider)
      .collection(collectionName)
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .map((QuerySnapshot query) {
    List<TodoModel> user = [];
    for (var usersIter in query.docs) {
      final usersModel = TodoModel.fromSnapshot(usersIter);
      user.add(usersModel);
    }
    return user;
  }),
);
