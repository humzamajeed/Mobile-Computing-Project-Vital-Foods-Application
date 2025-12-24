import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';
import 'package:finalproject/presentation/providers/cart_provider.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';
import 'package:finalproject/domain/entities/cart_item.dart';

/// Cart Screen - Shows cart items and checkout
/// Design: Figma node-id=192-485
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    // Load cart when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      if (authProvider.user != null) {
        cartProvider.loadCart(authProvider.user!.id);
      }
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
          AppLocalizations.of(context)!.cart,
          style: TextStyle(
            fontFamily: 'Sen',
            fontSize: 17.sp(context),
            color: AppColors.white,
            height: 22 / 17,
          ),
        ),
      ),
      body: Consumer2<CartProvider, AuthProvider>(
        builder: (context, cartProvider, authProvider, _) {
          if (authProvider.user == null) {
            return _buildEmptyCart(context);
          }

          // Reload cart to ensure we have latest data
          if (cartProvider.cart == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cartProvider.loadCart(authProvider.user!.id);
            });
            return const Center(child: CircularProgressIndicator());
          }

          final cartItems = cartProvider.items;
          debugPrint('🛒 Cart screen: ${cartItems.length} items in cart');

          if (cartProvider.isEmpty) {
            return _buildEmptyCart(context);
          }

          return Column(
            children: [
              // Scrollable food items list
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w(context),
                    vertical: 20.h(context),
                  ),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < cartItems.length - 1
                            ? 32.h(context)
                            : 0,
                      ),
                      child: _CartItemWidget(
                        item: cartItems[index],
                        onRemove: () async {
                          if (authProvider.user != null) {
                            await cartProvider.removeFromCart(
                              userId: authProvider.user!.id,
                              itemId: cartItems[index].id,
                            );
                          }
                        },
                        onQuantityChanged: (newQuantity) async {
                          if (authProvider.user != null) {
                            if (newQuantity <= 0) {
                              await cartProvider.removeFromCart(
                                userId: authProvider.user!.id,
                                itemId: cartItems[index].id,
                              );
                            } else {
                              await cartProvider.updateCartItemQuantity(
                                userId: authProvider.user!.id,
                                itemId: cartItems[index].id,
                                quantity: newQuantity,
                              );
                            }
                          }
                        },
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
                              '${AppLocalizations.of(context)!.total}: ',
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 14.sp(context),
                                color: AppColors.textHint,
                                height: 24 / 14,
                              ),
                            ),
                            Text(
                              '\$${cartProvider.totalPrice.toStringAsFixed(0)}',
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
                            AppLocalizations.of(
                              context,
                            )!.checkout.toUpperCase(),
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
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100.w(context),
            color: AppColors.white.withValues(alpha: 0.5),
          ),
          SizedBox(height: 24.h(context)),
          Text(
            loc.emptyCart,
            style: TextStyle(
              fontFamily: 'Sen',
              fontSize: 20.sp(context),
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 8.h(context)),
          Text(
            loc.startShopping,
            style: TextStyle(
              fontFamily: 'Sen',
              fontSize: 14.sp(context),
              color: AppColors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final Function(int) onQuantityChanged;

  const _CartItemWidget({
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
              imageUrl: item.imageUrl,
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
                    item.foodName,
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 18.sp(context),
                      color: AppColors.white,
                    ),
                  ),

                  SizedBox(height: 5.h(context)),

                  // Price
                  Text(
                    '\$${item.price.toStringAsFixed(0)}',
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
                        item.size ?? "14''",
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
                            onTap: () => onQuantityChanged(item.quantity - 1),
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
                            '${item.quantity}',
                            style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 16.sp(context),
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(width: 19.w(context)),
                          GestureDetector(
                            onTap: () => onQuantityChanged(item.quantity + 1),
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
