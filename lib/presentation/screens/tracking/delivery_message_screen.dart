import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/core/constants/app_assets.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';

/// Delivery Message Screen - Chat with delivery person
/// Design: Figma node-id=192-613
/// Shows chat conversation with delivery person
class DeliveryMessageScreen extends StatefulWidget {
  const DeliveryMessageScreen({super.key});

  @override
  State<DeliveryMessageScreen> createState() => _DeliveryMessageScreenState();
}

class _DeliveryMessageScreenState extends State<DeliveryMessageScreen> {
  final TextEditingController _messageController = TextEditingController();

  // Messages initialized in build to access localization

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getMessages(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return [
      {
        'text': loc.areYouComing,
        'time': '8:10 pm',
        'isSent': true,
        'isRead': true,
      },
      {
        'text': loc.congratulationsForOrder,
        'time': '8:11 pm',
        'isSent': false,
        'isRead': false,
      },
      {
        'text': loc.whereAreYouNow,
        'time': '8:11 pm',
        'isSent': true,
        'isRead': true,
      },
      {
        'text': loc.imComingJustWait,
        'time': '8:12 pm',
        'isSent': false,
        'isRead': false,
      },
      {
        'text': loc.hurryUpMan,
        'time': '8:12 pm',
        'isSent': true,
        'isRead': true,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final messages = _getMessages(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Messages list
          Positioned(
            top: 109.h(context),
            left: 0,
            right: 0,
            bottom: 92.h(context),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w(context),
                vertical: 10.h(context),
              ),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageBubble(
                  context,
                  message['text'],
                  message['time'],
                  message['isSent'],
                  message['isRead'],
                );
              },
            ),
          ),

          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 109.h(context),
              color: AppColors.white,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                  child: Row(
                    children: [
                      // Close button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 45.w(context),
                          height: 45.w(context),
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(14.w(context)),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 20.w(context),
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w(context)),
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 17.w(context),
                          color: AppColors.textPrimary,
                          height: 22 / 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Message input bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: AppColors.white,
              padding: EdgeInsets.only(
                left: 24.w(context),
                right: 24.w(context),
                top: 15.h(context),
                bottom: 30.h(context),
              ),
              child: Row(
                children: [
                  // Input field
                  Expanded(
                    child: Container(
                      height: 62.h(context),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceF6,
                        borderRadius: BorderRadius.circular(10.w(context)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 16.w(context)),
                          Icon(
                            Icons.emoji_emotions_outlined,
                            size: 20.w(context),
                            color: AppColors.mutedGrayDark,
                          ),
                          SizedBox(width: 12.w(context)),
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: loc.writeSomething,
                                hintStyle: TextStyle(
                                  fontFamily: 'Sen',
                                  fontSize: 12.w(context),
                                  color: AppColors.mutedGrayDark,
                                  letterSpacing: -0.3333,
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 14.w(context),
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w(context)),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w(context)),

                  // Send button
                  GestureDetector(
                    onTap: () {
                      if (_messageController.text.isNotEmpty) {
                        setState(() {
                          messages.add({
                            'text': _messageController.text,
                            'time': loc.justNow,
                            'isSent': true,
                            'isRead': false,
                          });
                          _messageController.clear();
                        });
                      }
                    },
                    child: Container(
                      width: 42.w(context),
                      height: 42.h(context),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send,
                        size: 20.w(context),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(
    BuildContext context,
    String text,
    String time,
    bool isSent,
    bool isRead,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h(context)),
      child: Column(
        crossAxisAlignment: isSent
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          // Time
          Center(
            child: Text(
              time,
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 12.w(context),
                color: AppColors.mutedGrayDark,
                letterSpacing: -0.3333,
                height: 1.29,
              ),
            ),
          ),

          SizedBox(height: 4.h(context)),

          // Message bubble
          Row(
            mainAxisAlignment: isSent
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isSent) ...[
                // Delivery person avatar (left side)
                Container(
                  width: 40.w(context),
                  height: 40.h(context),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage(AppAssets.deliveryPerson),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10.w(context)),
              ],

              // Message container
              Container(
                constraints: BoxConstraints(
                  maxWidth: context.screenWidth * 0.65,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w(context),
                  vertical: 14.h(context),
                ),
                decoration: BoxDecoration(
                  color: isSent ? AppColors.primary : AppColors.surfaceF6,
                  borderRadius: BorderRadius.circular(10.w(context)),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 14.w(context),
                    color: isSent ? AppColors.white : AppColors.textPrimary,
                  ),
                ),
              ),

              if (isSent) ...[
                SizedBox(width: 10.w(context)),
                // User avatar (right side)
                CustomNetworkImage(
                  imageUrl: AppData.defaultProfileImage,
                  width: 40.w(context),
                  height: 40.h(context),
                  borderRadius: 40.w(context),
                  fit: BoxFit.cover,
                ),
              ],
            ],
          ),

          // Read receipt for sent messages
          if (isSent && isRead)
            Padding(
              padding: EdgeInsets.only(top: 4.h(context), right: 50.w(context)),
              child: Icon(
                Icons.done_all,
                size: 16.w(context),
                color: AppColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}
