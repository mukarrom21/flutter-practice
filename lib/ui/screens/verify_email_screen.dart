import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practice_with_ostad/ui/screens/pin_verification_screen.dart';
import 'package:practice_with_ostad/ui/utils/app_colors.dart';
import 'package:practice_with_ostad/ui/widgets/background_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
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
                'Your Email Address',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'A 6 digits verification pin will send to your email address',
                style: textTheme.titleMedium,
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
            height: 24,
          ),
          ElevatedButton(
            onPressed: _onClickNextArrowButton,
            child: const Icon(Icons.arrow_circle_right_outlined),
          ),
        ],
      ),
    );
  }

  /// Build the sign up section
  Widget _buildSignUpSection(TextTheme textTheme) {
    return Center(
      child: RichText(
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
    );
  }

  void _onClickNextArrowButton() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const PinVerificationScreen()));
  }

  void _onClickHaveAccountSignIn() {
    Navigator.pop(context);
  }
}
