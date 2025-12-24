import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_text_styles.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/utils/app_routes.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';

/// Profile/Menu Screen
/// Shows user profile with menu options and logout confirmation sheet
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopBar(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
              child: Column(
                children: [
                  SizedBox(height: 10.h(context)),
                  _buildProfileInfo(context),
                  SizedBox(height: 32.h(context)),
                  _buildMenuSection(context, [
                    _MenuItem(
                      icon: Icons.person_outline,
                      iconColor: AppColors.primary,
                      title: loc.personalInfo,
                      onTap: () =>
                          Navigator.pushNamed(context, '/personal-info'),
                    ),
                    _MenuItem(
                      icon: Icons.location_on_outlined,
                      iconColor: AppColors.accentIndigo,
                      title: loc.addresses,
                      onTap: () => Navigator.pushNamed(context, '/address'),
                    ),
                  ]),
                  SizedBox(height: 20.h(context)),
                  _buildMenuSection(context, [
                    _MenuItem(
                      icon: Icons.receipt_long_outlined,
                      iconColor: AppColors.primary,
                      title: loc.myOrders,
                      onTap: () => Navigator.pushNamed(context, '/my-orders'),
                    ),
                    _MenuItem(
                      icon: Icons.shopping_bag_outlined,
                      iconColor: AppColors.accentBlue,
                      title: loc.cart,
                      onTap: () => Navigator.pushNamed(context, '/cart'),
                    ),
                    _MenuItem(
                      icon: Icons.favorite_border,
                      iconColor: AppColors.accentRed,
                      title: loc.favourite,
                      onTap: () => Navigator.pushNamed(context, '/favorites'),
                    ),
                    _MenuItem(
                      icon: Icons.notifications_outlined,
                      iconColor: AppColors.accentYellow,
                      title: loc.notifications,
                      onTap: () =>
                          Navigator.pushNamed(context, '/notifications'),
                    ),
                    _MenuItem(
                      icon: Icons.credit_card_outlined,
                      iconColor: AppColors.accentBlue,
                      title: loc.paymentMethod,
                      onTap: () => Navigator.pushNamed(context, '/payment'),
                    ),
                  ]),
                  SizedBox(height: 20.h(context)),
                  _buildMenuSection(context, [
                    _MenuItem(
                      icon: Icons.help_outline,
                      iconColor: AppColors.primary,
                      title: loc.faqs,
                      onTap: () => Navigator.pushNamed(context, '/support'),
                    ),
                    _MenuItem(
                      icon: Icons.star_border,
                      iconColor: AppColors.accentBlue,
                      title: loc.userReviews,
                      onTap: () =>
                          Navigator.pushNamed(context, '/user-reviews'),
                    ),
                    _MenuItem(
                      icon: Icons.settings_outlined,
                      iconColor: AppColors.accentPurple,
                      title: loc.settings,
                      onTap: () => Navigator.pushNamed(context, '/settings'),
                    ),
                  ]),
                  SizedBox(height: 20.h(context)),
                  _buildMenuSection(context, [
                    _MenuItem(
                      icon: Icons.logout,
                      iconColor: AppColors.primary,
                      title: 'Log Out',
                      onTap: () => _showLogoutSheet(context),
                    ),
                  ]),
                  SizedBox(height: 40.h(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: 109.h(context),
      color: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 45.w(context),
                  height: 45.w(context),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceF5,
                    borderRadius: BorderRadius.circular(14.w(context)),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 20.w(context),
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(width: 16.w(context)),
              Text(
                'Profile',
                style: AppTextStyles.titleMedium.copyWith(
                  fontSize: 17.w(context),
                  color: AppColors.textPrimary,
                  height: 22 / 17,
                ),
              ),
              const Spacer(),
              Container(
                width: 45.w(context),
                height: 45.w(context),
                decoration: BoxDecoration(
                  color: AppColors.surfaceF5,
                  borderRadius: BorderRadius.circular(14.w(context)),
                ),
                child: Icon(
                  Icons.more_horiz,
                  size: 24.w(context),
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final user = authProvider.user;
        final name = user?.name ?? 'User';
        final photoUrl = user?.photoUrl ?? AppData.defaultProfileImage;

        return Row(
          children: [
            CustomNetworkImage(
              imageUrl: photoUrl,
              width: 100.w(context),
              height: 100.h(context),
              borderRadius: 100.w(context), // Circle
              fit: BoxFit.cover,
            ),
            SizedBox(width: 32.w(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.headlineSmall.copyWith(
                      fontSize: 20.w(context),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h(context)),
                  Text(
                    user?.bio ?? 'I love fast food',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 14.w(context),
                      color: AppColors.textHint,
                      height: 24 / 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenuSection(BuildContext context, List<_MenuItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceF8FA,
        borderRadius: BorderRadius.circular(16.w(context)),
      ),
      child: Column(
        children: List.generate(
          items.length,
          (index) => Column(
            children: [
              _buildMenuItem(context, items[index]),
              if (index < items.length - 1)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
                  child: Divider(
                    height: 1,
                    color: AppColors.white.withValues(alpha: 0.5),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, _MenuItem item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        height: 56.h(context),
        padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
        child: Row(
          children: [
            Container(
              width: 40.w(context),
              height: 40.h(context),
              decoration: BoxDecoration(
                color: item.iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.w(context)),
              ),
              child: Icon(
                item.icon,
                size: 20.w(context),
                color: item.iconColor,
              ),
            ),
            SizedBox(width: 14.w(context)),
            Expanded(
              child: Text(
                item.title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 16.w(context),
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.w(context),
              color: AppColors.textPrimary,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.w(context)),
        ),
      ),
      isScrollControlled: true,
      builder: (sheetContext) {
        final bottomPadding = MediaQuery.of(sheetContext).padding.bottom;
        return Padding(
          padding: EdgeInsets.fromLTRB(
            24.w(context),
            16.h(context),
            24.w(context),
            16.h(context) + bottomPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50.w(context),
                height: 4.h(context),
                decoration: BoxDecoration(
                  color: AppColors.handleGray,
                  borderRadius: BorderRadius.circular(2.w(context)),
                ),
              ),
              SizedBox(height: 24.h(context)),
              Container(
                width: 72.w(context),
                height: 72.w(context),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout,
                  color: AppColors.primary,
                  size: 32.w(context),
                ),
              ),
              SizedBox(height: 20.h(context)),
              Text(
                'Log out?',
                style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: 20.w(context),
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 12.h(context)),
              Text(
                'Are you sure you want to log out?',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 14.w(context),
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24.h(context)),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(sheetContext);
                    final authProvider = Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    );
                    await authProvider.signOut();
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.login,
                        (route) => false,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.w(context)),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h(context)),
                  ),
                  child: Text(
                    'Yes, log out',
                    style: AppTextStyles.button.copyWith(
                      fontSize: 16.w(context),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h(context)),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.w(context)),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h(context)),
                  ),
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.button.copyWith(
                      fontSize: 16.w(context),
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h(context)),
            ],
          ),
        );
      },
    );
  }
}

class _MenuItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  _MenuItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });
}
