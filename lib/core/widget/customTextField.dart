import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/appColors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool showObscure;
  final bool? readOnly;

  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final VoidCallback? onPrefixTap;

  final IconData? postfixIcon;
  final Color? postfixIconColor;
  final VoidCallback? onPostfixTap;

  final String? prefixAssetIcon;
  final Color? prefixAssetIconColor;
  final double? prefixAssetIconSize;
  final VoidCallback? onPrefixAssetTap;

  final String? postfixAssetIcon;
  final Color? postfixAssetIconColor;
  final double? postfixAssetIconSize;
  final VoidCallback? onPostfixAssetTap;

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? borderColor;
  final Color? hintTextColor;
  final Color? obscureIconColor;
  final Color? cursorColor;
  final Color? textColor;
  final int? maxLines;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  final double? textLeftPadding;
  final double? height;
  final double? fontSize;
  final String? fontFamily;

  // Form validation support
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.showObscure,
    this.keyboardType,
    this.controller,
    this.prefixIcon,
    this.prefixIconColor,
    this.onPrefixTap,
    this.postfixIcon,
    this.postfixIconColor,
    this.onPostfixTap,
    this.prefixAssetIcon,
    this.prefixAssetIconColor,
    this.prefixAssetIconSize,
    this.onPrefixAssetTap,
    this.postfixAssetIcon,
    this.postfixAssetIconColor,
    this.postfixAssetIconSize,
    this.onPostfixAssetTap,
    this.fillColor,
    this.borderColor,
    this.hintTextColor,
    this.obscureIconColor,
    this.cursorColor,
    this.textColor,
    this.maxLines,
    this.readOnly,
    this.errorText,
    this.onChanged,
    this.textLeftPadding,
    this.height,
    this.fontSize,
    this.fontFamily,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  String? _validationError;

  // ── Helpers ───────────────────────────────────────────────────────────────

  bool get _isMultiline => (widget.maxLines ?? 1) > 1;

  String? get _activeError =>
      _validationError ??
          (widget.errorText != null && widget.errorText!.isNotEmpty
              ? widget.errorText
              : null);

  TextStyle get _textStyle => widget.fontFamily != null
      ? TextStyle(
    fontFamily: widget.fontFamily,
    fontSize: (widget.fontSize ?? 13).sp,
    fontWeight: FontWeight.w400,
    color: widget.textColor ?? const Color(0XFFAEAEAE),
  )
      : GoogleFonts.beVietnamPro(
    fontSize: (widget.fontSize ?? 13).sp,
    fontWeight: FontWeight.w400,
    color: widget.textColor ?? const Color(0XFFAEAEAE),
  );

  TextStyle get _hintStyle => widget.fontFamily != null
      ? TextStyle(
    fontFamily: widget.fontFamily,
    fontSize: (widget.fontSize ?? 13).sp,
    fontWeight: FontWeight.w400,
    color: widget.hintTextColor ?? const Color(0XFFAEAEAE),
  )
      : GoogleFonts.poppins(
    fontSize: (widget.fontSize ?? 13).sp,
    fontWeight: FontWeight.w400,
    color: widget.hintTextColor ?? const Color(0XFFAEAEAE),
  );

  // ── Icons ─────────────────────────────────────────────────────────────────

  Widget? _buildPrefixIcon() {
    if (widget.prefixAssetIcon != null) {
      return GestureDetector(
        onTap: widget.onPrefixAssetTap,
        child: Padding(
          padding: EdgeInsets.only(left: 14.w, right: 10.w),
          child: Image.asset(
            widget.prefixAssetIcon!,
            width: widget.prefixAssetIconSize ?? 18.w,
            height: widget.prefixAssetIconSize ?? 18.w,
            fit: BoxFit.contain,
            color: widget.prefixAssetIconColor,
          ),
        ),
      );
    }

    if (widget.prefixIcon != null) {
      return GestureDetector(
        onTap: widget.onPrefixTap,
        child: Padding(
          padding: EdgeInsets.only(left: 14.w, right: 10.w),
          child: Icon(
            widget.prefixIcon,
            size: 20.sp,
            color: widget.prefixIconColor ?? const Color(0XFF4A4A4A),
          ),
        ),
      );
    }

    return null;
  }

  Widget? _buildSuffixIcon() {
    if (widget.showObscure) {
      return Padding(
        padding: EdgeInsets.only(right: 14.w),
        child: GestureDetector(
          onTap: () => setState(() => _obscureText = !_obscureText),
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            size: 20.sp,
            color: widget.obscureIconColor ?? AppColors.textColor,
          ),
        ),
      );
    }

    if (widget.postfixAssetIcon != null) {
      return Padding(
        padding: EdgeInsets.only(right: 14.w),
        child: GestureDetector(
          onTap: widget.onPostfixAssetTap,
          child: Image.asset(
            widget.postfixAssetIcon!,
            width: widget.postfixAssetIconSize ?? 18.w,
            height: widget.postfixAssetIconSize ?? 18.w,
            color: widget.postfixAssetIconColor,
          ),
        ),
      );
    }

    if (widget.postfixIcon != null) {
      return Padding(
        padding: EdgeInsets.only(right: 14.w),
        child: GestureDetector(
          onTap: widget.onPostfixTap,
          child: Icon(
            widget.postfixIcon,
            size: 20.sp,
            color: widget.postfixIconColor ?? AppColors.textColor,
          ),
        ),
      );
    }

    return null;
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (widget.validator == null) {
      return _buildContent(errorOverride: null);
    }

    return FormField<String>(
      initialValue: widget.controller?.text ?? '',
      validator: (_) => widget.validator!(widget.controller?.text ?? ''),
      builder: (FormFieldState<String> field) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _validationError != field.errorText) {
            setState(() => _validationError = field.errorText);
          }
        });

        return _buildContent(errorOverride: field.errorText);
      },
    );
  }

  Widget _buildContent({required String? errorOverride}) {
    final displayError = errorOverride ??
        (widget.errorText != null && widget.errorText!.isNotEmpty
            ? widget.errorText
            : null);
    final showError = displayError != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // multiline → height grows with content; single line → fixed height
          height: _isMultiline ? null : (widget.height ?? 45.h),
          // multiline → hint aligns top; single line → vertically centered
          alignment: _isMultiline ? Alignment.topLeft : Alignment.center,
          decoration: BoxDecoration(
            color: widget.fillColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              width: 0.5,
              color: showError
                  ? Colors.red
                  : widget.borderColor ?? const Color(0XFFE6E6E6),
            ),
          ),
          child: TextField(
            controller: widget.controller,
            readOnly: widget.readOnly ?? false,
            obscureText: widget.showObscure ? _obscureText : false,
            keyboardType: _isMultiline
                ? TextInputType.multiline
                : (widget.keyboardType ?? TextInputType.text),
            cursorColor: widget.cursorColor ?? AppColors.textColor,
            // respect maxLines; null = unlimited growth
            maxLines: widget.showObscure ? 1 : (widget.maxLines ?? 1),
            minLines: _isMultiline ? (widget.maxLines ?? 1) : null,
            onChanged: (value) {
              widget.onChanged?.call(value);
              if (widget.validator != null) setState(() {});
            },
            style: _textStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
              contentPadding: EdgeInsets.only(
                left: widget.textLeftPadding ?? 0,
                right: 14.w,
                // multiline → top padding so text doesn't hug the border
                top: _isMultiline ? 12.h : 0,
                bottom: _isMultiline ? 12.h : 0,
              ),
              prefixIcon: _buildPrefixIcon(),
              suffixIcon: _buildSuffixIcon(),
              hintText: widget.hintText,
              hintStyle: _hintStyle,
            ),
          ),
        ),
        if (showError) ...[
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 13.sp),
              SizedBox(width: 4.w),
              Text(
                displayError!,
                style: GoogleFonts.lato(
                  fontSize: 11.sp,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}