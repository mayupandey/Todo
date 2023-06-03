import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LoadingState {
  loading,
  loaded,
}

final loadingProvider =
    StateProvider<LoadingState>((ref) => LoadingState.loaded);
