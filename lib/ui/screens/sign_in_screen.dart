import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practice_with_ostad/data/models/login_model.dart';
import 'package:practice_with_ostad/data/models/network_response.dart';
import 'package:practice_with_ostad/data/services/network_caller.dart';
import 'package:practice_with_ostad/data/utils/urls.dart';
import 'package:practice_with_ostad/ui/controller/auth_controller.dart';
import 'package:practice_with_ostad/ui/screens/main_screen.dart';
import 'package:practice_with_ostad/ui/screens/signup_screen.dart';
import 'package:practice_with_ostad/ui/screens/verify_email_screen.dart';
import 'package:practice_with_ostad/ui/utils/app_colors.dart';
import 'package:practice_with_ostad/ui/widgets/background_screen.dart';
import 'package:practice_with_ostad/ui/widgets/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
                'Get Started With',
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
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Please enter your email address";
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: _passwordController,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Please enter your password";
              } else if (value!.length < 6) {
                return "Password must be at least 6 characters long";
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Password",
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: !_isLoading,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ElevatedButton(
              onPressed: _onClickNextArrowButton,
              child: const Icon(Icons.arrow_circle_right_outlined),
            ),
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
          TextButton(
            onPressed: _onClickForgotPassword,
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Don\'t have an account? ',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: ' Sign Up',
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.themeColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = _onClickDontHaveAccountSignup,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onClickNextArrowButton() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _login();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text,
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.login,
      data: requestBody,
    );

    setState(() {
      _isLoading = false;
    });

    if (response.isSuccess) {
      /// save user data
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      /// save access token
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userData!);

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (route) => false,
        );
        showSnackBarMessage(context, "Login completed successfully", false);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage, true);
      }
    }
  }

  void _onClickForgotPassword() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const VerifyEmailScreen()));
  }

  void _onClickDontHaveAccountSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }
}
