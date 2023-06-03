import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/TodoModel.dart';

class DatabaseController {
  final Reader ref;
  final String userId;
  DatabaseController(this.ref, this.userId);

  Future<TodoModel> addTodo(
      {required String title, required String description}) async {
    final docRef = FirebaseFirestore.instance.collection('todos');
    docRef.add({
      'id': docRef.id,
      'title': title,
      'isCompleted': false,
      'uid': userId,
      'description': description,
      'createdAt': Timestamp.now(),
    });
    final todo = TodoModel(
        id: docRef.id,
        title: title,
        isCompleted: false,
        description: description,
        createdAt: Timestamp.now(),
        uid: FirebaseAuth.instance.currentUser!.uid);
    return todo;
  }

  Future<void> updateTodoStatus(String id, bool isCompleted) async {
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(id)
        .update({'isCompleted': isCompleted});
  }

  Future<void> updateTodoText(
      String userId, String todoId, String title, bool isCompleted) async {
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(userId)
        .collection('tasks')
        .doc(todoId)
        .update({'isCompleted': isCompleted, 'title': title});
    // final updatedTodo =
    //     TodoModel(id: todoId, title: title, isCompleted: isCompleted);
    // return updatedTodo;
  }

  Future<void> deleteTodo(String todoId) async {
    await FirebaseFirestore.instance.collection('todos').doc(todoId).delete();
  }
}
