import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';

/// Support/Chat Screen
/// Design: Figma node-id=149:1168
class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController _messageController = TextEditingController();
  late List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    // Messages will be initialized in build to access localization
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    _messages = [
      ChatMessage(text: loc.helloHowCanIHelp, isUser: false, time: '10:30 AM'),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.helpAndSupport),
            Text(
              loc.online,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.success),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.phone_rounded)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick Help Options
          Container(
            padding: const EdgeInsets.all(AppDimensions.padding),
            color: AppColors.cardBackground,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickHelpChip(context, loc.orderIssue),
                  const SizedBox(width: AppDimensions.spaceS),
                  _buildQuickHelpChip(context, loc.paymentIssue),
                  const SizedBox(width: AppDimensions.spaceS),
                  _buildQuickHelpChip(context, loc.deliveryIssue),
                  const SizedBox(width: AppDimensions.spaceS),
                  _buildQuickHelpChip(context, loc.accountIssue),
                ],
              ),
            ),
          ),

          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppDimensions.paddingXL),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(AppDimensions.padding),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file_rounded),
                    color: AppColors.textSecondary,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: loc.typeAMessage,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusL,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.padding,
                          vertical: AppDimensions.spaceM,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spaceS),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(Icons.send_rounded),
                      color: AppColors.white,
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

  Widget _buildQuickHelpChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.padding,
        vertical: AppDimensions.spaceM,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(label, style: AppTextStyles.bodyMedium),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.space),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.backgroundGrey,
              child: const Icon(
                Icons.support_agent_rounded,
                size: 20,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppDimensions.spaceS),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.padding),
              decoration: BoxDecoration(
                color: message.isUser
                    ? AppColors.primary
                    : AppColors.cardBackground,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppDimensions.radius),
                  topRight: const Radius.circular(AppDimensions.radius),
                  bottomLeft: Radius.circular(
                    message.isUser ? AppDimensions.radius : 0,
                  ),
                  bottomRight: Radius.circular(
                    message.isUser ? 0 : AppDimensions.radius,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: message.isUser
                          ? AppColors.white
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.time,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: message.isUser
                          ? AppColors.white.withValues(alpha: 0.7)
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: AppDimensions.spaceS),
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: const Icon(
                Icons.person_rounded,
                size: 20,
                color: AppColors.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: _messageController.text,
          isUser: true,
          time: _getCurrentTime(),
        ),
      );
      _messageController.clear();

      // Simulate bot response
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages.add(
            ChatMessage(
              text:
                  'Thank you for your message. Our team will assist you shortly.',
              isUser: false,
              time: _getCurrentTime(),
            ),
          );
        });
      });
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final String time;

  ChatMessage({required this.text, required this.isUser, required this.time});
}
