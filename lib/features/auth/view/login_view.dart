import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:socbp/common/rounded_small_button.dart';
import 'package:socbp/constants/ui_constants.dart';
import 'package:socbp/features/auth/widgets/auth_field.dart';
import 'package:socbp/theme/pallete.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final appbar = UICosntants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

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
                    text: 'Нет аккауета?',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: ' Зарегестрируйся',
                        style: const TextStyle(
                          color: Pallete.blueColor,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
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
