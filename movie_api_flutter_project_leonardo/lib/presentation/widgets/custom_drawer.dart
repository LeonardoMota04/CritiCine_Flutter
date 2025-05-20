import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants/app_theme.dart';
import '../viewmodels/theme_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeViewModel = Provider.of<ThemeViewModel>(context);
    final authProvider = Provider.of<AuthViewModel>(context);
    final user = authProvider.user;
    final theme = Theme.of(context);

    return Drawer(
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: Column(
          children: [
            _buildUserHeader(context, user),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppTheme.borderRadius),
                    topRight: Radius.circular(AppTheme.borderRadius),
                  ),
                ),
                child: Column(
                  children: [
                    _buildDrawerItems(context),
                    const Spacer(),
                    _buildThemeToggle(context, themeViewModel),
                    _buildLogoutButton(context, authProvider),
                    const SizedBox(height: AppTheme.padding),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context, User? user) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.padding),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: theme.cardColor,
              backgroundImage: user?.photoURL != null 
                ? NetworkImage(user!.photoURL!) 
                : null,
              child: user?.photoURL == null 
                ? Text(
                    user?.displayName?.substring(0, 1).toUpperCase() ?? "U",
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeXXLarge,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  )
                : null,
            ),
            const SizedBox(height: AppTheme.padding),
            Text(
              user?.displayName ?? "Usuário",
              style: TextStyle(
                fontSize: AppTheme.fontSizeLarge,
                fontWeight: FontWeight.bold,
                color: theme.cardColor,
              ),
            ),
            const SizedBox(height: AppTheme.paddingSmall),
            Text(
              user?.email ?? "",
              style: TextStyle(
                fontSize: AppTheme.fontSizeMedium,
                color: theme.cardColor.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItems(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        _buildDrawerItem(
          icon: Icons.home_rounded,
          title: "Início",
          onTap: () => Navigator.pop(context),
        ),
        _buildDrawerItem(
          icon: Icons.favorite_rounded,
          title: "Favoritos",
          onTap: () {
            Navigator.pop(context);
            // TODO: Implementar navegação para favoritos
          },
        ),
        _buildDrawerItem(
          icon: Icons.history_rounded,
          title: "Histórico",
          onTap: () {
            Navigator.pop(context);
            // TODO: Implementar navegação para histórico
          },
        ),
        _buildDrawerItem(
          icon: Icons.settings_rounded,
          title: "Configurações",
          onTap: () {
            Navigator.pop(context);
            // TODO: Implementar navegação para configurações
          },
        ),
        Divider(
          height: AppTheme.padding,
          color: theme.dividerColor,
        ),
        _buildDrawerItem(
          icon: Icons.info_rounded,
          title: "Sobre",
          onTap: () {
            Navigator.pop(context);
            // TODO: Implementar navegação para sobre
          },
        ),
      ],
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        
        return ListTile(
          leading: Icon(
            icon,
            color: theme.primaryColor,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: AppTheme.fontSizeMedium,
              fontWeight: FontWeight.w500,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
          ),
        );
      }
    );
  }

  Widget _buildThemeToggle(BuildContext context, ThemeViewModel themeViewModel) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppTheme.padding,
            vertical: AppTheme.paddingSmall,
          ),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          ),
          child: ListTile(
            leading: Icon(
              themeViewModel.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: theme.primaryColor,
            ),
            title: Text(
              themeViewModel.isDarkMode ? "Modo claro" : "Modo escuro",
              style: TextStyle(
                fontSize: AppTheme.fontSizeMedium,
                fontWeight: FontWeight.w500,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            onTap: () {
              themeViewModel.toggleTheme();
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            ),
          ),
        );
      }
    );
  }

  Widget _buildLogoutButton(BuildContext context, AuthViewModel authProvider) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppTheme.padding,
            vertical: AppTheme.paddingSmall,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          ),
          child: ListTile(
            leading: Icon(
              Icons.logout_rounded,
              color: theme.colorScheme.error,
            ),
            title: Text(
              "Sair",
              style: TextStyle(
                fontSize: AppTheme.fontSizeMedium,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.error,
              ),
            ),
            onTap: () async {
              Navigator.pop(context);
              await authProvider.signOut();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            ),
          ),
        );
      }
    );
  }
} 