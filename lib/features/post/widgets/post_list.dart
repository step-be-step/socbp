import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socbp/common/common.dart';
import 'package:socbp/constants/constants.dart';
import 'package:socbp/features/post/controller/post_controller.dart';
import 'package:socbp/features/post/widgets/post_card.dart';
import 'package:socbp/model/post_model.dart';

class PostList extends ConsumerWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getPostsProvider).when(
          data: (posts) {
            return ref.watch(getLatesPostProvider).when(
                  data: (data) {
                    if (data.events.contains(
                      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.postCollection}.documents.*.create',
                    )) {
                      posts.insert(0, Post.fromMap(data.payload));
                    }
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final post = posts[index];
                        return PostCard(post: post);
                      },
                    );
                  },
                  error: (error, stackTrace) =>
                      ErrorText(error: error.toString()),
                  loading: () {
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final post = posts[index];
                        return PostCard(post: post);
                      },
                    );
                  },
                );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
