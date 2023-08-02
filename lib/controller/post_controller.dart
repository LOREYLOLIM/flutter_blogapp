import 'dart:convert';

import 'package:blogapp/contants/constants.dart';
import 'package:blogapp/models/posts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  Rx<List<Post>> posts = Rx<List<Post>>([]);

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
}
