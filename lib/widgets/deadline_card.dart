import 'package:flutter/material.dart';
import '../screens/main_screen.dart'; // Import Deadline model

class DeadlineCard extends StatelessWidget {
  final Deadline deadline;

  const DeadlineCard({super.key, required this.deadline});

  @override
  Widget build(BuildContext context) {
    final bool hasProgress = deadline.progress != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: deadline.color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(deadline.icon, color: Colors.black54, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(deadline.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(deadline.subtitle,
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey[600])),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: deadline.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    deadline.status,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(deadline.time,
                    style:
                        TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                const Spacer(),
                if (hasProgress)
                  Text(
                    '${(deadline.progress! * 100).round()}% Complete',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
            if (hasProgress) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: deadline.progress,
                color: Colors.green,
                backgroundColor: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                minHeight: 6,
              )
            ] else if (deadline.buttonText != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {},
                  child: Text(deadline.buttonText!),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
