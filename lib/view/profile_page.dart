import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon, color: Colors.black54, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: navigate
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Tapped: $title')));
      },
    );
  }

  Widget _buildSection(
    BuildContext context,
    String header,
    List<Widget> tiles,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
            child: Text(
              header,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ...tiles,
        const Divider(height: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          // Header: avatar, name, subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Your Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Show profile',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),

          // Promo card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline_rounded,
                        color: Colors.pink,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'List your EV charger on EVconnect',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "It's simple to get set up and start earning.",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Settings section
          _buildSection(context, 'Settings', [
            _buildTile(
              context,
              icon: Icons.person_outline,
              title: 'Personal information',
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(
              context,
              icon: Icons.lock_outline,
              title: 'Login & security',
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(
              context,
              icon: Icons.payment_outlined,
              title: 'Payments and payouts',
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(
              context,
              icon: Icons.accessible_forward,
              title: 'Accessibility',
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(
              context,
              icon: Icons.account_balance_wallet,
              title: 'Taxes',
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(context, icon: Icons.translate, title: 'Translation'),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(
              context,
              icon: Icons.notifications_none,
              title: 'Notifications',
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(
              context,
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy and sharing',
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(
              context,
              icon: Icons.work_outline,
              title: 'Travel for work',
            ),
          ]),

          // Hosting
          _buildSection(context, 'Hosting', [
            _buildTile(context, icon: Icons.list_alt, title: 'List your Charger'),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(
              context,
              icon: Icons.school,
              title: 'Learn about hosting',
            ),
          ]),

          // Support
          _buildSection(context, 'Support', [
            _buildTile(
              context,
              icon: Icons.help_outline,
              title: 'Visit the Help Center',
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(
              context,
              icon: Icons.shield_outlined,
              title: 'Get help with a safety issue',
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(
              context,
              icon: Icons.info_outline,
              title: 'How EVconnect works',
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(
              context,
              icon: Icons.feedback_outlined,
              title: 'Give us feedback',
            ),
          ]),

          // Legal
          _buildSection(context, 'Legal', [
            _buildTile(
              context,
              icon: Icons.article_outlined,
              title: 'Terms of Service',
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(
              context,
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
            ),
            const Divider(height: 1, indent: 20, endIndent: 20),
            _buildTile(
              context,
              icon: Icons.code,
              title: 'Open source licenses',
            ),
          ]),

          const SizedBox(height: 8),

          // Logout and version
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: perform logout
                  },
                  child: const Text(
                    'Log out',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Version 0.0.1', style: theme.textTheme.bodySmall),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
