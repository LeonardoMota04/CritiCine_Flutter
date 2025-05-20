import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isGridView;
  final VoidCallback onViewToggle;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.isGridView,
    required this.onViewToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppTheme.primaryColor,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppTheme.fontSizeXLarge,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: AppTheme.paddingSmall),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
          ),
          child: IconButton(
            color: Colors.white,
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              onViewToggle();
              HapticFeedback.lightImpact();
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
} 