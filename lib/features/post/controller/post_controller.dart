import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socbp/apis/post_api.dart';
import 'package:socbp/apis/storage_api.dart';
import 'package:socbp/core/enums/post_type_enum.dart';
import 'package:socbp/core/utils.dart';
import 'package:socbp/features/auth/controller/auth_controller.dart';
import 'package:socbp/model/post_model.dart';
import 'package:socbp/model/user_model.dart';

final postControllerProvider =
    StateNotifierProvider<PostController, bool>((ref) {
  return PostController(
    ref: ref,
    postAPI: ref.watch(postAPIProvider),
    storageAPI: ref.watch(storageAPIProvider),
  );
});

final getPostsProvider = FutureProvider((ref) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.getPosts();
});

final getRepliesToPostsProvider = FutureProvider.family((ref, Post post) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.getRepliseToPost(post);
});

final getLatesPostProvider = StreamProvider((ref) {
  final postAPI = ref.watch(postAPIProvider);
  return postAPI.getLatesPost();
});

final getPostByIdProvider = FutureProvider.family((ref, String id) async {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.getPostById(id);
});

class PostController extends StateNotifier<bool> {
  final PostAPI _postAPI;
  final StorageAPI _storageAPI;
  final Ref _ref;
  PostController({
    required Ref ref,
    required PostAPI postAPI,
    required StorageAPI storageAPI,
  })  : _ref = ref,
        _postAPI = postAPI,
        _storageAPI = storageAPI,
        super(false);

  Future<List<Post>> getPosts() async {
    final postList = await _postAPI.getPosts();
    return postList.map((post) => Post.fromMap(post.data)).toList();
  }

  Future<Post> getPostById(String id) async {
    final post = await _postAPI.getPostById(id);
    return Post.fromMap(post.data);
  }

  void likePost(Post post, UserModel user) async {
    List<String> likes = post.likes;

    if (post.likes.contains(user.uid)) {
      likes.remove(user.uid);
    } else {
      likes.add(user.uid);
    }

    post = post.copyWith(likes: likes);
    final res = await _postAPI.likePost(post);
    res.fold((l) => null, (r) => null);
  }

  void resharePost(
    Post post,
    UserModel currentUser,
    BuildContext context,
  ) async {
    post = post.copyWith(
      repostedBy: currentUser.name,
      likes: [],
      commentId: [],
      reshareCount: post.reshareCount + 1,
    );

    final res = await _postAPI.updateResharePost(post);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) async {
        post = post.copyWith(
          id: ID.unique(),
          reshareCount: 0,
          postAt: DateTime.now(),
        );
        final res2 = await _postAPI.sharePost(post);
        res2.fold((l) => showSnackBar(context, l.message),
            (r) => showSnackBar(context, 'Репост!'));
      },
    );
  }

  void sharePost({
    required List<File> images,
    required String text,
    required BuildContext context,
    required String repliedTo,
  }) {
    if (text.isEmpty) {
      showSnackBar(context, 'Пожалуста введите текс');
      return;
    }
    if (images.isNotEmpty) {
      _shareImagePost(
        images: images,
        text: text,
        context: context,
        repliedTo: repliedTo,
      );
    } else {
      _shareTextPost(
        text: text,
        context: context,
        repliedTo: repliedTo,
      );
    }
  }

  Future<List<Post>> getRepliseToPost(Post post) async {
    final document = await _postAPI.getRepliseToPost(post);
    return document.map((post) => Post.fromMap(post.data)).toList();
  }

  void _shareImagePost({
    required List<File> images,
    required String text,
    required BuildContext context,
    required String repliedTo,
  }) async {
    state = true;
    final hashtags = _getHashtagsFromText(text);
    String link = _getLinkFromText(text);
    final imageLinks = await _storageAPI.uploadImage(images);
    final user = _ref.read(currentUserDetailsProvider).value!;

    Post post = Post(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: imageLinks,
      uid: user.uid,
      postType: PostType.image,
      postAt: DateTime.now(),
      likes: const [],
      commentId: const [],
      id: '',
      reshareCount: 0,
      repostedBy: '',
      repliedTo: repliedTo,
    );
    final res = await _postAPI.sharePost(post);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  void _shareTextPost({
    required String text,
    required BuildContext context,
    required String repliedTo,
  }) async {
    state = true;
    final hashtags = _getHashtagsFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;

    Post post = Post(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: const [],
      uid: user.uid,
      postType: PostType.text,
      postAt: DateTime.now(),
      likes: const [],
      commentId: const [],
      id: '',
      reshareCount: 0,
      repostedBy: '',
      repliedTo: repliedTo,
    );
    final res = await _postAPI.sharePost(post);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  String _getLinkFromText(String text) {
    String link = '';
    List<String> wordInSentence = text.split(' ');
    for (String word in wordInSentence) {
      if (word.startsWith('https://') || word.startsWith('www.')) {
        link = word;
      }
    }
    return link;
  }

  List<String> _getHashtagsFromText(String text) {
    List<String> hashtags = [];
    List<String> wordInSentence = text.split(' ');
    for (String word in wordInSentence) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}
