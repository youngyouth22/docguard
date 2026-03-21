import 'package:docguard/common/app_colors.dart';
import 'package:docguard/common/app_typography.dart';
import 'package:docguard/common/image_resources.dart';
import 'package:docguard/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:docguard/features/auth/presentation/screens/files_view.dart';
import 'package:docguard/features/auth/presentation/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:docguard/features/sync/presentation/widgets/sync_progress_bar.dart';

import '../widgets/floating_scanner_button.dart';
import '../widgets/logout_dialog.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  final List<Widget> _pages = [const HomeView(), const FilesView()];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onBottomNavTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary400,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.white,
        ),
        centerTitle: false,
        title: Text(
          'DocGuard',
          style: AppTypography.h4Bold.copyWith(color: AppColors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
            onPressed: () {
              LogoutDialog.show(
                context,
                onLogout: () {
                  context.read<AuthBloc>().add(
                    const AuthEvent.logoutRequested(),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: const FloatingScannerButton(),
      body: Column(
        children: [
          const SyncProgressBar(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: _pages,
            ),
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _scanDocument,
      //   shape: CircleBorder(),
      //   backgroundColor: AppColors.primary400,
      //   foregroundColor: AppColors.white,
      //   elevation: 0,
      //   child: SvgPicture.asset(
      //     ImageResources.scanCheckSelect,
      //     colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
      //   ),
      // ),
      bottomNavigationBar: BottomAppBar(
        // notchMargin: 5.0,
        elevation: 50,
        height: 70,
        shadowColor: AppColors.grey800,
        // shape: const CircularNotchedRectangle(),
        color: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              0,
              ImageResources.homeOutline,
              ImageResources.homeBold,
              "Home",
            ),
            // const SizedBox(width: 40),
            _buildNavItem(
              1,
              ImageResources.folderOutline,
              ImageResources.folderBold,
              "Files",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String iconPath,
    String iconPathSelected,
    String label,
  ) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onBottomNavTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isSelected ? iconPathSelected : iconPath,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.primary400 : AppColors.grey400,
              BlendMode.srcIn,
            ),
            height: 24,
            width: 24,
          ),
          Text(
            label,
            style: AppTypography.bodySMedium.copyWith(
              color: isSelected ? AppColors.primary400 : AppColors.grey400,
            ),
          ),
        ],
      ),
    );
  }
}
