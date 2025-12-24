import 'package:flutter/material.dart';

/// Extension for responsive sizing based on design dimensions
///
/// Usage example:
/// ```dart
/// Container(
///   width: context.w(100),    // 100px from Figma design
///   height: context.h(50),    // 50px from Figma design
///   child: Text(
///     'Hello',
///     style: TextStyle(fontSize: context.sp(14)),  // 14px text from Figma
///   ),
/// )
/// ```
extension SizeExtension on BuildContext {
  /// 📏 Set these to your Figma artboard size
  static const double figmaWidth = 375; // iPhone 12/13 width
  static const double figmaHeight = 812; // iPhone 12/13 height

  /// 🔹 Get screen width & height
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  /// 🔹 Get screen padding (safe area)
  EdgeInsets get padding => MediaQuery.of(this).padding;

  /// 🔹 Get viewport insets (keyboard height, etc.)
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  /// 🔹 Scale width relative to Figma design
  ///
  /// Example: `context.w(100)` converts 100px from Figma to scaled width
  double w(double value) => (value / figmaWidth) * screenWidth;

  /// 🔹 Scale height relative to Figma design
  ///
  /// Example: `context.h(50)` converts 50px from Figma to scaled height
  double h(double value) => (value / figmaHeight) * screenHeight;

  /// 🔹 Scale text size (font size) relative to Figma design
  ///
  /// Example: `context.sp(14)` converts 14px font from Figma to scaled size
  double sp(double value) => (value / figmaWidth) * screenWidth;

  /// 🔹 Scale radius relative to Figma design
  ///
  /// Example: `context.r(12)` for border radius
  double r(double value) => (value / figmaWidth) * screenWidth;

  /// 🔹 Responsive font size with min/max constraints
  ///
  /// Example: `context.responsiveSp(14, min: 12, max: 18)`
  double responsiveSp(double value, {double? min, double? max}) {
    double scaled = sp(value);
    if (min != null && scaled < min) return min;
    if (max != null && scaled > max) return max;
    return scaled;
  }

  /// 🔹 Get orientation
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  /// 🔹 Screen type helpers
  bool get isSmallScreen => screenWidth < 600;
  bool get isMediumScreen => screenWidth >= 600 && screenWidth < 900;
  bool get isLargeScreen => screenWidth >= 900;

  /// 🔹 Responsive padding
  EdgeInsets horizontalPadding(double value) =>
      EdgeInsets.symmetric(horizontal: w(value));
  EdgeInsets verticalPadding(double value) =>
      EdgeInsets.symmetric(vertical: h(value));
  EdgeInsets allPadding(double value) => EdgeInsets.all(w(value));

  /// 🔹 Custom responsive padding
  EdgeInsets customPadding({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => EdgeInsets.only(
    left: w(left),
    top: h(top),
    right: w(right),
    bottom: h(bottom),
  );

  /// 🔹 Responsive SizedBox
  Widget widthBox(double value) => SizedBox(width: w(value));
  Widget heightBox(double value) => SizedBox(height: h(value));
  Widget sizedBox(double width, double height) =>
      SizedBox(width: w(width), height: h(height));
}

/// Extension for responsive sizing on numbers
///
/// Usage example:
/// ```dart
/// Container(
///   width: 100.w(context),
///   height: 50.h(context),
/// )
/// ```
extension ResponsiveNum on num {
  /// Scale width
  double w(BuildContext context) =>
      (this / SizeExtension.figmaWidth) * context.screenWidth;

  /// Scale height
  double h(BuildContext context) =>
      (this / SizeExtension.figmaHeight) * context.screenHeight;

  /// Scale text/font size
  double sp(BuildContext context) =>
      (this / SizeExtension.figmaWidth) * context.screenWidth;

  /// Scale radius
  double r(BuildContext context) =>
      (this / SizeExtension.figmaWidth) * context.screenWidth;
}
