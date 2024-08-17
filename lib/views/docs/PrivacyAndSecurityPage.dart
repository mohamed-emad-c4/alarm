import 'package:flutter/material.dart';

class PrivacyAndSecurityPage extends StatelessWidget {
  const PrivacyAndSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy and Security"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy and Security",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                "Your privacy and security are our top priority. We implement various measures to ensure that your data is safe.",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              BulletPoint(text: "Data encryption"),
              BulletPoint(text: "Access control"),
              BulletPoint(text: "Regular audits"),
              BulletPoint(text: "User control over personal data"),
              const SizedBox(height: 20),
              BulletPoint(text: "Set a PIN to protect your account"),
              const SizedBox(height: 20),
              Text(
                "For any questions regarding privacy and security, please contact us.",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.brightness_1, size: 6),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
