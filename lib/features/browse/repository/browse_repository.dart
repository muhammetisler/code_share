import 'package:auth_app/models/article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final browseRepositoryProvider = Provider(
  (ref) => BrowseRepository(
      firebaseFirestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance),
);

class BrowseRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;

  BrowseRepository({required this.firebaseFirestore, required this.auth});

  Stream<List<ArticleModel>> getArticles() {
    return firebaseFirestore
        .collection('articles')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
      (snapshot) {
        List<ArticleModel> list = [];
        for (var model in snapshot.docs) {
          list.add(ArticleModel.fromMap(model.data()));
        }
        return list;
      },
    );
  }
}
