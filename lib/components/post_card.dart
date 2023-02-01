import 'package:flutter/material.dart';
import 'package:flutter_api/models/post_model.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.post});
  final Post post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(widget.post.title),
            subtitle: Text(widget.post.body),
          ),
        ],
      ),
    );
  }
}
