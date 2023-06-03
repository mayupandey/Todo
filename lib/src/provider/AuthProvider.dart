import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/AuthController.dart';
import '../models/UserModel.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, UserModel?>((ref) {
  return AuthController(ref);
});
