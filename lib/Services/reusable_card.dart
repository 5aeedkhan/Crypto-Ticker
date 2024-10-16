// Reusable Card Widget
import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final String title;
  final Color color; // Add color parameter
  final IconData icon; // IconData parameter for the icon

  ReusableCard({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
  }); // Constructor

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0), // Remove margin around the card
      elevation: 10,
      color: color, // Use the passed color
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 40), // Adjust padding
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center align the content
          children: [
            Icon(icon, size: 40, color: Colors.white), // Display the icon
            SizedBox(width: 10), // Space between icon and text
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20, // Increase font size
                  fontWeight: FontWeight.bold, // Make text bold
                  color: Colors.white, // White text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
