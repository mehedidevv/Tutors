import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/appColors.dart';
import '../../../../core/utils/customSize.dart';
import '../../../../core/widget/customButton.dart';
import '../../../../core/widget/customText.dart';
import '../../../../core/widget/customTextField.dart';
import '../repository/noteRepository.dart';

class AddNoteBottomSheetWidget extends StatefulWidget {
  const AddNoteBottomSheetWidget({super.key});

  @override
  State<AddNoteBottomSheetWidget> createState() =>
      _AddNoteBottomSheetWidgetState();
}

class _AddNoteBottomSheetWidgetState extends State<AddNoteBottomSheetWidget> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _noteRepository = NoteRepository();

  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _addNote() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _noteRepository.addNote(
        title: _titleController.text,
        description: _descriptionController.text,
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add note: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16, // keyboard handle
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Drag handle + close ──
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
            Divider(color: const Color(0xFFE6E6E6), height: 12.h),
            heightBox5,

            // ── Scrollable content ──
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    CustomText(
                      text: "Note Title",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF4F4F4F),
                    ),
                    heightBox10,
                    CustomTextField(
                      controller: _titleController,
                      textLeftPadding: 10,
                      hintText: 'Enter Note Title',
                      textColor: Colors.black,
                      maxLines: 2,
                      showObscure: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a title';
                        }
                        if (value.trim().length < 3) {
                          return 'Title must be at least 3 characters';
                        }
                        return null;
                      },
                    ),

                    heightBox20,

                    // Description
                    CustomText(
                      text: "Note Description",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF4F4F4F),
                    ),
                    heightBox10,
                    CustomTextField(
                      controller: _descriptionController,
                      textLeftPadding: 10,
                      hintText: 'Enter Note Description',
                      textColor: Colors.black,
                      maxLines: 6,
                      showObscure: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a description';
                        }
                        if (value.trim().length < 5) {
                          return 'Description must be at least 5 characters';
                        }
                        return null;
                      },
                    ),

                    heightBox30,

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: CustomButtonWidget(
                            btnText: 'Cancel',
                            btnColor: Colors.transparent,
                            borderColor: AppColors.mainColor,
                            btnTextColor: AppColors.mainColor,
                            onTap: () => Navigator.pop(context),
                          ),
                        ),
                        widthBox20,
                        Expanded(
                          child: CustomButtonWidget(
                            btnText: 'Add Note',
                            isLoading: _isLoading,
                            onTap: _addNote,
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
      ),
    );
  }
}