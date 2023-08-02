import 'package:blogapp/contants/constants.dart';
import 'package:blogapp/models/posts.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key, required this.posts});

  @override
  State<PostDetail> createState() => _PostDetailState();

  final Post posts;
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.posts.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network('$postImageurl${widget.posts.image}'),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  widget.posts.title,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.posts.body,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Posted At ${widget.posts.createdAt.toIso8601String()}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
