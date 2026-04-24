import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/appColors.dart';
import 'customText.dart';

class CustomButtonWidget extends StatelessWidget {
  final String btnText;
  final double? btnTextSize;
  final Color? btnTextColor;
  final Color? btnColor;
  final Color? borderColor;
  final VoidCallback onTap;
  final double? borderRadius;
  final bool italic;
  final FontWeight? btnTextFontWeight;
  final bool isLoading;
  final Gradient? fillGradient;
  final Gradient? strokeGradient;
  final double? height;

  final IconData? prefixIconData;
  final double? prefixIconSize;
  final Color? prefixIconColor;
  final String? prefixAssetIcon;
  final bool prefixAssetIsSvg;

  final IconData? suffixIconData;
  final double? suffixIconSize;
  final Color? suffixIconColor;
  final String? suffixAssetIcon;
  final bool suffixAssetIsSvg;

  const CustomButtonWidget({
    super.key,
    required this.btnText,
    required this.onTap,
    this.borderColor,
    this.btnTextColor,
    this.btnTextSize,
    this.btnColor,
    this.borderRadius,
    this.btnTextFontWeight,
    this.italic = false,
    this.isLoading = false,
    this.fillGradient,
    this.strokeGradient,
    this.height,
    this.prefixIconData,
    this.prefixIconSize,
    this.prefixIconColor,
    this.prefixAssetIcon,
    this.prefixAssetIsSvg = false,
    this.suffixIconData,
    this.suffixIconSize,
    this.suffixIconColor,
    this.suffixAssetIcon,
    this.suffixAssetIsSvg = false,
  });

  Widget? _buildIcon({
    required IconData? iconData,
    required double? iconSize,
    required Color? iconColor,
    required String? assetPath,
    required bool assetIsSvg,
  }) {
    if (iconData != null) {
      return FaIcon(
        iconData,
        size: iconSize ?? 20.h,
        color: iconColor ?? Colors.white,
      );
    }

    if (assetPath != null) {
      final double size = iconSize ?? 20.h;
      return Image.asset(
        assetPath,
        width: size,
        height: size,
        color: iconColor,
        fit: BoxFit.contain,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double radius = borderRadius ?? 10.r;

    final Widget? prefix = _buildIcon(
      iconData: prefixIconData,
      iconSize: prefixIconSize,
      iconColor: prefixIconColor,
      assetPath: prefixAssetIcon,
      assetIsSvg: prefixAssetIsSvg,
    );

    final Widget? suffix = _buildIcon(
      iconData: suffixIconData,
      iconSize: suffixIconSize,
      iconColor: suffixIconColor,
      assetPath: suffixAssetIcon,
      assetIsSvg: suffixAssetIsSvg,
    );

    return GestureDetector(
      onTap: isLoading ? () {} : onTap,
      child: _StrokeGradientWrapper(
        gradient: strokeGradient,
        borderRadius: radius,
        borderWidth: 0.3,
        child: Container(
          height: height ?? 40.h,
          // ✅ FIXED: Get.width → MediaQuery (GoRouter context safe)
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: fillGradient ??
                (btnColor != null
                    ? LinearGradient(
                  colors: [btnColor!, btnColor!],
                )
                    : AppColors.buttonGradient),
            color: fillGradient == null && btnColor == null ? null : null,
            border: strokeGradient == null
                ? Border.all(
              color: borderColor ?? Colors.transparent,
              width: 0.5,
            )
                : null,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefix != null) ...[
                    prefix,
                    SizedBox(width: 8.w),
                  ],
                  CustomText(
                    text: btnText,
                    fontFamily: 'SFPro',
                    fontSize: btnTextSize ?? 14.sp,
                    color: btnTextColor ?? Colors.white,
                    fontWeight: btnTextFontWeight ?? FontWeight.w500,
                    italic: italic,
                  ),
                  if (suffix != null) ...[
                    SizedBox(width: 8.w),
                    suffix,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StrokeGradientWrapper extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final double borderRadius;
  final double borderWidth;

  const _StrokeGradientWrapper({
    required this.child,
    required this.gradient,
    required this.borderRadius,
    required this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (gradient == null) return child;

    return CustomPaint(
      painter: _GradientBorderPainter(
        gradient: gradient!,
        borderRadius: borderRadius,
        borderWidth: borderWidth,
      ),
      child: child,
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  final Gradient gradient;
  final double borderRadius;
  final double borderWidth;

  _GradientBorderPainter({
    required this.gradient,
    required this.borderRadius,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect =
    RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_GradientBorderPainter oldDelegate) =>
      oldDelegate.gradient != gradient ||
          oldDelegate.borderRadius != borderRadius ||
          oldDelegate.borderWidth != borderWidth;
}