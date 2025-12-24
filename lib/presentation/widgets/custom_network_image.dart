import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalproject/core/constants/app_assets.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final String? errorAsset;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.borderRadiusGeometry,
    this.errorAsset,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadiusGeometry ?? BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: AppColors.surfaceF6,
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: AppColors.surfaceF6,
          child: Image.asset(
            errorAsset ?? AppAssets.foodPlaceholder,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.image_not_supported_outlined,
                color: AppColors.textHint,
                size: (width ?? 40) * 0.4,
              );
            },
          ),
        ),
      ),
    );
  }
}
