import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';

/// Filter Screen - Bottom sheet for the popular burgers page
/// Figma ref: node-id=601-1669
class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _freeDelivery = false;
  bool _fastDelivery = false;
  String _sortBy = 'popular';
  String _deliveryTime = '30';
  double _price = 60;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.35),
      body: SafeArea(
        child: Stack(
          children: [
            // close on tap outside
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.transparent),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: context.screenWidth,
                height: 560.h(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.w(context)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h(context)),
                    Center(
                      child: Container(
                        width: 44.w(context),
                        height: 4.h(context),
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(2.w(context)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w(context),
                        vertical: 16.h(context),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            loc.filter,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20.w(context),
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimaryDeep,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 36.w(context),
                              height: 36.w(context),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceF5,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 18.w(context),
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w(context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle(context, loc.sortBy),
                            SizedBox(height: 12.h(context)),
                            _buildRadioOption(context, loc.popular, 'popular'),
                            SizedBox(height: 10.h(context)),
                            _buildRadioOption(
                              context,
                              loc.priceLowToHigh,
                              'price_low',
                            ),
                            SizedBox(height: 10.h(context)),
                            _buildRadioOption(
                              context,
                              loc.priceHighToLow,
                              'price_high',
                            ),
                            SizedBox(height: 10.h(context)),
                            _buildRadioOption(context, loc.rating, 'rating'),

                            SizedBox(height: 24.h(context)),
                            _sectionTitle(context, loc.deliveryTime),
                            SizedBox(height: 12.h(context)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _timeChip(context, '10-30 min', '30'),
                                _timeChip(context, '30-60 min', '60'),
                                _timeChip(context, 'Any', 'any'),
                              ],
                            ),

                            SizedBox(height: 24.h(context)),
                            _sectionTitle(context, loc.specials),
                            SizedBox(height: 12.h(context)),
                            _buildCheckboxOption(
                              context,
                              loc.freeDelivery,
                              _freeDelivery,
                              (v) {
                                setState(() => _freeDelivery = v);
                              },
                            ),
                            SizedBox(height: 12.h(context)),
                            _buildCheckboxOption(
                              context,
                              loc.fastDelivery,
                              _fastDelivery,
                              (v) {
                                setState(() => _fastDelivery = v);
                              },
                            ),

                            SizedBox(height: 24.h(context)),
                            _sectionTitle(context, loc.priceRange),
                            SizedBox(height: 12.h(context)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('\$0', style: _labelStyle(context)),
                                Text(
                                  '\$${_price.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.w(context),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimaryDeep,
                                  ),
                                ),
                                Text('\$120', style: _labelStyle(context)),
                              ],
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 4.h(context),
                                activeTrackColor: AppColors.primary,
                                inactiveTrackColor: AppColors.border,
                                thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 10.w(context),
                                ),
                                thumbColor: AppColors.primary,
                                overlayColor: AppColors.primary.withValues(
                                  alpha: 0.1,
                                ),
                              ),
                              child: Slider(
                                min: 0,
                                max: 120,
                                value: _price,
                                onChanged: (v) => setState(() => _price = v),
                              ),
                            ),

                            SizedBox(height: 32.h(context)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        24.w(context),
                        0,
                        24.w(context),
                        24.h(context),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _resetFilters,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.border),
                                foregroundColor: AppColors.textPrimaryDeep,
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.h(context),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    12.w(context),
                                  ),
                                ),
                                textStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.w(context),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              child: Text(loc.reset),
                            ),
                          ),
                          SizedBox(width: 12.w(context)),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.h(context),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    12.w(context),
                                  ),
                                ),
                                elevation: 0,
                                textStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.w(context),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              child: Text(loc.apply),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.w(context),
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDeep,
      ),
    );
  }

  TextStyle _labelStyle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.w(context),
      fontWeight: FontWeight.w500,
      color: AppColors.textHint,
    );
  }

  Widget _buildCheckboxOption(
    BuildContext context,
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Container(
            width: 22.w(context),
            height: 22.w(context),
            decoration: BoxDecoration(
              color: value ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(6.w(context)),
              border: Border.all(
                color: value ? AppColors.primary : AppColors.border,
                width: 1.5,
              ),
            ),
            child: value
                ? Icon(Icons.check, size: 14.w(context), color: Colors.white)
                : null,
          ),
          SizedBox(width: 12.w(context)),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.w(context),
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(BuildContext context, String label, String value) {
    final isSelected = _sortBy == value;
    return GestureDetector(
      onTap: () => setState(() => _sortBy = value),
      child: Row(
        children: [
          Container(
            width: 22.w(context),
            height: 22.w(context),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: 1.5,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10.w(context),
                      height: 10.w(context),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 12.w(context)),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.w(context),
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeChip(BuildContext context, String label, String value) {
    final selected = _deliveryTime == value;
    return GestureDetector(
      onTap: () => setState(() => _deliveryTime = value),
      child: Container(
        width: 100.w(context),
        padding: EdgeInsets.symmetric(vertical: 12.h(context)),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryTint : AppColors.surfaceF5,
          borderRadius: BorderRadius.circular(12.w(context)),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.w(context),
              fontWeight: FontWeight.w600,
              color: selected ? AppColors.primary : AppColors.textPrimaryDeep,
            ),
          ),
        ),
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      _freeDelivery = false;
      _fastDelivery = false;
      _sortBy = 'popular';
      _deliveryTime = '30';
      _price = 60;
    });
  }
}
