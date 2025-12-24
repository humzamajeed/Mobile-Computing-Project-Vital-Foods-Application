import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';

/// Personal Info Screen
/// Design: Figma node-id=226-318
/// Shows user's personal information (name, email, phone)
class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top bar
          Container(
            height: 109.h(context),
            color: Colors.white,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                child: Row(
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 45.w(context),
                        height: 45.w(context),
                        decoration: BoxDecoration(
                          color: AppColors.neutralECF0,
                          borderRadius: BorderRadius.circular(14.w(context)),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20.w(context),
                          color: AppColors.textPrimaryDeep,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w(context)),
                    Text(
                      AppLocalizations.of(context)!.personalInfo,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 17.w(context),
                        color: AppColors.textPrimaryDeep,
                        height: 22 / 17,
                      ),
                    ),
                    const Spacer(),
                    // Edit button
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/edit-profile');
                      },
                      child: Text(
                        AppLocalizations.of(context)!.edit.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 14.w(context),
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                          height: 24 / 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Profile info
          Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              final user = authProvider.user;
              final name = user?.name ?? 'User';
              final email = user?.email ?? '';
              final phoneNumber = user?.phoneNumber ?? 'Not set';
              final photoUrl = user?.photoUrl ?? AppData.defaultProfileImage;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                child: Column(
                  children: [
                    SizedBox(height: 10.h(context)),
                    Row(
                      children: [
                        // Profile picture
                        CustomNetworkImage(
                          imageUrl: photoUrl,
                          width: 100.w(context),
                          height: 100.h(context),
                          borderRadius: 100.w(context),
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 32.w(context)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontFamily: 'Sen',
                                  fontSize: 20.w(context),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimaryDeep,
                                ),
                              ),
                              SizedBox(height: 8.h(context)),
                              Text(
                                user?.bio ?? 'I love fast food',
                                style: TextStyle(
                                  fontFamily: 'Sen',
                                  fontSize: 14.w(context),
                                  color: AppColors.textHint,
                                  height: 24 / 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h(context)),

                    // Personal Info Card
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceF8FA,
                        borderRadius: BorderRadius.circular(16.w(context)),
                      ),
                      child: Column(
                        children: [
                          // Full Name
                          _buildInfoItem(
                            context,
                            icon: Icons.person_outline,
                            iconColor: AppColors.primary,
                            label: loc.fullName.toUpperCase(),
                            value: name,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w(context),
                            ),
                            child: Divider(
                              height: 1,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),

                          // Email
                          _buildInfoItem(
                            context,
                            icon: Icons.email_outlined,
                            iconColor: AppColors.accentIndigo,
                            label: loc.email.toUpperCase(),
                            value: email,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w(context),
                            ),
                            child: Divider(
                              height: 1,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),

                          // Phone Number
                          _buildInfoItem(
                            context,
                            icon: Icons.phone_outlined,
                            iconColor: AppColors.accentBlue,
                            label: loc.phoneNumber.toUpperCase(),
                            value: phoneNumber,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      height: 56.h(context),
      padding: EdgeInsets.symmetric(horizontal: 20.w(context)),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40.w(context),
            height: 40.h(context),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.w(context)),
            ),
            child: Icon(icon, size: 20.w(context), color: iconColor),
          ),
          SizedBox(width: 14.w(context)),
          // Label and Value
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 14.w(context),
                    color: AppColors.textDark,
                    height: 1.0,
                  ),
                ),
                SizedBox(height: 4.h(context)),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 14.w(context),
                    color: AppColors.mutedGrayDeep,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
