import 'dart:convert';

import 'package:blogapp/contants/constants.dart';
import 'package:blogapp/models/comments.dart';
import 'package:blogapp/models/posts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  // Post Model
  Rx<List<Post>> posts = Rx<List<Post>>([]);
  // Comment Model
  Rx<List<CommentModel>> comments = Rx<List<CommentModel>>([]);

  final isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getAllPosts();
    super.onInit();
  }

  // Method
  Future getAllPosts() async {
    try {
      posts.value.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}posts'), headers: {
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body)['post'];
        // print(content);
        for (var item in content) {
          // print(item);
          posts.value.add(Post.fromJson(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Method
  Future getComments(id) async {
    try {
      comments.value.clear();
      isLoading.value = true;

      var response =
          await http.get(Uri.parse('${url}post/comments/$id'), headers: {
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body)['comment'];
        print(content);
        for (var item in content) {
          comments.value.add(CommentModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
