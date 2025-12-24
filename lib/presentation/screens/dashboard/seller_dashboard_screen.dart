import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_text_styles.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/utils/app_routes.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';
import 'package:finalproject/presentation/widgets/seller_bottom_nav.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';

/// Seller dashboard view (Figma node 601-1773)
class SellerDashboardScreen extends StatelessWidget {
  const SellerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const SellerBottomNavBar(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w(context),
            vertical: 12.h(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: 20.h(context)),
              _buildStatRow(context),
              SizedBox(height: 16.h(context)),
              _buildRevenueCard(context),
              SizedBox(height: 14.h(context)),
              _buildReviewsCard(context),
              SizedBox(height: 14.h(context)),
              _buildPopularCard(context),
              SizedBox(height: 20.h(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Row(
      children: [
        Container(
          width: 40.w(context),
          height: 40.w(context),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.w(context)),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Icon(
            Icons.menu_rounded,
            size: 22.w(context),
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(width: 16.w(context)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.location,
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 11.sp(context),
                  letterSpacing: 0.5,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h(context)),
              Row(
                children: [
                  Text(
                    'Halal Lab office',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 14.sp(context),
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 2.w(context)),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 20.w(context),
                    color: AppColors.textHint,
                  ),
                ],
              ),
            ],
          ),
        ),
        Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            final user = authProvider.user;
            final photoUrl = user?.photoUrl ?? AppData.defaultProfileImage;
            return Container(
              width: 40.w(context),
              height: 40.w(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surfaceF6,
              ),
              child: ClipOval(
                child: CustomNetworkImage(
                  imageUrl: photoUrl,
                  width: 40.w(context),
                  height: 40.w(context),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatRow(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: _StatCard(value: '20', label: loc.runningOrders.toUpperCase()),
        ),
        SizedBox(width: 12.w(context)),
        Expanded(
          child: _StatCard(
            value: '05',
            label: 'ORDER REQUEST',
          ), // Keep as is for now
        ),
      ],
    );
  }

  Widget _buildRevenueCard(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w(context)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.w(context)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.revenue,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12.sp(context),
                      color: AppColors.textHint,
                    ),
                  ),
                  SizedBox(height: 6.h(context)),
                  Text(
                    '\$2,241',
                    style: AppTextStyles.headlineSmall.copyWith(
                      fontSize: 22.sp(context),
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w(context),
                  vertical: 6.h(context),
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceF6,
                  borderRadius: BorderRadius.circular(12.w(context)),
                ),
                child: Row(
                  children: [
                    Text(
                      loc.daily,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12.sp(context),
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 18.w(context),
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h(context)),
          _RevenueChart(height: 120.h(context)),
          SizedBox(height: 12.h(context)),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.runningOrders),
              child: Text(
                loc.seeDetails,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12.sp(context),
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsCard(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w(context),
        vertical: 14.h(context),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.w(context)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                loc.sellerReviews,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 13.sp(context),
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.sellerReviews),
                child: Text(
                  loc.seeAllReviews,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12.sp(context),
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h(context)),
          Row(
            children: [
              Icon(Icons.star, size: 18.w(context), color: AppColors.star),
              SizedBox(width: 6.w(context)),
              Text(
                '4.9',
                style: AppTextStyles.titleMedium.copyWith(
                  fontSize: 16.sp(context),
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 10.w(context)),
              Text(
                'Total 20 Reviews',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12.sp(context),
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPopularCard(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w(context),
        vertical: 14.h(context),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.w(context)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                loc.popularItemsThisWeek,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 13.sp(context),
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.popularItems),
                child: Text(
                  loc.seeAll,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12.sp(context),
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h(context)),
          Row(
            children: [
              const Expanded(child: _PopularThumb(index: 0)),
              SizedBox(width: 10.w(context)),
              const Expanded(child: _PopularThumb(index: 1)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w(context),
        vertical: 20.h(context),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.w(context)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTextStyles.headlineMedium.copyWith(
              fontSize: 32.sp(context),
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8.h(context)),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 11.sp(context),
              color: AppColors.textHint,
              letterSpacing: 0.3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _RevenueChart extends StatelessWidget {
  final double height;

  const _RevenueChart({required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 6.w(context)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.w(context)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary.withValues(alpha: 0.12),
                AppColors.white,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _LinePainter(
                    lineColor: AppColors.primary,
                    pointColor: AppColors.primary,
                  ),
                ),
              ),
              Positioned(
                top: height * 0.42,
                left: 80.w(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w(context),
                    vertical: 6.h(context),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary,
                    borderRadius: BorderRadius.circular(10.w(context)),
                  ),
                  child: Text(
                    '\$500',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 11.sp(context),
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h(context)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeLabel(context, '00AM'),
              _buildTimeLabel(context, '11AM'),
              _buildTimeLabel(context, '12PM'),
              _buildTimeLabel(context, '01PM'),
              _buildTimeLabel(context, '02PM'),
              _buildTimeLabel(context, '03PM'),
              _buildTimeLabel(context, '04PM'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeLabel(BuildContext context, String label) {
    return Text(
      label,
      style: AppTextStyles.bodySmall.copyWith(
        fontSize: 10.sp(context),
        color: AppColors.textHint,
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  final Color lineColor;
  final Color pointColor;

  _LinePainter({required this.lineColor, required this.pointColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = lineColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.2, size.height * 0.65),
      Offset(size.width * 0.32, size.height * 0.4),
      Offset(size.width * 0.45, size.height * 0.55),
      Offset(size.width * 0.58, size.height * 0.45),
      Offset(size.width * 0.75, size.height * 0.62),
      Offset(size.width, size.height * 0.35),
    ];

    path.moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paintLine);

    final paintPoint = Paint()
      ..color = pointColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(points[2], 5, paintPoint);
    canvas.drawCircle(points[4], 5, paintPoint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PopularThumb extends StatelessWidget {
  final int index;

  const _PopularThumb({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86.h(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w(context)),
        color: AppColors.surfaceF6,
      ),
      child: CustomNetworkImage(
        imageUrl: AppData.getFoodImage(
          index + 3,
        ), // Offset to get different images
        borderRadius: 16.w(context),
        width: double.infinity,
        height: 86.h(context),
      ),
    );
  }
}
