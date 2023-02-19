import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:socbp/common/common.dart';
import 'package:socbp/constants/constants.dart';
import 'package:socbp/features/auth/view/login_view.dart';
import 'package:socbp/features/auth/widgets/auth_field.dart';
import 'package:socbp/theme/theme.dart';

class SignUpView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final appbar = UICosntants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AuthField(
                  controller: emailController,
                  hintText: 'Почта',
                ),
                const SizedBox(height: 25),
                AuthField(
                  controller: passwordController,
                  hintText: 'Пароль',
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.topRight,
                  child: RounderSmallButton(
                    onTap: () {},
                    label: 'Готово',
                  ),
                ),
                const SizedBox(height: 25),
                RichText(
                  text: TextSpan(
                    text: 'Есть аккауета?',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: ' Войди',
                        style: const TextStyle(
                          color: Pallete.blueColor,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              LoginView.route(),
                            );
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
