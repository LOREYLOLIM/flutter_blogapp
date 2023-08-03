// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) =>
    CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  int id;
  int postId;
  String name;
  String email;
  String comment;
  DateTime createdAt;

  CommentModel({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.comment,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        postId: json["post_id"],
        name: json["name"],
        email: json["email"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "post_id": postId,
        "name": name,
        "email": email,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
      };
}
