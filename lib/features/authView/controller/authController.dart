import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../core/network/localStorage.dart';
import '../../../core/routes/appRouters.dart';
import '../Repository/authRepo.dart';
import 'authValidator.dart';

class AuthController extends GetxController {
  AuthController({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  final loginFormKey  = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController    = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  String? validateFullName(String? v) => AuthValidator.fullName(v);
  String? validateEmail(String? v)    => AuthValidator.email(v);
  String? validatePassword(String? v) => AuthValidator.password(v);

  /// Sign Up
  Future<void> signUp(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!(signUpFormKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;

    final result = await _repository.signUp(
      fullName: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    isLoading.value = false;

    if (result.isSuccess) {
      _clearControllers();
      if (context.mounted) {
        _showSnackBar(
          title: 'Success',
          message: 'Account created! Please log in.',
          isError: false,
        );
        context.go(AppRouter.login);
      }
    } else {
      _showSnackBar(
        title: 'Sign Up Failed',
        message: result.errorMessage!,
        isError: true,
      );
    }
  }

  /// Log In

  Future<void> logIn(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!(loginFormKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;

    final result = await _repository.logIn(
      email: emailController.text,
      password: passwordController.text,
    );

    isLoading.value = false;

    if (!context.mounted) return;

    if (result.isSuccess) {
      final token = await result.data!.getIdToken();
      if (token != null) {
        await StorageService.instance.saveToken(token);
      }
      _clearControllers();
      if (context.mounted) context.go(AppRouter.home);
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.errorMessage ?? 'Login failed.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  // ─── Sign Out ──────────────────────────────────────────────────────────────
  Future<void> signOut(BuildContext context) async {
    await StorageService.instance.clearToken();
    await _repository.signOut();
    if (context.mounted) context.go(AppRouter.login);
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────
  void _showSnackBar({
    required String title,
    required String message,
    required bool isError,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.redAccent : Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }

  void _clearControllers() {
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}