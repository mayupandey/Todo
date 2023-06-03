import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/src/provider/FirebaseProvider.dart';

import '../models/TodoModel.dart';

class TodoController extends StateNotifier<List<TodoModel>> {
  final Reader _read;
  final String? userId;

  TodoController(this._read, this.userId) : super([]);

  Future<void> addTodo(String title, String description) async {
    if (userId != null) {
      try {
        final todo = await _read(firebaseDbProvider)
            .addTodo(title: title, description: description);
        state = [...state, todo];
      } catch (e) {
        print('Error adding todo: $e');

        rethrow;
      }
    }
  }

  Future<void> updateTodoStatus(String todoId, bool isCompleted) async {
    if (userId != null) {
      try {
        final updatedTodo = await _read(firebaseDbProvider)
            .updateTodoStatus(todoId, isCompleted);
      } catch (e) {
        print('Error updating todo status: $e');
        rethrow;
      }
    }
  }

  Future<void> deleteTodo(String todoId) async {
    if (userId != null) {
      try {
        await _read(firebaseDbProvider).deleteTodo(todoId);
        state = state.where((todo) => todo.id != todoId).toList();
      } catch (e) {
        print('Error deleting todo: $e');
        rethrow;
      }
    }
  }
}
