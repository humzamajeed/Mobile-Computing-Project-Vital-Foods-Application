import 'package:flutter/material.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_text_styles.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';
import 'package:finalproject/presentation/widgets/seller_bottom_nav.dart';

/// Seller Notifications Screen (Figma node 601-1779)
class SellerNotificationsScreen extends StatefulWidget {
  const SellerNotificationsScreen({super.key});

  @override
  State<SellerNotificationsScreen> createState() =>
      _SellerNotificationsScreenState();
}

class _SellerNotificationsScreenState extends State<SellerNotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const SellerBottomNavBar(currentIndex: 3),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.w(context),
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: AppTextStyles.titleMedium.copyWith(
            fontSize: 16.sp(context),
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h(context)),
          child: Container(
            color: AppColors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textHint,
              labelStyle: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14.sp(context),
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14.sp(context),
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Notifications'),
                Tab(text: 'Messages (3)'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildNotificationsList(), _buildMessagesTab()],
      ),
    );
  }

  Widget _buildNotificationsList() {
    final notifications = [
      _NotificationItem(
        userName: 'Tanbir Ahmed',
        action: 'Placed a new order',
        time: '30 min ago',
        userImage: AppData.getUserImage(0),
        foodImage: AppData.getFoodImage(0),
      ),
      _NotificationItem(
        userName: 'Salim Smith',
        action: 'left a 5 star review',
        time: '30 min ago',
        userImage: AppData.getUserImage(1),
        foodImage: AppData.getFoodImage(1),
      ),
      _NotificationItem(
        userName: 'Royal Bengal',
        action: 'agreed to cancel',
        time: '30 min ago',
        userImage: AppData.getUserImage(2),
        foodImage: AppData.getFoodImage(2),
      ),
      _NotificationItem(
        userName: 'Pabel Vuiya',
        action: 'Placed a new order',
        time: '30 min ago',
        userImage: AppData.getUserImage(3),
        foodImage: AppData.getFoodImage(3),
      ),
    ];

    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w(context),
        vertical: 16.h(context),
      ),
      itemCount: notifications.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h(context)),
      itemBuilder: (context, index) => notifications[index],
    );
  }

  Widget _buildMessagesTab() {
    final messages = [
      _MessageItem(
        userName: 'Royal Parvej',
        message: 'Sounds awesome!',
        time: '19:37',
        unreadCount: 1,
        isOnline: false,
        userImage: AppData.getUserImage(0),
      ),
      _MessageItem(
        userName: 'Cameron Williamson',
        message: 'Ok, just hurry up little bit...😊',
        time: '19:37',
        unreadCount: 2,
        isOnline: false,
        userImage: AppData.getUserImage(1),
      ),
      _MessageItem(
        userName: 'Ralph Edwards',
        message: 'Thanks dude.',
        time: '19:37',
        unreadCount: 0,
        isOnline: true,
        userImage: AppData.getUserImage(2),
      ),
      _MessageItem(
        userName: 'Cody Fisher',
        message: 'How is going..?',
        time: '19:37',
        unreadCount: 0,
        isOnline: false,
        userImage: AppData.getUserImage(3),
      ),
      _MessageItem(
        userName: 'Eleanor Pena',
        message: 'Thanks for the awesome food man...!',
        time: '19:37',
        unreadCount: 0,
        isOnline: false,
        userImage: AppData.getUserImage(4),
      ),
    ];

    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w(context),
        vertical: 16.h(context),
      ),
      itemCount: messages.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h(context)),
      itemBuilder: (context, index) => messages[index],
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String userName;
  final String action;
  final String time;
  final String userImage;
  final String foodImage;

  const _NotificationItem({
    required this.userName,
    required this.action,
    required this.time,
    required this.userImage,
    required this.foodImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w(context)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.w(context)),
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
          CustomNetworkImage(
            imageUrl: userImage,
            width: 48.w(context),
            height: 48.w(context),
            borderRadius: 48.w(context),
            fit: BoxFit.cover,
          ),
          SizedBox(width: 12.w(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 14.sp(context),
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(text: userName),
                      TextSpan(
                        text: ' $action',
                        style: TextStyle(
                          color: AppColors.textHint,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h(context)),
                Text(
                  time,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12.sp(context),
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 56.w(context),
            height: 56.w(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.w(context)),
              color: AppColors.surfaceF6,
            ),
            child: CustomNetworkImage(
              imageUrl: foodImage,
              width: 56.w(context),
              height: 56.w(context),
              borderRadius: 12.w(context),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageItem extends StatelessWidget {
  final String userName;
  final String message;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final String userImage;

  const _MessageItem({
    required this.userName,
    required this.message,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w(context)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.w(context)),
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
          Stack(
            children: [
              CustomNetworkImage(
                imageUrl: userImage,
                width: 48.w(context),
                height: 48.w(context),
                borderRadius: 48.w(context),
                fit: BoxFit.cover,
              ),
              if (isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12.w(context),
                    height: 12.w(context),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 15.sp(context),
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h(context)),
                Text(
                  message,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 13.sp(context),
                    color: AppColors.textHint,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w(context)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12.sp(context),
                  color: AppColors.textHint,
                ),
              ),
              if (unreadCount > 0) ...[
                SizedBox(height: 6.h(context)),
                Container(
                  width: 20.w(context),
                  height: 20.w(context),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$unreadCount',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 11.sp(context),
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
