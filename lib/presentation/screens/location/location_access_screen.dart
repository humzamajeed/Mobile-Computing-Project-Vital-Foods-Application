import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_assets.dart';
import 'package:finalproject/core/storage/shared_preferences_service.dart';
import 'package:finalproject/core/utils/app_routes.dart';

/// Location Access Screen - Request location permission
/// Design: Figma node-id=192-382
/// Exact Dimensions from Figma:
/// - Screen: 375x812px (iPhone X/11 Pro size)
/// - White background
/// - Image placeholder: 206x250px at (84, 176), rounded 90px
/// - Button: 327x62px at (24, 519.5)
/// - Description text: 323px width, centered at bottom
class LocationAccessScreen extends StatefulWidget {
  const LocationAccessScreen({super.key});

  @override
  State<LocationAccessScreen> createState() => _LocationAccessScreenState();
}

class _LocationAccessScreenState extends State<LocationAccessScreen> {
  void _requestLocationAccess() async {
    // Mark location access as shown
    await SharedPreferencesService.setLocationAccessShown(true);

    // In a real app, this would request location permission
    // For now, just navigate to home
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    // Exact dimensions from Figma
    const imageWidth = 206.0;
    const imageHeight = 250.0;
    const imageLeft = 84.0;
    const imageTop = 176.0;
    const imageRadius = 90.0;

    const buttonWidth = 327.0;
    const buttonHeight = 62.0;
    const backButtonLeft = 24.0;
    const buttonTop = 519.5;

    const descWidth = 323.0;
    const descTop = 618.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Image placeholder (Grey Box with Map)
          Positioned(
            left: imageLeft.w(context),
            top: imageTop.h(context),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(imageRadius.w(context)),
              child: Image.asset(
                AppAssets.mapLocation,
                width: imageWidth.w(context),
                height: imageHeight.h(context),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Access Location Button
          Positioned(
            left: backButtonLeft.w(context),
            top: buttonTop.h(context),
            child: GestureDetector(
              onTap: _requestLocationAccess,
              child: Container(
                width: buttonWidth.w(context),
                height: buttonHeight.h(context),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.w(context)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loc.enableLocation.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 16.w(context),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(width: 12.w(context)),
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 24.w(context),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Description text
          Positioned(
            top: descTop.h(context),
            left: (context.screenWidth - descWidth.w(context)) / 2,
            width: descWidth.w(context),
            child: Text(
              loc.locationAccessMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 16.w(context),
                fontWeight: FontWeight.w400,
                color: AppColors.mutedGrayDarker,
                height: 1.5,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
