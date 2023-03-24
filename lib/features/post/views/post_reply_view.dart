import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socbp/common/common.dart';
import 'package:socbp/constants/appwrite_constants.dart';
import 'package:socbp/features/post/controller/post_controller.dart';
import 'package:socbp/features/post/widgets/post_card.dart';
import 'package:socbp/model/post_model.dart';

class PostReplyScreen extends ConsumerWidget {
  static route(Post post) => MaterialPageRoute(
        builder: (context) => PostReplyScreen(
          post: post,
        ),
      );

  final Post post;

  const PostReplyScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пост'),
      ),
      body: Column(
        children: [
          PostCard(post: post),
          ref.watch(getRepliesToPostsProvider(post)).when(
                data: (posts) {
                  return ref.watch(getLatesPostProvider).when(
                        data: (data) {
                          final latesPost = Post.fromMap(data.payload);

                          bool isPostAlredyPresent = false;
                          for (final postModel in posts) {
                            if (postModel.id == latesPost.id) {
                              isPostAlredyPresent = true;
                              break;
                            }
                          }
                          if (!isPostAlredyPresent &&
                              latesPost.repliedTo == post.id) {
                            if (data.events.contains(
                              'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.postCollection}.documents.*.create',
                            )) {
                              posts.insert(0, Post.fromMap(data.payload));
                            } else if (data.events.contains(
                              'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.postCollection}.documents.*.update',
                            )) {
                              final startingPoint =
                                  data.events[0].lastIndexOf('documents.');
                              final endPoint =
                                  data.events[0].lastIndexOf('.update');
                              final postId = data.events[0]
                                  .substring(startingPoint + 10, endPoint);
                              var post = posts
                                  .where((element) => element.id == postId)
                                  .first;

                              final postIndex = posts.indexOf(post);
                              posts.removeWhere(
                                  (element) => element.id == postId);

                              post = Post.fromMap(data.payload);
                              posts.insert(postIndex, post);
                            }
                          }

                          return Expanded(
                            child: ListView.builder(
                              itemCount: posts.length,
                              itemBuilder: (BuildContext context, int index) {
                                final post = posts[index];
                                return PostCard(post: post);
                              },
                            ),
                          );
                        },
                        error: (error, stackTrace) =>
                            ErrorText(error: error.toString()),
                        loading: () {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: posts.length,
                              itemBuilder: (BuildContext context, int index) {
                                final post = posts[index];
                                return PostCard(post: post);
                              },
                            ),
                          );
                        },
                      );
                },
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
                loading: () => const Loader(),
              ),
        ],
      ),
      bottomNavigationBar: TextField(
        onSubmitted: (value) {
          ref.read(postControllerProvider.notifier).sharePost(
            images: [],
            text: value,
            context: context,
            repliedTo: post.id,
          );
        },
        decoration: const InputDecoration(hintText: 'Post'),
      ),
    );
  }
}
