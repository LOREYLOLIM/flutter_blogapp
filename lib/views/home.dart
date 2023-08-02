import 'package:blogapp/contants/constants.dart';
import 'package:blogapp/controller/post_controller.dart';
import 'package:blogapp/views/details.dart';
import 'package:blogapp/views/widgets/blog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blogapp/models/posts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePagetState();
}

class HomePagetState extends State<HomePage> {
  final PostController _postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Blogs',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Blog',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              RefreshIndicator(
                onRefresh: () async {
                  await _postController.getAllPosts();
                },
                child: Container(
                  width: double.infinity,
                  child: Obx(() {
                    return _postController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: _postController.posts.value.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => PostDetail(
                                        posts:
                                            _postController.posts.value[index],
                                      ));
                                },
                                child: BlogWidget(
                                  // title:
                                  //     _postController.posts.value[index].title,
                                  // image:
                                  //     '$postImageurl${_postController.posts.value[index].image}',
                                  // body: _postController.posts.value[index].body,
                                  // created_at: _postController
                                  //     .posts.value[index].createdAt
                                  //     .toIso8601String()
                                  posts: _postController.posts.value[index],
                                ),
                              );
                            });
                  }),
                ),
              )
              // const SizedBox(height: 20),
              // const BlogWidget(
              //   color: Colors.blue,
              // ),
              // const SizedBox(height: 20),
              // const BlogWidget(
              //   color: Colors.green,
              // ),
              // const SizedBox(height: 20),
              // const BlogWidget(
              //   color: Colors.yellow,
              // ),
              // const SizedBox(height: 20),
              // const BlogWidget(
              //   color: Colors.red,
              // ),
              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
