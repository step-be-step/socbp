import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socbp/apis/user_api.dart';
import 'package:socbp/model/user_model.dart';

final exploreControllerProvider = StateNotifierProvider((ref) {
  return ExploreController(
    userAPI: ref.watch(userAPIProvider),
  );
});

final searchUserProvider = FutureProvider.family((ref, String name) async {
  final exploreController = ref.watch(exploreControllerProvider.notifier);
  return exploreController.searchUser(name);
});

class ExploreController extends StateNotifier<bool> {
  final UserAPI _userApi;
  ExploreController({required UserAPI userAPI})
      : _userApi = userAPI,
        super(false);

  Future<List<UserModel>> searchUser(String name) async {
    final users = await _userApi.searchUserByName(name);
    return users.map((e) => UserModel.fromMap(e.data)).toList();
  }
}
