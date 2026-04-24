import 'package:care_tutors/core/widget/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../addNotesView/view/addNoteBottomSheetWidget.dart';
import '../controller/homeController.dart';
import '../widget/noteWidget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, controller),
            _buildSearchBar(controller),
            _buildSectionTitle(controller),
            _buildNotesList(controller),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

///Header Design
  Widget _buildHeader(BuildContext context, HomeController controller) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
      decoration: const BoxDecoration(
        color: Color(0xFF1565C0),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46.w,
            height: 46.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                controller.userInitials,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${controller.userName} 👋',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Ready to learn today?',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),

          // Logout Button
          GestureDetector(
            onTap: () => _showLogoutDialog(context, controller),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Search Bar
  Widget _buildSearchBar(HomeController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1565C0).withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Obx(
              () => TextField(
            controller: controller.searchController,
            onChanged: controller.onSearch,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              color: const Color(0xFF1A1A2E),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14.h),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: const Color(0xFF1565C0),
                size: 20.sp,
              ),
              hintText: 'Search notes...',
              hintStyle: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: const Color(0xFFAAAAAA),
              ),
              suffixIcon: controller.searchQuery.value.isNotEmpty
                  ? GestureDetector(
                onTap: controller.clearSearch,
                child: Icon(
                  Icons.close_rounded,
                  size: 18.sp,
                  color: Colors.grey,
                ),
              )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  ///My Notes
  Widget _buildSectionTitle(HomeController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
      child: Obx(
            () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.searchQuery.value.isEmpty
                  ? 'My Notes'
                  : 'Results (${controller.filteredNotes.length})',
              style: GoogleFonts.poppins(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A2E),
              ),
            ),
            Text(
              '${controller.filteredNotes.length} notes',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: const Color(0xFF888888),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Notes List
  Widget _buildNotesList(HomeController controller) {
    return Expanded(
      child: Obx(() {
        if (controller.filteredNotes.isEmpty) {
          return _buildEmptyState();
        }
        return ListView.builder(
          padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 100.h),
          physics: const BouncingScrollPhysics(),
          itemCount: controller.filteredNotes.length,
          itemBuilder: (context, index) => NoteWidget(
            note: controller.filteredNotes[index],
            onTap: () {
              ///
            },
          ),
        );
      }),
    );
  }

  /// Empty State
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48.sp,
            color: const Color(0xFFCCCCCC),
          ),
          SizedBox(height: 12.h),
          CustomText(
           text:  'No notes found',
              fontSize: 14.sp,
              color: const Color(0xFFAAAAAA),
          ),
        ],
      ),
    );
  }

  /// FAB  Icon Add Note
  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.7,
              child: const AddNoteBottomSheetWidget(),
            );
          },
        );
      },
      backgroundColor: const Color(0xFF1565C0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Icon(Icons.add_rounded, color: Colors.white, size: 28.sp),
    );
  }

  ///Logout Dialog
  void _showLogoutDialog(BuildContext context, HomeController controller) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: CustomText(
         text:  'Log Out',
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
        ),
        content: CustomText(
         text:  'Are you sure you want to log out?',
            fontSize: 13.sp,
            color: const Color(0xFF666666),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: const Color(0xFF888888),
                fontSize: 13.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              controller.showLogoutDialog(context);
            },
            child: Text(
              'Log Out',
              style: GoogleFonts.poppins(
                color: const Color(0xFF1565C0),
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}