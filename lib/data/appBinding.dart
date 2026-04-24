import 'package:get/get.dart';
import '../features/authView/Repository/authRepo.dart';
import '../features/authView/controller/authController.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());
    Get.lazyPut<AuthController>(
          () => AuthController(repository: Get.find<AuthRepository>()),
    );
  }
}