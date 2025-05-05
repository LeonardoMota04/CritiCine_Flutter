import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_api_flutter_project_leonardo/models/comment.dart';
import 'package:movie_api_flutter_project_leonardo/repository/comment_repository.dart';

class CommentsSection extends StatefulWidget {
  final int movieId;
  final String movieTitle;

  const CommentsSection({super.key, required this.movieId, required this.movieTitle});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final TextEditingController _controller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  final CommentRepository _repository = CommentRepository();

  // ADDS A NEW COMMENT
  void _addComment() async {
    final text = _controller.text.trim();
    if (text.isEmpty || user == null) return;

    final comment = Comment(
      userId: user!.uid,
      username: user!.email ?? 'Usuário anônimo',
      comment: text,
      timestamp: Timestamp.now(),
    );

    await _repository.addComment(widget.movieId, comment);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Comment>>(
      stream: _repository.getCommentsForMovie(widget.movieId),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text('Erro ao carregar comentários');
        if (!snapshot.hasData) return const CircularProgressIndicator();

        final comments = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Comentários",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  comments.length.toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ListView.builder(
              padding: const EdgeInsets.only(top: 8.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Card(
                  child: ListTile(
                    title: Text(comment.username),
                    subtitle: Text(comment.comment),
                    trailing: Text(
                      comment.timestamp.toDate().toLocal().toString().substring(0, 16),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                );
              },
            ),
            if (user != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Escreva um comentário...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _addComment,
                  ),
                ],
              ),
            ] else
              const Text('Faça login para comentar.')
          ],
        );
      },
    );
  }

}
