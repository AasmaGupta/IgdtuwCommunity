import 'package:flutter/material.dart';
import '../widgets/deadline_card.dart';

class Deadline {
  final String title;
  final String subtitle;
  final String time;
  final String status;
  final Color color;
  final double? progress;
  final String? buttonText;
  final IconData icon;

  const Deadline({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.status,
    required this.color,
    required this.icon,
    this.progress,
    this.buttonText,
  });
}

class MainScreen extends StatelessWidget {
  final List<Deadline> deadlines;

  const MainScreen({super.key})
      : deadlines = const [
          Deadline(
            title: 'Group Discussion',
            subtitle: 'Team meeting for project review',
            time: 'Today at 17:00',
            status: 'Starting soon',
            buttonText: 'Ready to start',
            color: Color(0xFFFCD9CD),
            icon: Icons.group,
          ),
          Deadline(
            title: 'MAD File Submission',
            subtitle: 'Mobile App Development assignment',
            time: '5th May, 2025',
            status: 'High Priority',
            progress: 0.7,
            color: Colors.green,
            icon: Icons.assignment,
          ),
          Deadline(
            title: 'Research Paper Draft',
            subtitle: 'Finalize literature review section',
            time: '8th May, 2025',
            status: 'In Progress',
            progress: 0.45,
            color: Color(0xFFEFFFD6),
            icon: Icons.article,
          ),
          Deadline(
            title: 'Final Presentation',
            subtitle: 'Prepare slides and demo',
            time: '13th May, 2025',
            status: 'Not Started',
            progress: 0.0,
            color: Color(0xFFE5E7EB),
            icon: Icons.slideshow,
          ),
        ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildHeader(),
                const SizedBox(height: 24),
                _buildSectionHeader("Upcoming Events"),
                const SizedBox(height: 12),
                _buildEventBanner(),
                const SizedBox(height: 24),
                _buildSectionHeader('Deadlines'),
                const SizedBox(height: 12),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DeadlineCard(deadline: deadlines[index]),
                ),
                childCount: deadlines.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Radhika',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ClipOval(
              child: Image.asset(
                'assets/images/avatar.png',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEventBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.asset(
            'assets/images/black_friday.jpg',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Taarangna: Mohit Chauhan LIVE',
                  style: TextStyle(
                    color: Color.fromARGB(255, 127, 165, 142),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'On 26th April,2025 at 17:00 PM',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'View All',
          style: TextStyle(
            color: Colors.green[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
