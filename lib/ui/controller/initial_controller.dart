import 'package:get/get.dart';
import 'package:tm_getx/ui/controller/auth_controller.dart';
import 'package:tm_getx/ui/screens/main_screen.dart';
import 'package:tm_getx/ui/screens/sign_in_screen.dart';

class InitialController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _goToNextScreen();
  }

  Future<void> _goToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    await AuthController.getAccessToken();
    await AuthController.getUserData();

    if (AuthController.isLoggedIn()) {
      Get.offAllNamed(MainScreen.name);
    } else {
      Get.offNamed(SignInScreen.name);
    }
  }
}