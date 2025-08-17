import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lightspot_v1/common/theme/app_colors.dart';
import 'package:lightspot_v1/common/util/nav.dart';
import 'package:lightspot_v1/features/auth/presentation/pages/login_screen.dart';
import '../../../../common/data/app_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = true;
  bool _locationServices = true;
  bool _autoSavePhotos = false;
  bool _showPopularSpots = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            // Main Content
            Expanded(
              child: _buildMainContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGray,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        children: [
          // Profile Section
          _buildProfileSection(),
          // Account Section
          _buildAccountSection(),
          // Appearance Section
          _buildAppearanceSection(),
          // Map Preferences Section
          _buildMapPreferencesSection(),
          // Content Preferences Section
          _buildContentPreferencesSection(),
          // Support & About Section
          _buildSupportSection(),
          // Logout Button
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGray,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: AppColors.accent,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-3.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Alex Johnson',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '@alexphotospot',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.accent,
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

  Widget _buildAccountSection() {
    return _buildSection(
      title: 'ACCOUNT',
      children: [
        _buildSettingItem(
          icon: FontAwesomeIcons.user,
          iconColor: Colors.blue,
          title: 'Personal Information',
          hasArrow: true,
          onTap: () {},
        ),
        _buildSettingItem(
          icon: FontAwesomeIcons.shieldHalved,
          iconColor: Colors.green,
          title: 'Security',
          hasArrow: true,
          onTap: () {},
        ),
        _buildSettingItem(
          icon: FontAwesomeIcons.bell,
          iconColor: Colors.purple,
          title: 'Notifications',
          hasArrow: true,
          onTap: () {},
        ),
        _buildSettingItem(
          icon: FontAwesomeIcons.lock,
          iconColor: Colors.red,
          title: 'Privacy',
          hasArrow: true,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildAppearanceSection() {
    return _buildSection(
      title: 'APPEARANCE',
      children: [
        _buildSettingItem(
          icon: FontAwesomeIcons.moon,
          iconColor: Colors.indigo,
          title: 'Dark Mode',
          hasToggle: true,
          toggleValue: _darkMode,
          onToggleChanged: (value) {
            setState(() {
              _darkMode = value;
            });
          },
        ),
        _buildSettingItem(
          icon: FontAwesomeIcons.palette,
          iconColor: Colors.amber,
          title: 'Theme',
          hasValue: true,
          value: 'Midnight',
          hasArrow: true,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildMapPreferencesSection() {
    return _buildSection(
      title: 'MAP PREFERENCES',
      children: [
        _buildSettingItem(
          icon: FontAwesomeIcons.mapPin,
          iconColor: Colors.blue,
          title: 'Default Map View',
          hasValue: true,
          value: 'Satellite',
          hasArrow: true,
          onTap: () {},
        ),
        _buildSettingItem(
          icon: FontAwesomeIcons.locationCrosshairs,
          iconColor: Colors.teal,
          title: 'Location Services',
          hasToggle: true,
          toggleValue: _locationServices,
          onToggleChanged: (value) {
            setState(() {
              _locationServices = value;
            });
          },
        ),
        _buildSettingItem(
          icon: FontAwesomeIcons.compass,
          iconColor: Colors.orange,
          title: 'Distance Units',
          hasValue: true,
          value: 'Kilometers',
          hasArrow: true,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildContentPreferencesSection() {
    return _buildSection(
      title: 'CONTENT PREFERENCES',
      children: [
        _buildSettingItem(
          icon: FontAwesomeIcons.camera,
          iconColor: Colors.pink,
          title: 'Auto-Save Photos',
          hasToggle: true,
          toggleValue: _autoSavePhotos,
          onToggleChanged: (value) {
            setState(() {
              _autoSavePhotos = value;
            });
          },
        ),
        _buildSettingItem(
          icon: FontAwesomeIcons.eye,
          iconColor: Colors.green,
          title: 'Show Popular Spots',
          hasToggle: true,
          toggleValue: _showPopularSpots,
          onToggleChanged: (value) {
            setState(() {
              _showPopularSpots = value;
            });
          },
        ),
        _buildSettingItem(
          icon: FontAwesomeIcons.language,
          iconColor: Colors.purple,
          title: 'Language',
          hasValue: true,
          value: 'English',
          hasArrow: true,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return _buildSection(
      title: 'SUPPORT & ABOUT',
      children: [
        _buildSettingItem(
          icon: FontAwesomeIcons.circleInfo,
          iconColor: Colors.blue,
          title: 'Help Center',
          hasArrow: true,
          onTap: () {},
        ),
        _buildSettingItem(
          icon: FontAwesomeIcons.message,
          iconColor: Colors.green,
          title: 'Report a Problem',
          hasArrow: true,
          onTap: () {},
        ),
        _buildSettingItem(
          icon: FontAwesomeIcons.book,
          iconColor: Colors.purple,
          title: 'Terms of Service',
          hasArrow: true,
          onTap: () {},
        ),
        _buildSettingItem(
          icon: FontAwesomeIcons.code,
          iconColor: Colors.grey,
          title: 'Version',
          hasValue: true,
          value: '2.4.1',
          hasArrow: false,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[400],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.darkGray,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    bool hasArrow = false,
    bool hasToggle = false,
    bool hasValue = false,
    String? value,
    bool? toggleValue,
    VoidCallback? onTap,
    ValueChanged<bool>? onToggleChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGray,
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 16,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasValue) ...[
              Text(
                value!,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
            ],
            if (hasToggle) ...[
              Switch(
                value: toggleValue!,
                onChanged: onToggleChanged,
                activeColor: AppColors.accent,
                activeTrackColor: AppColors.accent.withOpacity(0.3),
                inactiveTrackColor: Colors.grey[700],
                inactiveThumbColor: Colors.grey[400],
              ),
            ] else if (hasArrow) ...[
              Icon(
                FontAwesomeIcons.chevronRight,
                color: Colors.grey[500],
                size: 14,
              ),
            ],
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.all(24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => _handleLogout(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkGray,
            foregroundColor: AppColors.accent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          icon: const Icon(FontAwesomeIcons.rightFromBracket),
          label: const Text(
            'Log Out',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.darkGray,
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'Logout',
                style: TextStyle(color: AppColors.accent),
              ),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      // Clear authentication data using AppPreferences
      await AppPreferences.clearAuthData();
      
      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Successfully logged out'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        
        // Navigate to login screen
        NavHelper.pushReplacement(page: const LoginScreen(), context: context);
      }
    }
  }
}
