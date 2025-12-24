import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_text_styles.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';
import 'package:finalproject/presentation/providers/review_provider.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';

/// Seller Reviews Screen - Display all reviews (Figma node 601-1780)
class SellerReviewsScreen extends StatefulWidget {
  const SellerReviewsScreen({super.key});

  @override
  State<SellerReviewsScreen> createState() => _SellerReviewsScreenState();
}

class _SellerReviewsScreenState extends State<SellerReviewsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadReviews();
    });
  }

  Future<void> _loadReviews() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
    final user = authProvider.user;

    if (user == null || user.role != 'chef') {
      debugPrint('⚠️ Cannot load reviews: User is null or not a chef');
      debugPrint('   - User: ${user?.id}');
      debugPrint('   - Role: ${user?.role}');
      return;
    }

    final chefId = user.id;
    debugPrint('🔍 Loading reviews for chef: $chefId');
    debugPrint('   - Chef name: ${user.name}');
    debugPrint('   - Chef email: ${user.email}');

    try {
      await reviewProvider.loadChefReviews(chefId);
      debugPrint('📊 Loaded ${reviewProvider.chefReviews.length} reviews');

      if (reviewProvider.chefReviews.isEmpty) {
        debugPrint('⚠️ No reviews found for chef $chefId');
        debugPrint('   - Checking all reviews in collection...');

        // Debug: Check all reviews
        try {
          final firestore = FirebaseFirestore.instance;
          final allReviews = await firestore.collection('reviews').get();
          debugPrint(
            '   - Total reviews in database: ${allReviews.docs.length}',
          );
          for (var doc in allReviews.docs) {
            final data = doc.data();
            debugPrint(
              '     Review ${doc.id}: chefId=${data['chefId']}, userId=${data['userId']}',
            );
          }
        } catch (e) {
          debugPrint('   - Error checking all reviews: $e');
        }
      } else {
        debugPrint('✅ Reviews found:');
        for (var review in reviewProvider.chefReviews) {
          debugPrint('   - Review ID: ${review.id}');
          debugPrint('     Chef ID: ${review.chefId}');
          debugPrint('     User: ${review.userName}');
          debugPrint('     Rating: ${review.rating}');
          debugPrint('     User Image: ${review.userImageUrl}');
          debugPrint('     Chef Image: ${review.chefImageUrl}');
        }
      }
    } catch (e) {
      debugPrint('❌ Error loading reviews: $e');
      debugPrint('   Stack trace: ${StackTrace.current}');
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
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
          loc.sellerReviews,
          style: AppTextStyles.titleMedium.copyWith(
            fontSize: 16.sp(context),
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              size: 24.w(context),
              color: AppColors.primary,
            ),
            onPressed: _loadReviews,
          ),
        ],
      ),
      body: Consumer<ReviewProvider>(
        builder: (context, reviewProvider, _) {
          if (reviewProvider.isLoading && reviewProvider.chefReviews.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (reviewProvider.errorMessage != null &&
              reviewProvider.chefReviews.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    reviewProvider.errorMessage!,
                    style: AppTextStyles.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h(context)),
                  ElevatedButton(
                    onPressed: () {
                      _loadReviews();
                    },
                    child: Text(loc.retry),
                  ),
                ],
              ),
            );
          }

          if (reviewProvider.chefReviews.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.reviews_outlined,
                    size: 64.w(context),
                    color: AppColors.textHint,
                  ),
                  SizedBox(height: 16.h(context)),
                  Text(loc.noReviewsYet, style: AppTextStyles.titleMedium),
                  SizedBox(height: 8.h(context)),
                  Text(
                    loc.reviewsFromCustomersWillAppearHere,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _loadReviews,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w(context),
                vertical: 16.h(context),
              ),
              itemCount: reviewProvider.chefReviews.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: 12.h(context)),
              itemBuilder: (context, index) {
                final review = reviewProvider.chefReviews[index];
                debugPrint(
                  '📝 Rendering review ${index + 1}/${reviewProvider.chefReviews.length}',
                );
                debugPrint('   - Review ID: ${review.id}');
                debugPrint('   - Chef ID: ${review.chefId}');
                debugPrint('   - User: ${review.userName}');

                // Ensure user and chef images are different
                final userImg =
                    review.userImageUrl ?? AppData.defaultProfileImage;
                var chefImg = review.chefImageUrl ?? AppData.getUserImage(1);

                // If images are the same, use different default for chef
                if (userImg == chefImg) {
                  chefImg = AppData.getUserImage(1);
                }

                debugPrint('   - User Image: $userImg');
                debugPrint('   - Chef Image: $chefImg');

                return _ReviewCard(
                  userName: review.userName,
                  userImageUrl: userImg,
                  chefName: review.chefName,
                  chefImageUrl: chefImg,
                  date: _formatDate(review.createdAt),
                  title: review.title,
                  rating: review.rating.toInt(),
                  reviewText: review.reviewText ?? '',
                  tags: review.tags ?? [],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String userName;
  final String userImageUrl;
  final String? chefName;
  final String chefImageUrl;
  final String date;
  final String title;
  final int rating;
  final String reviewText;
  final List<String> tags;

  const _ReviewCard({
    required this.userName,
    required this.userImageUrl,
    this.chefName,
    required this.chefImageUrl,
    required this.date,
    required this.title,
    required this.rating,
    required this.reviewText,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w(context)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.w(context)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer and Chef Images Row
          Row(
            children: [
              // Customer Image
              Stack(
                children: [
                  CustomNetworkImage(
                    imageUrl: userImageUrl,
                    width: 42.w(context),
                    height: 42.w(context),
                    borderRadius: 42.w(context),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16.w(context),
                      height: 16.w(context),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 10.w(context),
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8.w(context)),
              // Chef Image
              Stack(
                children: [
                  CustomNetworkImage(
                    imageUrl: chefImageUrl,
                    width: 42.w(context),
                    height: 42.w(context),
                    borderRadius: 42.w(context),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16.w(context),
                      height: 16.w(context),
                      decoration: BoxDecoration(
                        color: AppColors.accentBlue,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.restaurant,
                        size: 10.w(context),
                        color: AppColors.white,
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
                        fontSize: 13.sp(context),
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h(context)),
                    Text(
                      date,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 11.sp(context),
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_horiz,
                size: 22.w(context),
                color: AppColors.textHint,
              ),
            ],
          ),
          SizedBox(height: 12.h(context)),
          Text(
            title,
            style: AppTextStyles.titleSmall.copyWith(
              fontSize: 15.sp(context),
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h(context)),
          Row(
            children: List.generate(5, (index) {
              return Padding(
                padding: EdgeInsets.only(right: 2.w(context)),
                child: Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  size: 16.w(context),
                  color: index < rating ? AppColors.star : AppColors.textHint,
                ),
              );
            }),
          ),
          SizedBox(height: 10.h(context)),
          if (reviewText.isNotEmpty)
            Text(
              reviewText,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 13.sp(context),
                color: AppColors.textHint,
                height: 1.5,
              ),
            ),
          if (tags.isNotEmpty) ...[
            SizedBox(height: 12.h(context)),
            Wrap(
              spacing: 8.w(context),
              runSpacing: 8.h(context),
              children: tags.map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w(context),
                    vertical: 6.h(context),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r(context)),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tag,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 11.sp(context),
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
