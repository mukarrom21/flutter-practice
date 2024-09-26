import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practice_with_ostad/ui/utils/app_colors.dart';
import 'package:practice_with_ostad/ui/widgets/background_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 85,
              ),

              /// Title Section
              Text(
                'Join With Us',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              /// Sign in form
              _buildSignInForm(),

              const SizedBox(
                height: 28,
              ),

              /// Forgot Password and Sign Up section
              _buildSignUpSection(textTheme),
            ],
          ),
        ),
      ),
    );
  }

  /// Build the sign in form
  Widget _buildSignInForm() {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: "First Name",
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: "Last Name",
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: "Mobile",
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Password",
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: _onClickNextArrow,
            child: const Icon(Icons.arrow_circle_right_outlined),
          ),
        ],
      ),
    );
  }

  /// Build the sign up section
  Widget _buildSignUpSection(TextTheme textTheme) {
    return Center(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              text: 'Have account? ',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: ' Sign in',
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.themeColor,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = _onClickHaveAccountSignIn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onClickNextArrow() {
    Navigator.pop(context);
  }

  void _onClickHaveAccountSignIn() {
    Navigator.pop(context);
  }
}
