import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'FirebaseProvider.dart';

final dataProvider = StreamProvider<Map?>(
  (ref) {
    final userStream = ref.watch(firebaseAuthProvider).currentUser!.uid;

    if (userStream != null) {
      var docRef =
          FirebaseFirestore.instance.collection('todos').doc(userStream);
      return docRef.snapshots().map((doc) => doc.data());
    } else {
      return const Stream.empty();
    }
  },
);
