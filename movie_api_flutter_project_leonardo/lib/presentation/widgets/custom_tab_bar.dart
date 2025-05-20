import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';

class CustomTabBar extends StatelessWidget {
  final TabController controller;

  const CustomTabBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        boxShadow: AppTheme.defaultShadow,
      ),
      child: TabBar(
        controller: controller,
        tabs: const [
          Tab(
            icon: Icon(Icons.movie_rounded),
            text: "Em Cartaz",
          ),
          Tab(
            icon: Icon(Icons.bookmark_rounded),
            text: "Para Assistir",
          ),
        ],
        labelColor: AppTheme.primaryColor,
        unselectedLabelColor: AppTheme.textSecondaryColor,
        indicatorColor: AppTheme.primaryColor,
        indicatorWeight: 3,
        labelStyle: const TextStyle(
          fontSize: AppTheme.fontSizeMedium,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: AppTheme.fontSizeMedium,
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
} 