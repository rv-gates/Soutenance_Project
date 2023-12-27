import 'package:flutter/material.dart';

class VerificationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const VerificationCard({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 64.0,
                color: Colors.white,
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

    );
  }
}