import 'package:blogapp/contants/constants.dart';
import 'package:blogapp/models/posts.dart';
import 'package:flutter/material.dart';

class BlogWidget extends StatelessWidget {
  const BlogWidget({
    super.key,
    // required this.title,
    // required this.image,
    // required this.body,
    // required this.created_at,
    required this.posts,
  });

  // final String title;
  // final String image;
  // final String body;
  // final String created_at;
  final Post posts;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage('$postImageurl${posts.image}'))),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                posts.createdAt.toIso8601String(),
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              Text(
                posts.title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Row(
                children: [
                  Icon(Icons.comment),
                  const SizedBox(width: 10),
                  Text('50k'),
                ],
              ),
            ],
          ),
        ))
      ],
    );
  }
}
