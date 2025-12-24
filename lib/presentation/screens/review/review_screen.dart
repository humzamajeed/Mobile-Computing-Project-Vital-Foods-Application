import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/size_extensions.dart';
import '../../../core/data/app_data.dart';
import '../../../domain/entities/review.dart';
import '../../providers/review_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_network_image.dart';

/// Review Screen
/// Design: Figma node-id=149:1166
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  final List<String> _selectedTags = [];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
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
          loc.writeReview,
          style: AppTextStyles.titleMedium.copyWith(
            fontSize: 16.sp(context),
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w(context)),
              child: Column(
                children: [
                  // Order Info
                  Container(
                    padding: EdgeInsets.all(16.w(context)),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16.r(context)),
                    ),
                    child: Row(
                      children: [
                        CustomNetworkImage(
                          imageUrl: AppData.getFoodImage(0),
                          width: 60.w(context),
                          height: 60.h(context),
                          borderRadius: 12.r(context),
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 16.w(context)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chicken Thai Biriyani',
                                style: AppTextStyles.titleSmall.copyWith(
                                  fontSize: 14.sp(context),
                                ),
                              ),
                              SizedBox(height: 4.h(context)),
                              Text(
                                'Order #162432',
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontSize: 12.sp(context),
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              SizedBox(height: 4.h(context)),
                              Text(
                                'Burger King',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontSize: 13.sp(context),
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h(context)),

                  // Rating Section
                  Center(
                    child: Column(
                      children: [
                        Text(
                          loc.yourRating,
                          style: AppTextStyles.headlineSmall.copyWith(
                            fontSize: 20.sp(context),
                          ),
                        ),
                        SizedBox(height: 8.h(context)),
                        Text(
                          loc.writeYourReviewHere,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 14.sp(context),
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 20.h(context)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return IconButton(
                              onPressed: () {
                                setState(() {
                                  _rating = index + 1.0;
                                });
                              },
                              icon: Icon(
                                index < _rating
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                color: AppColors.warning,
                                size: 48.w(context),
                              ),
                            );
                          }),
                        ),
                        if (_rating > 0)
                          Padding(
                            padding: EdgeInsets.only(top: 12.h(context)),
                            child: Text(
                              _getRatingText(_rating),
                              style: AppTextStyles.titleMedium.copyWith(
                                fontSize: 16.sp(context),
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h(context)),

                  // Review Text Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      loc.writeReview,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontSize: 16.sp(context),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h(context)),
                  TextField(
                    controller: _reviewController,
                    maxLines: 5,
                    style: TextStyle(fontSize: 14.sp(context)),
                    decoration: InputDecoration(
                      hintText: loc.writeYourReviewHere,
                      hintStyle: TextStyle(fontSize: 14.sp(context)),
                      contentPadding: EdgeInsets.all(16.w(context)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r(context)),
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h(context)),

                  // Quick Tags
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      loc.addTags,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontSize: 16.sp(context),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h(context)),
                  Wrap(
                    spacing: 8.w(context),
                    runSpacing: 8.h(context),
                    children: [
                      _buildTag(context, loc.delicious),
                      _buildTag(context, loc.fastDelivery),
                      _buildTag(context, loc.hotFresh),
                      _buildTag(context, loc.goodPackaging),
                      _buildTag(context, loc.valueForMoney),
                      _buildTag(context, loc.friendlyRider),
                    ],
                  ),

                  SizedBox(height: 24.h(context)),

                  // Delivery Person Rating
                  Container(
                    padding: EdgeInsets.all(16.w(context)),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16.r(context)),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.rateDeliveryPerson,
                          style: AppTextStyles.titleSmall.copyWith(
                            fontSize: 14.sp(context),
                          ),
                        ),
                        SizedBox(height: 12.h(context)),
                        Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl: AppData.getUserImage(0),
                              width: 50.w(context),
                              height: 50.h(context),
                              borderRadius: 25.w(context),
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 16.w(context)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'John Doe',
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      fontSize: 14.sp(context),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4.h(context)),
                                  Text(
                                    'Delivery Person',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      fontSize: 12.sp(context),
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 4.w(context)),
                                  child: Icon(
                                    Icons.star_border_rounded,
                                    color: AppColors.warning,
                                    size: 24.w(context),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Submit Button
          Container(
            padding: EdgeInsets.all(24.w(context)),
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
              child: SizedBox(
                width: double.infinity,
                height: 50.h(context),
                child: ElevatedButton(
                  onPressed: (_rating > 0 && !_isSubmitting)
                      ? () async {
                          await _submitReview(context);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h(context)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r(context)),
                    ),
                  ),
                  child: _isSubmitting
                      ? SizedBox(
                          width: 20.w(context),
                          height: 20.h(context),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.white,
                            ),
                          ),
                        )
                      : Text(
                          loc.submitReview,
                          style: TextStyle(fontSize: 16.sp(context)),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, String label) {
    final isSelected = _selectedTags.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedTags.remove(label);
          } else {
            _selectedTags.add(label);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w(context),
          vertical: 12.h(context),
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20.r(context)),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14.sp(context),
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  String _getRatingText(double rating) {
    if (rating <= 1) return 'Poor';
    if (rating <= 2) return 'Fair';
    if (rating <= 3) return 'Good';
    if (rating <= 4) return 'Very Good';
    return 'Excellent';
  }

  Future<void> _submitReview(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;
    // Prevent double submission
    if (_isSubmitting) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final reviewProvider = Provider.of<ReviewProvider>(
        context,
        listen: false,
      );
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final user = authProvider.user;

      if (user == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(loc.pleaseLoginToSubmitReview),
              backgroundColor: AppColors.error,
            ),
          );
        }
        return;
      }

      // Get chefId and chef information - try to find a chef user
      // IMPORTANT: Find a chef that is NOT the current user (if user is not a chef)
      String chefId = '';
      String? chefName;
      String? chefImageUrl;

      try {
        final firestore = FirebaseFirestore.instance;

        // If current user is a chef, they can't review themselves
        // Find a different chef
        final query = firestore
            .collection('users')
            .where('role', isEqualTo: 'chef');

        // If current user is a chef, exclude them from the query
        if (user.role == 'chef') {
          // Get all chefs and find one that's not the current user
          final allChefsQuery = await query.get();
          if (allChefsQuery.docs.isNotEmpty) {
            // Find a chef that's not the current user
            final otherChef = allChefsQuery.docs.firstWhere(
              (doc) => doc.id != user.id,
              orElse: () => allChefsQuery
                  .docs
                  .first, // Fallback to first if only one chef
            );
            chefId = otherChef.id;
            final chefData = otherChef.data();
            chefName = chefData['name'] as String?;
            chefImageUrl = chefData['photoUrl'] as String?;
          } else {
            // No other chefs, use current user but with different image
            chefId = user.id;
            chefName = user.name;
            // Use a different default image for chef
            chefImageUrl = AppData.getUserImage(1); // Different image index
          }
        } else {
          // User is not a chef, find any chef
          final chefsQuery = await query.get();
          if (chefsQuery.docs.isNotEmpty) {
            // Use the first chef found
            final chefDoc = chefsQuery.docs.first;
            chefId = chefDoc.id;
            final chefData = chefDoc.data();
            chefName = chefData['name'] as String?;
            chefImageUrl = chefData['photoUrl'] as String?;

            // Ensure chef image is different from user image
            if (chefImageUrl == null || chefImageUrl == user.photoUrl) {
              chefImageUrl = AppData.getUserImage(
                1,
              ); // Use different default image
            }
          } else {
            // No chefs found - show error instead of using default_chef
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(loc.noChefsAvailable),
                  backgroundColor: AppColors.error,
                ),
              );
            }
            return;
          }
        }

        // Ensure user and chef images are different
        final userImg = user.photoUrl ?? AppData.defaultProfileImage;
        if (chefImageUrl == null || chefImageUrl == userImg) {
          // Use a different image for chef
          chefImageUrl = AppData.getUserImage(1);
        }

        debugPrint('✅ Found chef: $chefId, name: $chefName');
        debugPrint('   - User image: $userImg');
        debugPrint('   - Chef image: $chefImageUrl');
        debugPrint('   - Images different: ${userImg != chefImageUrl}');
      } catch (e) {
        debugPrint('❌ Error finding chef: $e');
        // Try to find any chef as fallback
        try {
          final firestore = FirebaseFirestore.instance;
          final chefsQuery = await firestore
              .collection('users')
              .where('role', isEqualTo: 'chef')
              .limit(1)
              .get();
          if (chefsQuery.docs.isNotEmpty) {
            final chefDoc = chefsQuery.docs.first;
            chefId = chefDoc.id;
            final chefData = chefDoc.data();
            chefName = chefData['name'] as String?;
            chefImageUrl = chefData['photoUrl'] as String?;
          } else {
            // No chefs found - show error
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(loc.noChefsAvailable),
                  backgroundColor: AppColors.error,
                ),
              );
            }
            return;
          }
        } catch (e2) {
          debugPrint('❌ Error in fallback chef search: $e2');
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(loc.unableToFindChef),
                backgroundColor: AppColors.error,
              ),
            );
          }
          return;
        }
      }

      // Collect all review data
      final reviewText = _reviewController.text.trim();
      final tags = _selectedTags.isNotEmpty
          ? List<String>.from(_selectedTags)
          : null;

      debugPrint('📝 Submitting review with:');
      debugPrint('   - Rating: $_rating');
      debugPrint(
        '   - Review text: ${reviewText.isNotEmpty ? reviewText : "empty"}',
      );
      debugPrint('   - Tags: ${tags ?? "none"}');
      debugPrint('   - Tags count: ${_selectedTags.length}');

      // Create review entity with all data
      final review = Review(
        id: '', // Will be set by Firestore
        userId: user.id,
        userName: user.name ?? 'User',
        userImageUrl: user.photoUrl,
        chefId: chefId,
        chefName: chefName,
        chefImageUrl: chefImageUrl,
        orderId: null, // TODO: Get from order if available
        foodName: 'Chicken Thai Biriyani', // TODO: Get from order
        rating: _rating,
        title: _getRatingText(_rating),
        reviewText: reviewText.isNotEmpty ? reviewText : null,
        tags: tags,
        createdAt: DateTime.now(),
      );

      // Show loading indicator
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      }

      final createdReview = await reviewProvider.createReview(review);

      // Dismiss loading
      if (context.mounted) {
        Navigator.pop(context);
      }

      if (createdReview != null && context.mounted) {
        debugPrint(
          '✅ Review submitted successfully with ID: ${createdReview.id}',
        );
        // Clear form
        setState(() {
          _rating = 0;
          _reviewController.clear();
          _selectedTags.clear();
        });
        _showThankYouDialog(context);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              reviewProvider.errorMessage ?? loc.failedToSubmitReview,
            ),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ Error submitting review: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.errorSubmittingReview(e.toString())),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        final dialogLoc = AppLocalizations.of(dialogContext)!;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r(context)),
          ),
          contentPadding: EdgeInsets.all(24.w(context)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80.w(context),
                height: 80.h(context),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 48.w(context),
                ),
              ),
              SizedBox(height: 20.h(context)),
              Text(
                'Thank You!',
                style: AppTextStyles.titleLarge.copyWith(
                  fontSize: 20.sp(context),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h(context)),
              Text(
                'Your review has been submitted successfully',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 14.sp(context),
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h(context)),
              SizedBox(
                width: double.infinity,
                height: 50.h(context),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r(context)),
                    ),
                  ),
                  child: Text(
                    dialogLoc.done,
                    style: TextStyle(fontSize: 16.sp(context)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
