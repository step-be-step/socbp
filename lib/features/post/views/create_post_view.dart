import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socbp/common/common.dart';
import 'package:socbp/common/rounded_small_button.dart';
import 'package:socbp/features/auth/controller/auth_controller.dart';
import 'package:socbp/theme/pallete.dart';

class CreaetePostScreen extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreaetePostScreen());
  const CreaetePostScreen({super.key});

  @override
  ConsumerState<CreaetePostScreen> createState() => _CreaetePostScreenState();
}

class _CreaetePostScreenState extends ConsumerState<CreaetePostScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
        ),
        actions: [
          RoundedSmallButton(
            onTap: () {},
            label: 'Запостить',
            backgroundColor: Pallete.blueColor,
            textColor: Pallete.whiteColor,
          ),
        ],
      ),
      body: currentUser == null
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(currentUser.profilePic),
                      )
                    ],
                  )
                ],
              ),
            )),
    );
  }
}
