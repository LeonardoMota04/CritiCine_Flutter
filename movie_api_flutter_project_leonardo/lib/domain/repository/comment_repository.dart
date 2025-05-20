import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_api_flutter_project_leonardo/domain/models/comment.dart';

class CommentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream de comentários para um filme específico
  Stream<List<Comment>> getCommentsForMovie(int movieId) {
    return _firestore
        .collection('comments')
        .doc(movieId.toString())
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Comment.fromMap(doc.data()))
            .toList());
  }

  // Adiciona um comentário para um filme específico
  Future<void> addComment(int movieId, Comment comment) async {
    await _firestore
        .collection('comments')
        .doc(movieId.toString())
        .collection('messages')
        .add(comment.toMap());
  }
}
