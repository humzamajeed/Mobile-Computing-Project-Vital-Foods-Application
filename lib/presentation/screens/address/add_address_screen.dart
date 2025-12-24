import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/constants/app_assets.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';

/// Add Address Screen
/// Design: Figma - Add address with map
class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedLabel = '';
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  bool _isDefault = false;

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  void _saveAddress(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (_formKey.currentState!.validate()) {
      // Save address (UI only, no backend)
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.saveAddress),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (_selectedLabel.isEmpty) {
      _selectedLabel = loc.home;
    }
    final headerHeight = 109.h(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Scrollable content
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: headerHeight),

                  // Map image with location icon
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 250.h(context),
                        child: Image.asset(
                          AppAssets.mapAddress,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Red location icon at center
                      Positioned.fill(
                        child: Center(
                          child: Icon(
                            Icons.location_on,
                            size: 40.w(context),
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h(context)),

                  // Form fields
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Label dropdown
                          FormField<String>(
                            initialValue: _selectedLabel,
                            builder: (field) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  labelText: loc.addressLabel,
                                  labelStyle: TextStyle(
                                    fontFamily: 'Sen',
                                    fontSize: 14.w(context),
                                    color: AppColors.textHint,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.w(context),
                                    ),
                                  ),
                                  errorText: field.errorText,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedLabel,
                                    isDense: true,
                                    items: [
                                      DropdownMenuItem(
                                        value: loc.home,
                                        child: Text(
                                          loc.home,
                                          style: TextStyle(
                                            fontFamily: 'Sen',
                                            fontSize: 16.w(context),
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: loc.office,
                                        child: Text(
                                          loc.office,
                                          style: TextStyle(
                                            fontFamily: 'Sen',
                                            fontSize: 16.w(context),
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: loc.other,
                                        child: Text(
                                          loc.other,
                                          style: TextStyle(
                                            fontFamily: 'Sen',
                                            fontSize: 16.w(context),
                                          ),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedLabel = value ?? loc.home;
                                      });
                                      field.didChange(value);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 24.h(context)),

                          // Address line
                          TextFormField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              labelText: loc.streetAddress,
                              labelStyle: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 14.w(context),
                                color: AppColors.textHint,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10.w(context),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24.h(context)),

                          // City
                          TextFormField(
                            controller: _cityController,
                            decoration: InputDecoration(
                              labelText: loc.city,
                              labelStyle: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 14.w(context),
                                color: AppColors.textHint,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10.w(context),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter city';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24.h(context)),

                          // State and Zip Code row
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  controller: _stateController,
                                  decoration: InputDecoration(
                                    labelText: loc.state,
                                    labelStyle: TextStyle(
                                      fontFamily: 'Sen',
                                      fontSize: 14.w(context),
                                      color: AppColors.textHint,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        10.w(context),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 16.w(context)),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  controller: _zipCodeController,
                                  decoration: InputDecoration(
                                    labelText: loc.zipCode,
                                    labelStyle: TextStyle(
                                      fontFamily: 'Sen',
                                      fontSize: 14.w(context),
                                      color: AppColors.textHint,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        10.w(context),
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 32.h(context)),

                          // Set as default checkbox
                          CheckboxListTile(
                            title: Text(
                              loc.setAsDefault,
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 16.w(context),
                              ),
                            ),
                            value: _isDefault,
                            onChanged: (value) {
                              setState(() {
                                _isDefault = value ?? false;
                              });
                            },
                            activeColor: AppColors.primary,
                          ),

                          SizedBox(height: 32.h(context)),

                          // Save button
                          ElevatedButton(
                            onPressed: () => _saveAddress(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              minimumSize: Size(double.infinity, 62.h(context)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10.w(context),
                                ),
                              ),
                            ),
                            child: Text(
                              loc.saveAddress,
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 16.w(context),
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                          ),

                          SizedBox(height: 32.h(context)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: headerHeight,
              color: AppColors.white,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
                  child: Row(
                    children: [
                      // Back button
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
                            Icons.arrow_back_ios_new,
                            size: 20.w(context),
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),

                      SizedBox(width: 18.w(context)),

                      // Title
                      Text(
                        'Add Address',
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
        ],
      ),
    );
  }
}
