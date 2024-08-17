import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Help & Support",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                "We are here to help you with any issues you might encounter.",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                "Frequently Asked Questions",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              BulletPoint(text: "How do I reset my password?"),
              BulletPoint(text: "How do I change my email address?"),
              BulletPoint(text: "How do I contact support?"),
              const SizedBox(height: 20),
              Text(
                "Didn't find the answer?",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCircleButton(
                    context,
                    icon: FaIcon(FontAwesomeIcons.envelope),
                    label: "Email Us",
                    onTap: _sendEmail,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "Connect With Us",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialMediaButton(
                      context,
                      icon: FaIcon(FontAwesomeIcons.whatsapp),
                      label: "WhatsApp",
                      color: Colors.green,
                      onTap: _contactViaWhatsApp,
                    ),
                    const SizedBox(width: 20),
                    _buildSocialMediaButton(
                      context,
                      icon: FaIcon(FontAwesomeIcons.facebook),
                      label: "Messenger",
                      color: Colors.blue,
                      onTap: _contactViaMessenger,
                    ),
                    const SizedBox(width: 20),
                    _buildSocialMediaButton(
                      context,
                      icon: FaIcon(FontAwesomeIcons.twitter),
                      label: "Twitter",
                      color: Colors.lightBlue,
                      onTap: _contactViaTwitter,
                    ),
                    const SizedBox(width: 20),
                    _buildSocialMediaButton(
                      context,
                      icon: FaIcon(FontAwesomeIcons.instagram),
                      label: "Instagram",
                      color: Colors.purple,
                      onTap: _contactViaInstagram,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "We appreciate your feedback!",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton(
    BuildContext context, {
    required FaIcon icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: icon,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaButton(
    BuildContext context, {
    required FaIcon icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: icon,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'zemax.c4@gmail.com',
      query:
          'subject=Help%20Needed&body=Hi%20there,%0D%0A%0D%0A', 
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      Get.snackbar("Error", "'Could not launch Email \n $emailUri");
    }
  }

  void _contactViaWhatsApp() async {
    const String phoneNumber = '201099312476';
    const String message = 'Hello, I need some assistance.';

    final Uri whatsappUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: '/$phoneNumber',
      queryParameters: {
        'text': message,
      },
    );

    if (await canLaunch(whatsappUri.toString())) {
      await launch(whatsappUri.toString());
    } else {
      Get.snackbar("Error", "'Could not launch WhatsApp");
    }
  }

  void _contactViaMessenger() async {
    final Uri messengerUri = Uri.parse('https://m.me/zemax.c4');
    if (await canLaunch(messengerUri.toString())) {
      await launch(messengerUri.toString());
    } else {
      Get.snackbar("Error", "'Could not launch Messenger");
    }
  }

  void _contactViaTwitter() async {
    final Uri twitterUri = Uri.parse('https://twitter.com/zemax_c4');
    if (await canLaunch(twitterUri.toString())) {
      await launch(twitterUri.toString());
    } else {
      Get.snackbar("Error", "'Could not launch Twitter");
    }
  }

  void _contactViaInstagram() async {
    final Uri instagramUri = Uri.parse('https://instagram.com/mohamed_emad_c4');
    if (await canLaunch(instagramUri.toString())) {
      await launch(instagramUri.toString());
    } else {
      Get.snackbar("Error", "'Could not launch Instagram");
    }
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
