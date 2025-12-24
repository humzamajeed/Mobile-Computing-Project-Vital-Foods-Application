import 'package:flutter/material.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';

/// Edit Cart Screen - Edit cart items with quantity controls
/// Design: Figma node-id=190-1705
class EditCartScreen extends StatefulWidget {
  const EditCartScreen({super.key});

  @override
  State<EditCartScreen> createState() => _EditCartScreenState();
}

class _EditCartScreenState extends State<EditCartScreen> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'name': 'pizza calzone european',
      'price': 64,
      'quantity': 1,
      'imageIndex': 0,
    },
    {
      'id': '2',
      'name': 'pizza calzone european',
      'price': 32,
      'quantity': 1,
      'imageIndex': 1,
    },
  ];

  double get _totalPrice {
    return _cartItems.fold(0.0, (sum, item) {
      return sum + (item['price'] * item['quantity'] as int);
    });
  }

  void _updateQuantity(int index, int newQuantity) {
    if (newQuantity <= 0) {
      setState(() {
        _cartItems.removeAt(index);
      });
      return;
    }
    setState(() {
      _cartItems[index]['quantity'] = newQuantity;
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.white,
            size: 20.w(context),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Cart',
          style: TextStyle(
            fontFamily: 'Sen',
            fontSize: 17.sp(context),
            color: AppColors.white,
            height: 22 / 17,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'EDIT Items',
              style: TextStyle(
                fontFamily: 'Sen',
                fontSize: 14.sp(context),
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                decoration: TextDecoration.underline,
                height: 24 / 14,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Food items list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w(context),
                vertical: 20.h(context),
              ),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < _cartItems.length - 1 ? 32.h(context) : 0,
                  ),
                  child: _EditCartItemWidget(
                    item: _cartItems[index],
                    onRemove: () => _removeItem(index),
                    onQuantityChanged: (newQuantity) =>
                        _updateQuantity(index, newQuantity),
                  ),
                );
              },
            ),
          ),

          // White bottom section (Info section)
          Container(
            padding: EdgeInsets.only(
              top: 24.h(context),
              left: 24.w(context),
              right: 24.w(context),
              bottom: MediaQuery.of(context).padding.bottom + 24.h(context),
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.w(context)),
                topRight: Radius.circular(24.w(context)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Delivery Address
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DELIVERY ADDRESS',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 14.sp(context),
                        color: AppColors.textHint,
                        height: 24 / 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/address');
                      },
                      child: Text(
                        'EDIT',
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 14.sp(context),
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                          height: 24 / 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h(context)),
                Container(
                  height: 62.h(context),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceF6,
                    borderRadius: BorderRadius.circular(10.w(context)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w(context)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '2118 Thornridge Cir. Syracuse',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 16.sp(context),
                        color: AppColors.textDark.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h(context)),

                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total: ',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 14.sp(context),
                            color: AppColors.textHint,
                            height: 24 / 14,
                          ),
                        ),
                        Text(
                          '\$${_totalPrice.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 30.sp(context),
                            color: AppColors.textPrimaryDeep,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // Show breakdown
                      },
                      child: Row(
                        children: [
                          Text(
                            'breakdown',
                            style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 14.sp(context),
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 4.w(context)),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 10.w(context),
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h(context)),

                // Place Order button
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pushNamed(context, '/payment');
                  },
                  child: Container(
                    width: double.infinity,
                    height: 62.h(context),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12.w(context)),
                    ),
                    child: Center(
                      child: Text(
                        'PLACE ORDER',
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 14.sp(context),
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                          letterSpacing: 0.5.w(context),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EditCartItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onRemove;
  final Function(int) onQuantityChanged;

  const _EditCartItemWidget({
    required this.item,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food image - 136x117px
            CustomNetworkImage(
              imageUrl: AppData.getFoodImage(item['imageIndex']),
              width: 136.w(context),
              height: 117.h(context),
              borderRadius: 15.w(context),
              fit: BoxFit.cover,
            ),

            SizedBox(width: 22.w(context)),

            // Food details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food name
                  Text(
                    item['name'],
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 18.sp(context),
                      color: AppColors.white,
                    ),
                  ),

                  SizedBox(height: 5.h(context)),

                  // Price
                  Text(
                    '\$${item['price']}',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 20.sp(context),
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),

                  SizedBox(height: 5.h(context)),

                  // Size and quantity controls
                  Row(
                    children: [
                      Text(
                        "14''",
                        style: TextStyle(
                          fontFamily: 'Sen',
                          fontSize: 18.sp(context),
                          color: AppColors.white.withValues(alpha: 0.5),
                        ),
                      ),
                      SizedBox(width: 40.w(context)),
                      // Quantity controls
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                onQuantityChanged(item['quantity'] - 1),
                            child: Container(
                              width: 22.w(context),
                              height: 22.w(context),
                              decoration: BoxDecoration(
                                color: AppColors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 12.w(context),
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 19.w(context)),
                          Text(
                            '${item['quantity']}',
                            style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 16.sp(context),
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(width: 19.w(context)),
                          GestureDetector(
                            onTap: () =>
                                onQuantityChanged(item['quantity'] + 1),
                            child: Container(
                              width: 22.w(context),
                              height: 22.w(context),
                              decoration: BoxDecoration(
                                color: AppColors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 12.w(context),
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        // Remove button (X icon) - positioned at top right
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 27.w(context),
              height: 27.w(context),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 16.w(context),
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
