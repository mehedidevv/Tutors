import 'package:care_tutors/core/utils/customSize.dart';
import 'package:care_tutors/core/widget/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../addNotesView/model/noteModel.dart';

class NoteWidget extends StatelessWidget {
  final NoteModel note;
  final VoidCallback? onTap;

  const NoteWidget({super.key, required this.note, this.onTap});

  Color get _noteColor {
    final colors = [
      const Color(0xFF1565C0),
      const Color(0xFF2E7D32),
      const Color(0xFFE65100),
      const Color(0xFF6A1B9A),
      const Color(0xFF00838F),
      const Color(0xFFC62828),
    ];
    return colors[note.id.hashCode % colors.length];
  }

  @override
  Widget build(BuildContext context) {
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
                  color: _noteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    bottomLeft: Radius.circular(16.r),
                  ),
                ),
              ),

              /// Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: note.title,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A2E),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),

                      heightBox8,

                      CustomText(
                        text: note.description,
                        fontSize: 12.sp,
                        color: const Color(0xFF666666),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),

                      heightBox8,
                      Text(
                        _formatDate(note.createdAt),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: const Color(0xFFAAAAAA),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Arrow ──
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}