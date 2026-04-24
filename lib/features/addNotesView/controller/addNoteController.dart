// // lib/features/notes/controller/addNoteController.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../repository/noteRepository.dart';
//
// class AddNoteController extends GetxController {
//   final _noteRepository = NoteRepository();
//
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//
//   final isLoading = false.obs;
//
//   @override
//   void onClose() {
//     titleController.dispose();
//     descriptionController.dispose();
//     super.onClose();
//   }
//
//   Future<void> addNote(BuildContext context) async {
//     if (!formKey.currentState!.validate()) return;
//
//     isLoading.value = true;
//
//     try {
//       await _noteRepository.addNote(
//         title: titleController.text,
//         description: descriptionController.text,
//       );
//
//       // SnackBar আগে, তারপর close
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Note added successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//
//       Get.back();
//
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to add note: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }