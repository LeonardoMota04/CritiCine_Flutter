import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String userId;
  final String username;
  final String comment;
  final Timestamp timestamp;

  Comment({
    required this.userId,
    required this.username,
    required this.comment,
    required this.timestamp,
  });

  // cria um objeto Comment a partir de um mapa (ex: vindo do Firebase)
  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      userId: map['userId'] ?? '',
      username: map['username'] ?? 'Usuário anônimo',
      comment: map['comment'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }

  // converte um objeto Comment em mapa para salvar no Firebase
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'comment': comment,
      'timestamp': timestamp,
    };
  }
}
