import 'package:flutter/material.dart';
import 'package:your_app_name/screens/login_page.dart';
import '../widgets/toggle_switch.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool isDarkMode = false;
  bool isPushNotificationsEnabled = true;

  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void togglePushNotifications(bool value) {
    setState(() {
      isPushNotificationsEnabled = !isPushNotificationsEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC8DAB5),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Enhanced Gradient Title
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Colors.green.shade700,
                  Colors.green.shade400,
                  Colors.lightGreen.shade300,
                ],
                stops: const [0.1, 0.5, 0.9],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              child: const Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SF Pro',
                  height: 1.2,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Content Container
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F7F2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListView(
                  children: [
                    _buildSectionTitle('Personal Information'),
                    _buildSettingItem(
                      icon: Icons.person_outline,
                      title: 'Edit profile',
                      showArrow: true,
                      onTap: () {},
                    ),
                    _buildSettingItem(
                      icon: Icons.lock_outline,
                      title: 'Change password',
                      showArrow: true,
                      onTap: () {},
                    ),
                    _buildSettingItem(
                      icon: Icons.credit_card,
                      title: 'Payment methods',
                      showArrow: true,
                      onTap: () {},
                    ),
                    _buildSettingItem(
                      icon: Icons.notifications_none,
                      title: 'Push notifications',
                      trailing: ToggleSwitch(
                        value: isPushNotificationsEnabled,
                        onToggle: togglePushNotifications,
                        activeColor: Colors.green.shade600,
                      ),
                    ),
                    _buildSettingItem(
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark mode',
                      trailing: ToggleSwitch(
                        value: isDarkMode,
                        onToggle: toggleDarkMode,
                        activeColor: Colors.green.shade600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle('More'),
                    _buildSettingItem(
                      icon: Icons.info_outline,
                      title: 'About us',
                      onTap: () {},
                    ),
                    _buildSettingItem(
                      icon: Icons.shield,
                      title: 'Privacy policy',
                      onTap: () {},
                    ),
                    _buildSettingItem(
                      icon: Icons.description_outlined,
                      title: 'Terms and conditions',
                      onTap: () {},
                    ),
                    const SizedBox(height: 30),
                    // Sign Out Button
                    _buildSignOutButton(),
                  ],
                ),
              ),
            ),
            // Bottom indicator
            const SizedBox(height: 20),
            Container(
              width: 134,
              height: 5,
              margin: const EdgeInsets.symmetric(
                  vertical: 20), // FIXED: added const
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontFamily: 'SF Pro',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    bool showArrow = false,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        height: 56,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.green.shade700, size: 24),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'SF Pro',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            trailing ??
                (showArrow
                    ? const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                        size: 24,
                      )
                    : const SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget _buildSignOutButton() {
    return ElevatedButton.icon(
      onPressed: _handleSignOut,
      icon: const Icon(Icons.logout, color: Colors.white),
      label: const Text(
        'Sign Out',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'SF Pro',
          fontSize: 18,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFD35959),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
      ),
    );
  }

  void _handleSignOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
