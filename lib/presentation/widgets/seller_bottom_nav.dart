import 'package:flutter/material.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/utils/app_routes.dart';

class SellerBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const SellerBottomNavBar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0: // Home
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.sellerDashboard,
          (route) => false,
        );
        break;
      case 1: // Menu
        Navigator.pushNamed(context, AppRoutes.myFoodList);
        break;
      case 2: // Add
        Navigator.pushNamed(context, AppRoutes.addNewFood);
        break;
      case 3: // Notif
        Navigator.pushNamed(context, AppRoutes.sellerNotifications);
        break;
      case 4: // Profile
        Navigator.pushNamed(context, AppRoutes.sellerProfile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 22.w(context),
        vertical: 12.h(context),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavIcon(
            icon: Icons.grid_view_rounded,
            active: currentIndex == 0,
            onTap: () => _onTap(context, 0),
          ),
          _NavIcon(
            icon: Icons.menu_rounded,
            active: currentIndex == 1,
            onTap: () => _onTap(context, 1),
          ),
          _CenterAction(onTap: () => _onTap(context, 2)),
          _NavIcon(
            icon: Icons.notifications_none_rounded,
            active: currentIndex == 3,
            onTap: () => _onTap(context, 3),
          ),
          _NavIcon(
            icon: Icons.person_outline_rounded,
            active: currentIndex == 4,
            onTap: () => _onTap(context, 4),
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    this.active = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : AppColors.textHint;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w(context),
        height: 44.w(context),
        decoration: BoxDecoration(
          color: active
              ? AppColors.primary.withValues(alpha: 0.08)
              : AppColors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 22.w(context)),
      ),
    );
  }
}

class _CenterAction extends StatelessWidget {
  final VoidCallback onTap;

  const _CenterAction({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54.w(context),
        height: 54.w(context),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 2),
          color: AppColors.white,
        ),
        child: Icon(Icons.add, color: AppColors.primary, size: 26.w(context)),
      ),
    );
  }
}
