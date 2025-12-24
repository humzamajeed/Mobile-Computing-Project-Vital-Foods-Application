import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';
import 'package:finalproject/presentation/providers/settings_provider.dart';

/// Edit Profile Screen
/// Design: Figma node-id=190-628
/// Allows user to edit their personal information
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _bioController;
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  String? _uploadedImageUrl;
  bool _isUploadingImage = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current user data
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    _nameController = TextEditingController(text: user?.name ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _phoneController = TextEditingController(text: user?.phoneNumber ?? '');
    _bioController = TextEditingController(
      text: user?.bio ?? 'I love fast food',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top bar
            Container(
              height: 109.h(context),
              color: Colors.white,
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
                            color: AppColors.neutralECF0,
                            borderRadius: BorderRadius.circular(14.w(context)),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 20.w(context),
                            color: AppColors.textPrimaryDeep,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w(context)),
                      Text(
                        AppLocalizations.of(context)!.editProfile,
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 17.w(context),
                          color: AppColors.textPrimaryDeep,
                          height: 22 / 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Profile picture with edit button
            SizedBox(height: 11.h(context)),
            Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                final user = authProvider.user;
                final photoUrl = _selectedImage != null
                    ? _selectedImage!.path
                    : (_uploadedImageUrl ??
                          user?.photoUrl ??
                          AppData.defaultProfileImage);

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _selectedImage != null
                        ? ClipOval(
                            child: Image.file(
                              _selectedImage!,
                              width: 130.w(context),
                              height: 130.h(context),
                              fit: BoxFit.cover,
                            ),
                          )
                        : CustomNetworkImage(
                            imageUrl: photoUrl,
                            width: 130.w(context),
                            height: 130.h(context),
                            borderRadius: 130.w(context), // Circle
                            fit: BoxFit.cover,
                          ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: _isUploadingImage
                            ? null
                            : () => _showImageSourceDialog(context),
                        child: Container(
                          width: 40.w(context),
                          height: 40.h(context),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: _isUploadingImage
                              ? SizedBox(
                                  width: 20.w(context),
                                  height: 20.w(context),
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.edit,
                                  size: 20.w(context),
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 30.h(context)),

            // Form fields
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Full Name
                  _buildEditableField(
                    context,
                    label: loc.fullName.toUpperCase(),
                    controller: _nameController,
                  ),

                  SizedBox(height: 25.h(context)),

                  // Email
                  _buildEditableField(
                    context,
                    label: loc.email.toUpperCase(),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 25.h(context)),

                  // Phone Number
                  _buildEditableField(
                    context,
                    label: loc.phoneNumber.toUpperCase(),
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: 25.h(context)),

                  // Bio
                  _buildEditableField(
                    context,
                    label: 'BIO', // Keep as BIO (not localized)
                    controller: _bioController,
                    maxLines: 5,
                  ),

                  SizedBox(height: 40.h(context)),

                  // Save button
                  Consumer2<AuthProvider, SettingsProvider>(
                    builder: (context, authProvider, settingsProvider, _) {
                      return GestureDetector(
                        onTap: settingsProvider.isLoading
                            ? null
                            : () async {
                                // Save changes to database
                                await settingsProvider.updateProfile(
                                  name: _nameController.text.trim().isNotEmpty
                                      ? _nameController.text.trim()
                                      : null,
                                  email: _emailController.text.trim().isNotEmpty
                                      ? _emailController.text.trim()
                                      : null,
                                  phoneNumber:
                                      _phoneController.text.trim().isNotEmpty
                                      ? _phoneController.text.trim()
                                      : null,
                                  bio: _bioController.text.trim().isNotEmpty
                                      ? _bioController.text.trim()
                                      : null,
                                  photoUrl: _uploadedImageUrl,
                                );

                                if (context.mounted) {
                                  if (settingsProvider.errorMessage != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          settingsProvider.errorMessage!,
                                        ),
                                        backgroundColor: AppColors.error,
                                      ),
                                    );
                                  } else {
                                    // Refresh user data after successful update
                                    await authProvider.refreshUser();

                                    if (context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(loc.save),
                                          backgroundColor: AppColors.success,
                                        ),
                                      );
                                      Navigator.pop(context);
                                    }
                                  }
                                }
                              },
                        child: Container(
                          width: double.infinity,
                          height: 62.h(context),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12.w(context)),
                          ),
                          child: Center(
                            child: settingsProvider.isLoading
                                ? SizedBox(
                                    width: 20.w(context),
                                    height: 20.w(context),
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    loc.save.toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'Sen',
                                      fontSize: 16.w(context),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 40.h(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Sen',
            fontSize: 14.w(context),
            color: AppColors.textDark,
            letterSpacing: 0.26,
          ),
        ),
        SizedBox(height: 15.h(context)),
        Container(
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(
              maxLines > 1 ? 8 : 10.w(context),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w(context),
            vertical: maxLines > 1 ? 16.h(context) : 0,
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: TextStyle(
              fontFamily: 'Sen',
              fontSize: 14.w(context),
              color: AppColors.mutedGrayDeep,
              height: maxLines > 1 ? 24 / 14 : null,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: maxLines > 1 ? 0 : 20.h(context),
              ),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showImageSourceDialog(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.w(context)),
        ),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w(context)),
              child: Text(
                'Select Image Source',
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 18.w(context),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.primary),
              title: Text(
                'Camera',
                style: TextStyle(fontFamily: 'Sen', fontSize: 16.w(context)),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: AppColors.primary),
              title: Text(
                'Gallery',
                style: TextStyle(fontFamily: 'Sen', fontSize: 16.w(context)),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel, color: AppColors.error),
              title: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 16.w(context),
                  color: AppColors.error,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: 8.h(context)),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final loc = AppLocalizations.of(context)!;
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        await _uploadImageToFirebase(_selectedImage!);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.errorPickingImage(e.toString())),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _uploadImageToFirebase(File imageFile) async {
    final loc = AppLocalizations.of(context)!;
    setState(() {
      _isUploadingImage = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final user = authProvider.user;

      if (user == null) {
        throw Exception('User not logged in');
      }

      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child(
        'profile_images/${user.id}_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      await ref.putFile(imageFile);
      final downloadUrl = await ref.getDownloadURL();

      setState(() {
        _uploadedImageUrl = downloadUrl;
        _isUploadingImage = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.imageUploadedSuccessfully),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isUploadingImage = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.errorUploadingImage(e.toString())),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
