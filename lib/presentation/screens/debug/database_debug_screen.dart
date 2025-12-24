import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/size_extensions.dart';
import '../../../core/services/database_cleanup_service.dart';
import '../../../core/di/injection_container.dart';

/// Database Debug Screen
/// View and manage database collections at runtime
class DatabaseDebugScreen extends StatefulWidget {
  const DatabaseDebugScreen({super.key});

  @override
  State<DatabaseDebugScreen> createState() => _DatabaseDebugScreenState();
}

class _DatabaseDebugScreenState extends State<DatabaseDebugScreen> {
  final DatabaseCleanupService _cleanupService =
      InjectionContainer().databaseCleanupService;
  Map<String, int> _collectionStats = {};
  final Map<String, List<Map<String, dynamic>>> _collectionData = {};
  bool _isLoading = false;
  String? _selectedCollection;
  bool _showData = false;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final stats = await _cleanupService.getCollectionStats();
      setState(() {
        _collectionStats = stats;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading stats: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _loadCollectionData(String collectionName) async {
    setState(() {
      _isLoading = true;
      _selectedCollection = collectionName;
    });

    try {
      final data = await _cleanupService.getCollectionData(collectionName);
      setState(() {
        _collectionData[collectionName] = data;
        _showData = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading data: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _clearAllCollections() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Collections'),
        content: const Text(
          'This will delete ALL documents from ALL collections. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        _isLoading = true;
      });

      try {
        final success = await _cleanupService.clearAllCollections();
        if (success) {
          await _loadStats();
          setState(() {
            _collectionData.clear();
            _showData = false;
            _selectedCollection = null;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('All collections cleared successfully'),
                backgroundColor: AppColors.success,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error clearing collections: $e'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _clearCollection(String collectionName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear $collectionName'),
        content: Text(
          'This will delete ALL documents from the $collectionName collection. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        _isLoading = true;
      });

      try {
        final success = await _cleanupService.clearCollection(collectionName);
        if (success) {
          await _loadStats();
          if (collectionName == _selectedCollection) {
            setState(() {
              _collectionData.remove(collectionName);
              _showData = false;
            });
          }
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$collectionName cleared successfully'),
                backgroundColor: AppColors.success,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error clearing collection: $e'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
          'Database Debug',
          style: AppTextStyles.titleMedium.copyWith(
            fontSize: 16.sp(context),
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              size: 24.w(context),
              color: AppColors.primary,
            ),
            onPressed: _loadStats,
          ),
        ],
      ),
      body: _isLoading && _collectionStats.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Header with clear all button
                Container(
                  padding: EdgeInsets.all(16.w(context)),
                  color: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Collections',
                        style: AppTextStyles.titleMedium.copyWith(
                          fontSize: 18.sp(context),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _isLoading ? null : _clearAllCollections,
                        icon: const Icon(Icons.delete_sweep, size: 18),
                        label: const Text('Clear All'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Collections list
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.w(context)),
                    itemCount: _collectionStats.length,
                    itemBuilder: (context, index) {
                      final collectionName = _collectionStats.keys.elementAt(
                        index,
                      );
                      final count = _collectionStats[collectionName] ?? 0;
                      final isSelected = _selectedCollection == collectionName;

                      return Card(
                        margin: EdgeInsets.only(bottom: 12.h(context)),
                        child: ExpansionTile(
                          leading: Icon(
                            _getCollectionIcon(collectionName),
                            color: AppColors.primary,
                          ),
                          title: Text(
                            collectionName,
                            style: AppTextStyles.titleSmall.copyWith(
                              fontSize: 16.sp(context),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '$count document${count != 1 ? 's' : ''}',
                            style: AppTextStyles.bodySmall.copyWith(
                              fontSize: 12.sp(context),
                              color: AppColors.textSecondary,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.visibility,
                                  size: 20.w(context),
                                  color: isSelected && _showData
                                      ? AppColors.primary
                                      : AppColors.textHint,
                                ),
                                onPressed: () =>
                                    _loadCollectionData(collectionName),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  size: 20.w(context),
                                  color: AppColors.error,
                                ),
                                onPressed: () =>
                                    _clearCollection(collectionName),
                              ),
                            ],
                          ),
                          children: [
                            if (_showData && isSelected)
                              Container(
                                padding: EdgeInsets.all(16.w(context)),
                                color: AppColors.cardBackground,
                                child:
                                    _collectionData[collectionName]?.isEmpty ??
                                        true
                                    ? Text(
                                        'No documents',
                                        style: AppTextStyles.bodySmall,
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Documents:',
                                            style: AppTextStyles.titleSmall
                                                .copyWith(
                                                  fontSize: 14.sp(context),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          SizedBox(height: 8.h(context)),
                                          ...(_collectionData[collectionName] ??
                                                  [])
                                              .map(
                                                (doc) => Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 8.h(context),
                                                  ),
                                                  padding: EdgeInsets.all(
                                                    12.w(context),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8.r(context),
                                                        ),
                                                    border: Border.all(
                                                      color: AppColors.divider,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'ID: ${doc['id']}',
                                                        style: AppTextStyles
                                                            .bodySmall
                                                            .copyWith(
                                                              fontSize: 11.sp(
                                                                context,
                                                              ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .primary,
                                                            ),
                                                      ),
                                                      SizedBox(
                                                        height: 4.h(context),
                                                      ),
                                                      Text(
                                                        _formatDocumentData(
                                                          doc,
                                                        ),
                                                        style: AppTextStyles
                                                            .bodySmall
                                                            .copyWith(
                                                              fontSize: 11.sp(
                                                                context,
                                                              ),
                                                              color: AppColors
                                                                  .textSecondary,
                                                            ),
                                                        maxLines: 5,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        ],
                                      ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  IconData _getCollectionIcon(String collectionName) {
    switch (collectionName) {
      case 'users':
        return Icons.people;
      case 'carts':
        return Icons.shopping_cart;
      case 'orders':
        return Icons.receipt_long;
      case 'reviews':
        return Icons.star;
      case 'favorites':
        return Icons.favorite;
      case 'addresses':
        return Icons.location_on;
      case 'notifications':
        return Icons.notifications;
      default:
        return Icons.folder;
    }
  }

  String _formatDocumentData(Map<String, dynamic> doc) {
    final buffer = StringBuffer();
    doc.forEach((key, value) {
      if (key != 'id') {
        final valueStr = value is Map
            ? '{...}'
            : value is List
            ? '[...]'
            : value.toString();
        buffer.writeln('$key: $valueStr');
      }
    });
    return buffer.toString();
  }
}
