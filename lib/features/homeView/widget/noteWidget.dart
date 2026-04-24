import 'package:care_tutors/core/utils/customSize.dart';
import 'package:care_tutors/core/widget/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteWidget extends StatelessWidget {
  final Map<String, String> note;
  final VoidCallback? onTap;

  const NoteWidget({super.key, required this.note, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bgColor = Color(int.parse(note['color']!));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 5.w,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    bottomLeft: Radius.circular(16.r),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                          Expanded(
                            child: CustomText(
                              text: note['title']!,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1A2E),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                      ),
                      heightBox8,

                      // Description
                      CustomText(
                        text: note['description']!,
                        fontSize: 12.sp,
                        color: const Color(0xFF666666),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),

              // ── Arrow Icon ────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14.sp,
                  color: const Color(0xFFCCCCCC),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
