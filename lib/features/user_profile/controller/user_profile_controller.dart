import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socbp/apis/post_api.dart';
import 'package:socbp/model/post_model.dart';

final userProfileControllerProvider = StateNotifierProvider((ref) {
  return UserProfileController(
    postAPI: ref.watch(postAPIProvider),
  );
});

final getUserPostProvider = FutureProvider.family((ref, String uid) async {
  final userProfileController =
      ref.watch(userProfileControllerProvider.notifier);
  return userProfileController.getUserPost(uid);
});

class UserProfileController extends StateNotifier<bool> {
  final PostAPI _postApi;
  UserProfileController({required PostAPI postAPI})
      : _postApi = postAPI,
        super(false);

  Future<List<Post>> getUserPost(String uid) async {
    final post = await _postApi.getUserPost(uid);
    return post.map((e) => Post.fromMap(e.data)).toList();
  }
}
