import 'package:care_tutors/core/widget/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/appColors.dart';
import '../../../core/utils/customSize.dart';
import '../../../core/widget/customButton.dart';
import '../../../core/widget/customText.dart';

class AddNoteBottomSheetWidget extends StatefulWidget {
  const AddNoteBottomSheetWidget({super.key});

  @override
  State<AddNoteBottomSheetWidget> createState() =>
      _AddNoteBottomSheetWidgetState();
}

class _AddNoteBottomSheetWidgetState extends State<AddNoteBottomSheetWidget> {



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 24),
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          CustomText(
            text: "Add Note",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),

          heightBox5,

          Divider(
            color: const Color(0xFFE6E6E6),
            height: 12.h,
          ),

          heightBox5,

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Note Title",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4F4F4F),
                  ),

                  heightBox10,

                  CustomTextField(
                    textLeftPadding: 10,
                      hintText: 'Enter Note Title',
                      maxLines: 2,
                      showObscure: false
                  ),


                  heightBox20,

                  CustomText(
                    text: "Note Description",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4F4F4F),
                  ),

                  heightBox10,

                  CustomTextField(
                      textLeftPadding: 10,
                      hintText: 'Enter Note Description',
                      maxLines: 6,
                      showObscure: false
                  ),


                  heightBox30,

                  Row(
                    children: [
                      Expanded(
                        child: CustomButtonWidget(
                            btnText: 'Cancel',
                            btnColor: Colors.transparent,
                            borderColor: AppColors.mainColor,
                            btnTextColor: AppColors.mainColor,
                            onTap: (){}
                        ),
                      ),


                      widthBox20,


                      Expanded(
                        child: CustomButtonWidget(
                            btnText: 'Add Note',
                            onTap: (){}
                        ),
                      ),
                    ],
                  ),

                  heightBox30,
                ],
              ),
            ),
          ),





        ],
      ),
    );
  }
}