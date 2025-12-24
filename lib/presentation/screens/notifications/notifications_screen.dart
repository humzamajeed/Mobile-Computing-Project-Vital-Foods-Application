import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_text_styles.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';

/// Notifications Screen - Figma node-id=601-1779
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final sections = _getNotificationSections(loc);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w(context),
            vertical: 12.h(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(),
              SizedBox(height: 16.h(context)),
              ...sections.map(
                (section) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.title,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontSize: 16.sp(context),
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12.h(context)),
                    ...section.items.map(
                      (item) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h(context)),
                        child: _NotificationCard(item: item),
                      ),
                    ),
                    SizedBox(height: 12.h(context)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 44.w(context),
            height: 44.w(context),
            decoration: BoxDecoration(
              color: AppColors.surfaceF6,
              borderRadius: BorderRadius.circular(14.w(context)),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 18.w(context),
              color: AppColors.textPrimary,
            ),
          ),
        ),
        SizedBox(width: 16.w(context)),
        Text(
          loc.notifications,
          style: AppTextStyles.titleLarge.copyWith(
            fontSize: 20.sp(context),
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(
            loc.markAll,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 14.sp(context),
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final _Notification item;

  const _NotificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final bgColor = item.unread
        ? AppColors.primary.withValues(alpha: 0.05)
        : AppColors.white;
    final borderColor = item.unread
        ? AppColors.primary.withValues(alpha: 0.2)
        : AppColors.divider;

    return Container(
      padding: EdgeInsets.all(14.w(context)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.w(context)),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48.w(context),
            height: 48.w(context),
            decoration: BoxDecoration(
              color: item.iconColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: item.iconColor, size: 22.w(context)),
          ),
          SizedBox(width: 12.w(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 15.sp(context),
                          fontWeight: item.unread
                              ? FontWeight.w700
                              : FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Text(
                      item.time,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12.sp(context),
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (item.unread) ...[
                      SizedBox(width: 6.w(context)),
                      Container(
                        width: 8.w(context),
                        height: 8.w(context),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 6.h(context)),
                Text(
                  item.message,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 13.sp(context),
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationSection {
  final String title;
  final List<_Notification> items;

  const _NotificationSection({required this.title, required this.items});
}

class _Notification {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String time;
  final bool unread;

  const _Notification({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.time,
    this.unread = false,
  });
}

// Note: These notification sections use hardcoded strings for demo data
// In a real app, these would come from a backend service
List<_NotificationSection> _getNotificationSections(AppLocalizations loc) => [
  _NotificationSection(
    title: loc.today,
    items: [
      _Notification(
        icon: Icons.delivery_dining_rounded,
        iconColor: AppColors.primary,
        title: 'Order #162432 delivered',
        message: 'Your delivery has arrived. Rate your experience.',
        time: '2h ago',
        unread: true,
      ),
      _Notification(
        icon: Icons.local_offer_rounded,
        iconColor: AppColors.success,
        title: '30% OFF for you',
        message: 'Apply code FOODIE30 on your next order before 8PM.',
        time: '5h ago',
        unread: true,
      ),
    ],
  ),
  _NotificationSection(
    title: loc.yesterday,
    items: [
      _Notification(
        icon: Icons.payment_rounded,
        iconColor: AppColors.warning,
        title: 'Payment successful',
        message: 'Your payment of \$34.25 was completed.',
        time: '12h ago',
      ),
      _Notification(
        icon: Icons.star_rounded,
        iconColor: AppColors.warning,
        title: 'Rate your order',
        message: 'How was your experience with Burger Hub?',
        time: '15h ago',
      ),
    ],
  ),
  _NotificationSection(
    title: loc.older,
    items: [
      _Notification(
        icon: Icons.restaurant_rounded,
        iconColor: AppColors.primary,
        title: 'Order confirmed',
        message: 'Your order has been confirmed by the restaurant.',
        time: '3d ago',
      ),
      _Notification(
        icon: Icons.account_circle_rounded,
        iconColor: AppColors.textSecondary,
        title: 'Welcome aboard!',
        message: 'Thanks for joining Food Delivery. Start ordering now.',
        time: '1w ago',
      ),
    ],
  ),
];
