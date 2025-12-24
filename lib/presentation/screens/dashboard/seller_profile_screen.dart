import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_text_styles.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/utils/app_routes.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';

/// Seller Profile/Menu Screen (Figma node 601-1778)
class SellerProfileScreen extends StatelessWidget {
  const SellerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w(context),
                vertical: 16.h(context),
              ),
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.person_outline,
                  iconColor: AppColors.primary,
                  title: 'Personal Info',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.personalInfo),
                ),
                SizedBox(height: 12.h(context)),
                _buildMenuItem(
                  context,
                  icon: Icons.settings_outlined,
                  iconColor: AppColors.accentIndigo,
                  title: 'Settings',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
                ),
                SizedBox(height: 12.h(context)),
                _buildMenuItem(
                  context,
                  icon: Icons.history_outlined,
                  iconColor: AppColors.primary,
                  title: 'Withdrawal History',
                  onTap: () {},
                ),
                SizedBox(height: 12.h(context)),
                _buildMenuItem(
                  context,
                  icon: Icons.receipt_long_outlined,
                  iconColor: AppColors.accentBlue,
                  title: 'Number of Orders',
                  trailing: '29K',
                  onTap: () {},
                ),
                SizedBox(height: 12.h(context)),
                _buildMenuItem(
                  context,
                  icon: Icons.star_border_rounded,
                  iconColor: AppColors.accentBlue,
                  title: 'User Reviews',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.sellerReviews),
                ),
                SizedBox(height: 12.h(context)),
                _buildMenuItem(
                  context,
                  icon: Icons.logout,
                  iconColor: AppColors.error,
                  title: 'Log Out',
                  onTap: () async {
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.w(context)),
          bottomRight: Radius.circular(24.w(context)),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w(context),
            vertical: 20.h(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40.w(context),
                      height: 40.w(context),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18.w(context),
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w(context)),
                  Text(
                    'My Profile',
                    style: AppTextStyles.titleLarge.copyWith(
                      fontSize: 18.sp(context),
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h(context)),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Available Balance',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 14.sp(context),
                        color: AppColors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    SizedBox(height: 8.h(context)),
                    Text(
                      '\$500.00',
                      style: AppTextStyles.headlineLarge.copyWith(
                        fontSize: 36.sp(context),
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.h(context)),
                    OutlinedButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRoutes.withdrawSuccess,
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.white, width: 2),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w(context),
                          vertical: 10.h(context),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.w(context)),
                        ),
                      ),
                      child: Text(
                        'Withdraw',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 14.sp(context),
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    String? trailing,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w(context),
          vertical: 14.h(context),
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.w(context)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40.w(context),
              height: 40.w(context),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.w(context)),
              ),
              child: Icon(icon, size: 22.w(context), color: iconColor),
            ),
            SizedBox(width: 14.w(context)),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 15.sp(context),
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (trailing != null)
              Text(
                trailing,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 14.sp(context),
                  color: AppColors.textHint,
                  fontWeight: FontWeight.w600,
                ),
              )
            else
              Icon(
                Icons.chevron_right_rounded,
                size: 24.w(context),
                color: AppColors.textHint,
              ),
          ],
        ),
      ),
    );
  }
}
