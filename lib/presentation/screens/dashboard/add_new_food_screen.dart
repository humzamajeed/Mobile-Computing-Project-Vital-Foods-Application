import 'package:flutter/material.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_text_styles.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';

/// Add New Food Items Screen (Figma node 601-1776)
class AddNewFoodScreen extends StatefulWidget {
  const AddNewFoodScreen({super.key});

  @override
  State<AddNewFoodScreen> createState() => _AddNewFoodScreenState();
}

class _AddNewFoodScreenState extends State<AddNewFoodScreen> {
  final TextEditingController _nameController = TextEditingController(
    text: 'Mazalichiken Halim',
  );
  final TextEditingController _priceController = TextEditingController(
    text: '\$50',
  );
  final TextEditingController _detailsController = TextEditingController(
    text:
        'Lorem Ipsum dolor sit amet, consectetur adipiscing elit. Blandum vel mattis id mauris turpis.',
  );
  bool _isPickup = true;
  bool _isDelivery = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          'Add New Items',
          style: AppTextStyles.titleMedium.copyWith(
            fontSize: 16.sp(context),
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              _nameController.clear();
              _priceController.clear();
              _detailsController.clear();
              setState(() {
                _isPickup = false;
                _isDelivery = false;
              });
            },
            child: Text(
              'RESET',
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14.sp(context),
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel(context, 'ITEM NAME'),
                  SizedBox(height: 8.h(context)),
                  _buildTextField(context, _nameController, 'Item Name'),
                  SizedBox(height: 20.h(context)),
                  _buildSectionLabel(context, 'UPLOAD PHOTO/VIDEO'),
                  SizedBox(height: 12.h(context)),
                  _buildPhotoUploadSection(context),
                  SizedBox(height: 20.h(context)),
                  _buildSectionLabel(context, 'PRICE'),
                  SizedBox(height: 8.h(context)),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildTextField(
                          context,
                          _priceController,
                          'Price',
                        ),
                      ),
                      SizedBox(width: 12.w(context)),
                      Expanded(
                        flex: 2,
                        child: _buildCheckboxOption(
                          context,
                          'Pick up',
                          _isPickup,
                          (val) {
                            setState(() => _isPickup = val ?? false);
                          },
                        ),
                      ),
                      SizedBox(width: 12.w(context)),
                      Expanded(
                        flex: 2,
                        child: _buildCheckboxOption(
                          context,
                          'Delivery',
                          _isDelivery,
                          (val) {
                            setState(() => _isDelivery = val ?? false);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h(context)),
                  _buildIngredientsSection(context),
                  SizedBox(height: 20.h(context)),
                  _buildSectionLabel(context, 'DETAILS'),
                  SizedBox(height: 8.h(context)),
                  _buildMultilineTextField(context, _detailsController),
                  SizedBox(height: 20.h(context)),
                ],
              ),
            ),
          ),
          _buildSaveButton(context),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Text(
      label,
      style: AppTextStyles.labelMedium.copyWith(
        fontSize: 12.sp(context),
        color: AppColors.textHint,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    TextEditingController controller,
    String hint,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w(context),
        vertical: 12.h(context),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.w(context)),
        border: Border.all(color: AppColors.border),
      ),
      child: TextField(
        controller: controller,
        style: AppTextStyles.bodyMedium.copyWith(
          fontSize: 14.sp(context),
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration.collapsed(
          hintText: hint,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14.sp(context),
            color: AppColors.textHint,
          ),
        ),
      ),
    );
  }

  Widget _buildMultilineTextField(
    BuildContext context,
    TextEditingController controller,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w(context),
        vertical: 12.h(context),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.w(context)),
        border: Border.all(color: AppColors.border),
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        style: AppTextStyles.bodyMedium.copyWith(
          fontSize: 13.sp(context),
          color: AppColors.textHint,
        ),
        decoration: InputDecoration.collapsed(
          hintText: 'Enter details...',
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            fontSize: 13.sp(context),
            color: AppColors.textHint,
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxOption(
    BuildContext context,
    String label,
    bool value,
    Function(bool?) onChanged,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w(context),
          vertical: 10.h(context),
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.w(context)),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 18.w(context),
              height: 18.w(context),
              decoration: BoxDecoration(
                color: value ? AppColors.primary : AppColors.transparent,
                borderRadius: BorderRadius.circular(4.w(context)),
                border: Border.all(
                  color: value ? AppColors.primary : AppColors.border,
                  width: 2,
                ),
              ),
              child: value
                  ? Icon(
                      Icons.check,
                      size: 12.w(context),
                      color: AppColors.white,
                    )
                  : null,
            ),
            SizedBox(width: 8.w(context)),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 13.sp(context),
                  color: AppColors.textHint,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoUploadSection(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 90.w(context),
          height: 90.w(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.w(context)),
            color: AppColors.surfaceF6,
          ),
          child: CustomNetworkImage(
            imageUrl: AppData.getFoodImage(0), // Default image
            fit: BoxFit.cover,
            borderRadius: 12.w(context),
            width: 90.w(context),
            height: 90.w(context),
          ),
        ),
        SizedBox(width: 12.w(context)),
        _buildUploadButton(context),
        SizedBox(width: 12.w(context)),
        _buildUploadButton(context),
      ],
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return Container(
      width: 90.w(context),
      height: 90.w(context),
      decoration: BoxDecoration(
        color: AppColors.surfaceF6,
        borderRadius: BorderRadius.circular(12.w(context)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_upload_outlined,
            size: 28.w(context),
            color: AppColors.textHint,
          ),
          SizedBox(height: 4.h(context)),
          Text(
            'Add',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 11.sp(context),
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(context, 'INGREDIENTS'),
        SizedBox(height: 12.h(context)),
        _buildIngredientCategory(context, 'Basic', [
          _IngredientData(Icons.restaurant, 'Salt'),
          _IngredientData(Icons.set_meal_rounded, 'Chicken'),
          _IngredientData(Icons.spa_rounded, 'Onion'),
          _IngredientData(Icons.eco_rounded, 'Garlic'),
          _IngredientData(Icons.local_fire_department_rounded, 'Peppers'),
          _IngredientData(Icons.grass_rounded, 'Ginger'),
        ]),
        SizedBox(height: 16.h(context)),
        _buildIngredientCategory(context, 'Fruit', [
          _IngredientData(Icons.food_bank_outlined, 'Avocado'),
          _IngredientData(Icons.apple_rounded, 'Apple'),
          _IngredientData(Icons.circle, 'Blueberry'),
          _IngredientData(Icons.energy_savings_leaf_rounded, 'Broccoli'),
          _IngredientData(Icons.circle_outlined, 'Orange'),
          _IngredientData(Icons.nature_rounded, 'Walnut'),
        ]),
      ],
    );
  }

  Widget _buildIngredientCategory(
    BuildContext context,
    String title,
    List<_IngredientData> ingredients,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14.sp(context),
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Text(
                  'See All',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 13.sp(context),
                    color: AppColors.textHint,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18.w(context),
                  color: AppColors.textHint,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.h(context)),
        Wrap(
          spacing: 12.w(context),
          runSpacing: 12.h(context),
          children: ingredients
              .map((ing) => _buildIngredientItem(context, ing.icon, ing.label))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildIngredientItem(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    return Column(
      children: [
        Container(
          width: 48.w(context),
          height: 48.w(context),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 22.w(context), color: AppColors.primary),
        ),
        SizedBox(height: 4.h(context)),
        SizedBox(
          width: 48.w(context),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 10.sp(context),
              color: AppColors.textHint,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w(context)),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(vertical: 16.h(context)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.w(context)),
            ),
            elevation: 0,
          ),
          child: Text(
            'SAVE CHANGES',
            style: AppTextStyles.titleMedium.copyWith(
              fontSize: 15.sp(context),
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _IngredientData {
  final IconData icon;
  final String label;

  _IngredientData(this.icon, this.label);
}
