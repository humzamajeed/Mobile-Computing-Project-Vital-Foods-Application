import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/l10n/app_localizations.dart';
import 'package:finalproject/core/constants/app_colors.dart';
import 'package:finalproject/core/extensions/size_extensions.dart';
import 'package:finalproject/core/data/app_data.dart';
import 'package:finalproject/presentation/widgets/custom_network_image.dart';
import 'package:finalproject/presentation/providers/order_provider.dart';
import 'package:finalproject/presentation/providers/auth_provider.dart';
import 'package:finalproject/domain/entities/order.dart';

/// My Orders Screen - Shows ongoing and history of orders
/// Design: Figma node-id=149-65
class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    // Load orders when screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.user != null) {
        final orderProvider = Provider.of<OrderProvider>(
          context,
          listen: false,
        );
        orderProvider.loadUserOrders(authProvider.user!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: Text(loc.myOrders)),
      body: Consumer2<OrderProvider, AuthProvider>(
        builder: (context, orderProvider, authProvider, _) {
          if (orderProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (orderProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 80, color: AppColors.error),
                  SizedBox(height: 16.h(context)),
                  Text(
                    orderProvider.errorMessage!,
                    style: TextStyle(fontSize: 16, color: AppColors.error),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h(context)),
                  ElevatedButton(
                    onPressed: () {
                      if (authProvider.user != null) {
                        orderProvider.loadUserOrders(authProvider.user!.id);
                      }
                    },
                    child: Text(loc.retry),
                  ),
                ],
              ),
            );
          }

          final ongoingOrders = orderProvider.ongoingOrders;
          final orderHistory = orderProvider.orderHistory;
          final allOrdersEmpty = orderProvider.orders.isEmpty;

          // Show empty state if no orders at all
          if (allOrdersEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 100.w(context),
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 24.h(context)),
                  Text(
                    'No orders',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 20.w(context),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h(context)),
                  Text(
                    'You haven\'t placed any orders yet',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 16.w(context),
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  tabs: const [
                    Tab(text: 'Ongoing'),
                    Tab(text: 'History'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Ongoing orders
                      ongoingOrders.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.receipt_long_outlined,
                                    size: 80,
                                    color: AppColors.textSecondary,
                                  ),
                                  SizedBox(height: 16.h(context)),
                                  Text(
                                    'No ongoing orders',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(24.w(context)),
                              itemCount: ongoingOrders.length,
                              itemBuilder: (context, index) {
                                return _OrderCard(
                                  order: ongoingOrders[index],
                                  isHistory: false,
                                );
                              },
                            ),

                      // Order history
                      orderHistory.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.history,
                                    size: 80,
                                    color: AppColors.textSecondary,
                                  ),
                                  SizedBox(height: 16.h(context)),
                                  Text(
                                    'No order history',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(24.w(context)),
                              itemCount: orderHistory.length,
                              itemBuilder: (context, index) {
                                return _OrderCard(
                                  order: orderHistory[index],
                                  isHistory: true,
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;
  final bool isHistory;

  const _OrderCard({required this.order, required this.isHistory});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h(context)),
      padding: EdgeInsets.all(16.w(context)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(15.w(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h(context)),

          // Order items with images
          ...order.items.map<Widget>((item) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h(context)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food item image
                  CustomNetworkImage(
                    imageUrl: item.imageUrl.isNotEmpty
                        ? item.imageUrl
                        : AppData.restaurantImages[0],
                    width: 50.w(context),
                    height: 50.w(context),
                    borderRadius: 10.w(context),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 12.w(context)),
                  // Food item details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.foodName,
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 14.w(context),
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (item.size != null) ...[
                          SizedBox(height: 2.h(context)),
                          Text(
                            'Size: ${item.size}',
                            style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 12.w(context),
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                        SizedBox(height: 4.h(context)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Qty: ${item.quantity}',
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 12.w(context),
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 14.w(context),
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: 16.h(context)),

          // Total and action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${order.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontFamily: 'Sen',
                  fontSize: 18.w(context),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              if (!isHistory && order.status != 'delivered')
                TextButton(
                  onPressed: () async {
                    // Show confirmation dialog
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) {
                        final dialogLoc = AppLocalizations.of(dialogContext)!;
                        return AlertDialog(
                          title: Text(dialogLoc.cancelOrder),
                          content: Text(dialogLoc.areYouSureCancelOrder),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(false),
                              child: Text(dialogLoc.no),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(true),
                              child: Text(
                                dialogLoc.yes,
                                style: const TextStyle(color: AppColors.error),
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmed == true && context.mounted) {
                      final orderProvider = Provider.of<OrderProvider>(
                        context,
                        listen: false,
                      );
                      final authProvider = Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      );

                      // Delete order from database
                      final success = await orderProvider.deleteOrder(order.id);

                      if (success) {
                        // Reload orders from database to ensure deletion is reflected
                        if (authProvider.user != null) {
                          await orderProvider.loadUserOrders(
                            authProvider.user!.id,
                          );
                        }

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Order cancelled and removed successfully',
                              ),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                orderProvider.errorMessage ??
                                    'Failed to cancel order',
                              ),
                              backgroundColor: AppColors.error,
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 14.w(context),
                      color: AppColors.error,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
