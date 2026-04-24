import 'package:care_tutors/core/widget/customButton.dart';
import 'package:care_tutors/core/widget/customText.dart';
import 'package:care_tutors/core/widget/customTextField.dart';
import 'package:care_tutors/core/utils/customSize.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/authController.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller   = Get.find<AuthController>();
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * 0.35;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF1565C0),
      body: SafeArea(
        child: Stack(
          children: [
            _Header(headerHeight: headerHeight),
            _FormPanel(headerHeight: headerHeight, controller: controller),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.headerHeight});
  final double headerHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0, left: 0, right: 0,
      height: headerHeight,
      child: Container(
        color: const Color(0xFF1565C0),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox20,
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.school_rounded, color: Colors.white, size: 36),
            ),
            heightBox20,
            const CustomText(
              text: 'Create Your Account',
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            heightBox5,
            CustomText(
              text: 'Sign up to continue your journey',
              color: Colors.white.withOpacity(0.8),
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class _FormPanel extends StatelessWidget {
  const _FormPanel({required this.headerHeight, required this.controller});
  final double headerHeight;
  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: headerHeight - 10, left: 0, right: 0, bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(36),
            topRight: Radius.circular(36),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: 28, right: 28, top: 36,
            bottom: MediaQuery.of(context).viewInsets.bottom + 36,
          ),
          child: Form(
            key: controller.signUpFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Sign Up',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
                heightBox20,
                const CustomText(
                  text: 'Full Name',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF444444),
                ),
                heightBox5,
                CustomTextField(
                  controller: controller.fullNameController,
                  textLeftPadding: 10,
                  hintText: 'Enter your full name',
                  textColor: Colors.black,
                  showObscure: false,
                  validator: controller.validateFullName,
                  keyboardType: TextInputType.name,
                ),
                heightBox20,
                const CustomText(
                  text: 'Email',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF444444),
                ),
                heightBox5,
                CustomTextField(
                  controller: controller.emailController,
                  textLeftPadding: 10,
                  hintText: 'Enter your email',
                  textColor: Colors.black,
                  showObscure: false,
                  validator: controller.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                heightBox20,
                const CustomText(
                  text: 'Password',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF444444),
                ),
                heightBox5,
                CustomTextField(
                  controller: controller.passwordController,
                  textLeftPadding: 10,
                  hintText: 'Enter your password',
                  textColor: Colors.black,
                  showObscure: true,
                  validator: controller.validatePassword,
                ),
                heightBox20,
                Obx(() => CustomButtonWidget(
                  btnText: 'Sign Up',
                  isLoading: controller.isLoading.value,
                  onTap: () => controller.signUp(context),
                )),
                heightBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: 'Already have an account? ',
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const CustomText(
                        text: 'Log In',
                        color: Color(0xFF1565C0),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}