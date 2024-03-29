import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socbp/features/user_profile/widgets/user_profile.dart';
import 'package:socbp/model/user_model.dart';

class UserProfileView extends ConsumerWidget {
  static route(UserModel userModel) => MaterialPageRoute(
      builder: (context) => UserProfileView(userModel: userModel));
  final UserModel userModel;
  const UserProfileView({super.key, required this.userModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: UserProfile(user: userModel),
    );
  }
}
