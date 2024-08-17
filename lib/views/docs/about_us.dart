import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Us",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                "Welcome to our Alarm App! We're here to help you wake up on time and manage your alarms effortlessly.",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                "Our Mission",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Our mission is to provide you with a reliable and easy-to-use alarm application that meets all your waking up needs.",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                "Contact Us",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "If you have any questions or feedback, feel free to reach out to us. We're here to help!",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialMediaButton(
                    context,
                    icon: const FaIcon(FontAwesomeIcons.envelope),
                    label: "Email Us",
                    onTap: () {
                      _sendEmail();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "Follow Us",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialMediaButton(
                    context,
                    icon: const FaIcon(FontAwesomeIcons.facebook),
                    label: "Facebook",
                    onTap: () {
                      _launchURL(
                          'https://www.facebook.com/profile.php?id=61563607514517');
                    },
                  ),
                  const SizedBox(width: 20),
                  _buildSocialMediaButton(
                    context,
                    icon: const FaIcon(FontAwesomeIcons.twitter),
                    label: "Twitter",
                    onTap: () {
                      _launchURL('https://x.com/zemax_c4');
                    },
                  ),
                  const SizedBox(width: 20),
                  _buildSocialMediaButton(
                    context,
                    icon: const FaIcon(FontAwesomeIcons.instagram),
                    label: "Instagram",
                    onTap: () {
                      _launchURL('https://www.instagram.com/flutternexus/');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaButton(BuildContext context,
      {required FaIcon icon,
      required String label,
      required VoidCallback onTap}) {
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

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      Get.snackbar("Error", "Could not launch");
    }
  }

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'zemax.c4@gmail.com',
      query: 'subject=Help%20Needed&body=Hi%20there,%0D%0A%0D%0A',
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      Get.snackbar("Error", "Could not launch");
    }
  }
}
