import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/app_routes.dart';
import '../../providers/settings_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/locale_provider.dart';

/// Settings Screen
/// Design: Figma node-id=149:1165
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    // Load settings when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SettingsProvider>(context, listen: false).loadSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(loc.settings)),
      body: Consumer2<SettingsProvider, LocaleProvider>(
        builder: (context, settingsProvider, localeProvider, child) {
          final settings = settingsProvider.settings;
          final isLoading = settingsProvider.isLoading;

          if (isLoading && settings == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(AppDimensions.paddingXL),
            children: [
              // Account Section
              Text(loc.account, style: AppTextStyles.titleMedium),
              const SizedBox(height: AppDimensions.space),

              _buildSettingsItem(
                icon: Icons.person_rounded,
                title: loc.editProfile,
                subtitle: loc.personalInfo,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.editProfile);
                },
              ),
              _buildSettingsItem(
                icon: Icons.lock_rounded,
                title: loc.changePassword,
                subtitle: loc.updateYourPassword,
                onTap: () {
                  _showChangePasswordDialog(context, settingsProvider, loc);
                },
              ),
              _buildSettingsItem(
                icon: Icons.payment_rounded,
                title: loc.paymentMethod,
                subtitle: loc.managePaymentOptions,
                onTap: () {},
              ),

              const SizedBox(height: AppDimensions.spaceXL),

              // Preferences Section
              Text(loc.preferences, style: AppTextStyles.titleMedium),
              const SizedBox(height: AppDimensions.space),

              _buildSwitchItem(
                icon: Icons.notifications_rounded,
                title: loc.notifications,
                subtitle: loc.enablePushNotifications,
                value: settings?.notificationsEnabled ?? true,
                onChanged: (value) {
                  settingsProvider.updateNotifications(value);
                },
              ),
              _buildSwitchItem(
                icon: Icons.location_on_rounded,
                title: loc.locationServices,
                subtitle: loc.allowLocationAccess,
                value: settings?.locationEnabled ?? true,
                onChanged: (value) {
                  settingsProvider.updateLocation(value);
                },
              ),
              _buildSwitchItem(
                icon: Icons.dark_mode_rounded,
                title: loc.darkMode,
                subtitle: loc.switchToDarkTheme,
                value: settings?.darkModeEnabled ?? false,
                onChanged: (value) {
                  settingsProvider.updateDarkMode(value);
                },
              ),
              _buildSettingsItem(
                icon: Icons.language_rounded,
                title: loc.language,
                subtitle: localeProvider.getLocaleDisplayName(
                  localeProvider.locale,
                ),
                onTap: () {
                  _showLanguageSelectionDialog(context, localeProvider, loc);
                },
                trailing: const Icon(Icons.chevron_right_rounded),
              ),

              const SizedBox(height: AppDimensions.spaceXL),

              // Support Section
              Text(loc.support, style: AppTextStyles.titleMedium),
              const SizedBox(height: AppDimensions.space),

              _buildSettingsItem(
                icon: Icons.help_rounded,
                title: loc.helpCenter,
                subtitle: loc.getHelpAndSupport,
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.feedback_rounded,
                title: loc.sendFeedback,
                subtitle: loc.shareYourThoughts,
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.star_rounded,
                title: loc.rateUs,
                subtitle: loc.rateUsOnAppStore,
                onTap: () {},
              ),

              const SizedBox(height: AppDimensions.spaceXL),

              // Legal Section
              Text(loc.legal, style: AppTextStyles.titleMedium),
              const SizedBox(height: AppDimensions.space),

              _buildSettingsItem(
                icon: Icons.description_rounded,
                title: loc.termsOfService,
                subtitle: loc.readTermsAndConditions,
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.privacy_tip_rounded,
                title: loc.privacyPolicy,
                subtitle: loc.learnAboutPrivacy,
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.info_rounded,
                title: loc.about,
                subtitle: '${loc.version} 1.0.0',
                onTap: () {},
              ),

              const SizedBox(height: AppDimensions.spaceXL),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showLogoutDialog(context, loc);
                  },
                  icon: const Icon(Icons.logout_rounded),
                  label: Text(loc.logout),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.padding,
                    ),
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.space),

              // Delete Account Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    _showDeleteAccountDialog(context, loc);
                  },
                  child: Text(
                    loc.deleteAccount,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.error,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceS),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radius),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.backgroundGrey,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        title: Text(title, style: AppTextStyles.titleSmall),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        trailing:
            trailing ??
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceS),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radius),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.backgroundGrey,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        title: Text(title, style: AppTextStyles.titleSmall),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: AppColors.primary,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        title: Text(loc.logout),
        content: Text(loc.areYouSureLogout),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(loc.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
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
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(loc.logout),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        title: Text(loc.deleteAccount),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(loc.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final authProvider = Provider.of<AuthProvider>(
                context,
                listen: false,
              );
              try {
                await authProvider.deleteAccount();
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(loc.success),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${loc.error}: ${e.toString()}'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(loc.delete),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(
    BuildContext context,
    SettingsProvider settingsProvider,
    AppLocalizations loc,
  ) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        title: Text(loc.changePassword),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Current ${loc.password}',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New ${loc.password}',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm New ${loc.password}',
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              currentPasswordController.dispose();
              newPasswordController.dispose();
              confirmPasswordController.dispose();
              Navigator.of(context).pop();
            },
            child: Text(loc.cancel),
          ),
          TextButton(
            onPressed: () async {
              try {
                await settingsProvider.changePassword(
                  currentPassword: currentPasswordController.text,
                  newPassword: newPasswordController.text,
                  confirmPassword: confirmPasswordController.text,
                );
                currentPasswordController.dispose();
                newPasswordController.dispose();
                confirmPasswordController.dispose();
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(loc.success),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              }
            },
            child: Text(loc.save),
          ),
        ],
      ),
    );
  }

  void _showLanguageSelectionDialog(
    BuildContext context,
    LocaleProvider localeProvider,
    AppLocalizations loc,
  ) {
    final supportedLocales = localeProvider.getSupportedLocales();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        title: Text(loc.selectLanguage),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: supportedLocales.map((locale) {
              final isSelected =
                  localeProvider.locale.languageCode == locale.languageCode;
              return ListTile(
                title: Text(localeProvider.getLocaleDisplayName(locale)),
                trailing: isSelected
                    ? Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () async {
                  await localeProvider.changeLocale(locale);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(loc.cancel),
          ),
        ],
      ),
    );
  }
}
