import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../features/authView/controller/authController.dart';
import '../../addNotesView/repository/noteRepository.dart';
import '../../addNotesView/model/noteModel.dart';

class HomeController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  final NoteRepository _noteRepository = NoteRepository();
  final searchController = TextEditingController();

  final RxString searchQuery = ''.obs;
  final RxList<NoteModel> allNotes = <NoteModel>[].obs;
  final RxList<NoteModel> filteredNotes = <NoteModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  /// Fetch Note Form Fire Store
  Future<void> fetchNotes() async {
    isLoading.value = true;
    try {
      final notes = await _noteRepository.getNotes();
      allNotes.assignAll(notes);
      filteredNotes.assignAll(notes);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch notes: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Get User Info
  String get userName {
    final user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? user?.email?.split('@').first ?? 'User';
  }

  String get userInitials {
    final name = userName;
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : 'U';
  }

  /// Search Logic
  void onSearch(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredNotes.assignAll(allNotes);
      return;
    }
    filteredNotes.assignAll(
      allNotes.where((note) {
        final title = note.title.toLowerCase();
        final desc = note.description.toLowerCase();
        return title.contains(query.toLowerCase()) ||
            desc.contains(query.toLowerCase());
      }).toList(),
    );
  }

  void clearSearch() {
    searchController.clear();
    onSearch('');
  }

  /// Log Out
  void showLogoutDialog(BuildContext context) {
    _authController.signOut(context);
  }
}