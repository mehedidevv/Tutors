import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../features/authView/controller/authController.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  final searchController = TextEditingController();

  final RxString searchQuery = ''.obs;
  final RxList<Map<String, String>> filteredNotes = <Map<String, String>>[].obs;
  final List<Map<String, String>> allNotes = [
    {
      'title': 'Mathematics - Chapter 5',
      'description':
      'Quadratic equations and their real-world applications. Practice problems included for exam preparation.',
      'color': '0xFFE8F0FE',
    },
    {
      'title': 'Physics - Optics',
      'description':
      'Reflection, refraction, and the laws of light. Diagrams for concave and convex lenses.',
      'color': '0xFFE8F5E9',
    },
    {
      'title': 'English Literature',
      'description':
      'Analysis of Shakespeare\'s Hamlet. Key themes: revenge, madness, moral corruption.',
      'color': '0xFFFFF3E0',
    },
    {
      'title': 'Chemistry - Periodic Table',
      'description':
      'Groups and periods explained. Electronegativity trends and ionization energy concepts.',
      'color': '0xFFFCE4EC',
    },
    {
      'title': 'History - World War II',
      'description':
      'Major events from 1939–1945. Causes, key battles, and aftermath of the war.',
      'color': '0xFFEDE7F6',
    },
    {
      'title': 'Biology - Cell Division',
      'description':
      'Mitosis and meiosis explained with diagrams. Differences and biological significance.',
      'color': '0xFFE0F7FA',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    filteredNotes.assignAll(allNotes);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

///Get User Info
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

///Serach Logic
  void onSearch(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredNotes.assignAll(allNotes);
      return;
    }
    filteredNotes.assignAll(
      allNotes.where((note) {
        final title = note['title']!.toLowerCase();
        final desc = note['description']!.toLowerCase();
        return title.contains(query.toLowerCase()) ||
            desc.contains(query.toLowerCase());
      }).toList(),
    );
  }

  void clearSearch() {
    searchController.clear();
    onSearch('');
  }

  void showLogoutDialog(BuildContext context) {
    _authController.signOut(context);
  }
}