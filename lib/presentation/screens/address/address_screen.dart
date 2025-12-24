import 'package:flutter/material.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';

/// Address Screen
/// Design: Figma node-id=226-68
/// Shows saved addresses with edit/delete options
class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final List<Map<String, dynamic>> mockAddresses = [
      {
        'id': '1',
        'label': 'Home',
        'address': '123 Main Street, Apartment 4B',
        'city': 'New York',
        'state': 'NY',
        'zipCode': '10001',
        'isDefault': true,
      },
      {
        'id': '2',
        'label': 'Office',
        'address': 'Halal Lab office',
        'city': 'New York',
        'state': 'NY',
        'zipCode': '10002',
        'isDefault': false,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(loc.addresses),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-address');
            },
          ),
        ],
      ),
      body: mockAddresses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 80,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 16.h(context)),
                  Text(
                    loc.noAddressesSaved,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 24.h(context)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/add-address');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w(context),
                        vertical: 16.h(context),
                      ),
                    ),
                    child: Text(
                      loc.addAddress,
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 16.w(context),
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(24.w(context)),
              itemCount: mockAddresses.length,
              itemBuilder: (context, index) {
                return _AddressCard(address: mockAddresses[index]);
              },
            ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final Map<String, dynamic> address;

  const _AddressCard({required this.address});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      margin: EdgeInsets.only(bottom: 24.h(context)),
      padding: EdgeInsets.all(16.w(context)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(15.w(context)),
        border: address['isDefault']
            ? Border.all(color: AppColors.primary, width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label and default badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    address['label'] == 'Home'
                        ? Icons.home
                        : address['label'] == 'Office'
                        ? Icons.work
                        : Icons.location_on,
                    color: AppColors.primary,
                    size: 24.w(context),
                  ),
                  SizedBox(width: 12.w(context)),
                  Text(
                    address['label'],
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 18.w(context),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (address['isDefault']) ...[
                    SizedBox(width: 12.w(context)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w(context),
                        vertical: 4.h(context),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4.w(context)),
                      ),
                      child: Text(
                        loc.defaultLabel,
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 12.w(context),
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: AppColors.primary,
                      size: 24.w(context),
                    ),
                    onPressed: () {
                      // Edit address (UI only)
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: AppColors.error,
                      size: 24.w(context),
                    ),
                    onPressed: () {
                      // Delete address (UI only)
                    },
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 12.h(context)),

          // Address details
          Text(
            address['address'],
            style: TextStyle(
              fontFamily: 'Sen',
              fontSize: 14.w(context),
              color: AppColors.textPrimary,
            ),
          ),

          SizedBox(height: 4.h(context)),

          Text(
            '${address['city']}, ${address['state']} ${address['zipCode']}',
            style: TextStyle(
              fontFamily: 'Sen',
              fontSize: 14.w(context),
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }
}
