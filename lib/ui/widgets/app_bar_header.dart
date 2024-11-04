import 'package:flutter/material.dart';
import 'package:practice_with_ostad/ui/controller/auth_controller.dart';
import 'package:practice_with_ostad/ui/screens/profile_screen.dart';
import 'package:practice_with_ostad/ui/screens/sign_in_screen.dart';
import '../utils/app_colors.dart';

class AppBarHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHeader({
    super.key,
    this.isProfileScreen = false,
  });

  final bool isProfileScreen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isProfileScreen) return;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
      },
      child: AppBar(
        backgroundColor: AppColors.themeColor,
        title:  Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: AppColors.themeColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AuthController.userData?.firstName} ${AuthController.userData?.lastName}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${AuthController.userData?.email}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                /// Clear access token
                await AuthController.clearUserData();

                /// Navigate to sign in screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(Icons.logout_outlined)),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
