import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constants/appColors.dart';
import 'customText.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? fontSize;
  final VoidCallback? onTap;
  final bool centerTitle;
  final Color? backgroundColor;
  final bool forceMaterialTransparency;
  final bool? automaticallyImplyLeading;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? titleColor;
  final bool titleItalic;
  final Color? backButtonColor;
  final Color? backIconColor;

  // ✅ NEW: control back button
  final bool showBackButton;

  // ✅ Optional suffix icon
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.fontSize,
    this.centerTitle = true,
    this.backgroundColor = Colors.white,
    this.forceMaterialTransparency = true,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading,
    this.onTap,
    this.titleColor,
    this.titleItalic = false,
    this.backButtonColor,
    this.backIconColor,
    this.suffixIcon,
    this.onSuffixTap,

    this.showBackButton = true, // ✅ default ON
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 36.w,
      forceMaterialTransparency: forceMaterialTransparency,
      automaticallyImplyLeading: false, // ❗ control manually
      backgroundColor: backgroundColor,
      elevation: forceMaterialTransparency ? 0 : null,
      centerTitle: centerTitle,

      actions: [
        if (suffixIcon != null)
          Padding(
            padding: EdgeInsets.only(right: 14.w),
            child: GestureDetector(
              onTap: onSuffixTap,
              child: Container(
                height: 32.h,
                width: 32.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0XFFF9FAFB),
                ),
                alignment: Alignment.center,
                child: Icon(
                  suffixIcon,
                  size: 16.h,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        if (actions != null) ...actions!,
      ],

      title: CustomText(
        text: title,
        fontSize: fontSize ?? 14.h,
        fontWeight: FontWeight.w500,
        color: titleColor ?? AppColors.textColor,
        italic: titleItalic,
        fontFamily: 'SFPro',
      ),

      /// ✅ Leading Logic
      leading: leading ??
          (showBackButton
              ? Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap ??
                      () {
                    if (Get.isSnackbarOpen) {
                      Get.closeCurrentSnackbar();
                    }
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      if (kDebugMode) {
                        print("No routes to pop");
                      }
                    }
                  },
              child: Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                  backButtonColor ?? const Color(0XFFF3F3F5),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 12.h,
                  color:
                  backIconColor ?? const Color(0XFF4A4A4A),
                ),
              ),
            ),
          )
              : const SizedBox()), // ❗ hide করলে empty space
    );
  }
}