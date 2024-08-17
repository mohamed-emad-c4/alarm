import 'package:alarm/views/docs/Help&Support.dart';
import 'package:alarm/views/docs/PrivacyAndSecurityPage.dart';
import 'package:alarm/views/docs/about_us.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  final List<SettingItem> settings = [
    SettingItem(
      title: "Notifications",
      subtitle: "Enable or disable notifications",
      settingType: SettingType.switchType,
      currentValue: true,
    ),
    SettingItem(
      title: "Language",
      subtitle: "Select app language",
      settingType: SettingType.selectionType,
      options: ["English", "Arabic", "French"],
      currentValue: "English",
    ),
    SettingItem(
      title: "Theme",
      subtitle: "Choose Light or Dark theme",
      settingType: SettingType.selectionType,
      options: ["Light", "Dark"],
      currentValue: "Light",
    ),
    SettingItem(
      title: "Privacy Policy",
      subtitle: "View our privacy policy",
      settingType: SettingType.navigationType,
    ),
    SettingItem(
      title: "Help & Support",
      subtitle: "View Help & Support",
      settingType: SettingType.navigationType,
    ),
    SettingItem(
      title: "About Us",
      subtitle: "How Contect Us",
      settingType: SettingType.navigationType,

    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: settings.length,
        itemBuilder: (context, index) {
          return SettingTile(settingItem: settings[index]);
        },
      ),
    );
  }
}

class SettingItem {
  final String title;
  final String subtitle;
  final SettingType settingType;
  final List<String>? options;
  final dynamic currentValue;
  

  SettingItem({
    required this.title,
    required this.subtitle,
    required this.settingType,
    this.options,
    this.currentValue,
  });
}

enum SettingType { switchType, selectionType, navigationType }

class SettingTile extends StatelessWidget {
  final SettingItem settingItem;

  SettingTile({required this.settingItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        title: Text(
          settingItem.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          settingItem.subtitle,
          style: TextStyle(color: Colors.grey[400]),
        ),
        trailing: _buildTrailing(context),
        onTap: () {
          if (settingItem.settingType == SettingType.selectionType) {
            _showSelectionDialog(context, settingItem);
          } else if (settingItem.settingType == SettingType.navigationType) {
            if (settingItem.title == "Privacy Policy") {
              Get.to(PrivacyAndSecurityPage());
              // Navigate to Privacy Policy screen
            } else if (settingItem.title == "Help & Support") {
              Get.to(HelpAndSupportPage());
              // Navigate to Terms of Service screen
            } else if (settingItem.title == "About Us") {
              Get.to(AboutUsPage());
            }
          }
        },
      ),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    switch (settingItem.settingType) {
      case SettingType.switchType:
        return Switch(
          value: settingItem.currentValue as bool,
          onChanged: (bool value) {
            // Handle switch toggle
          },
          activeColor: Colors.blueAccent,
        );
      case SettingType.selectionType:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              settingItem.currentValue.toString(),
              style: TextStyle(color: Colors.grey[400]),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 16),
          ],
        );
      case SettingType.navigationType:
        return Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 16);
      default:
        return SizedBox.shrink();
    }
  }

  void _showSelectionDialog(BuildContext context, SettingItem settingItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text(settingItem.title, style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              children: settingItem.options!.map((option) {
                return RadioListTile(
                  title: Text(option, style: TextStyle(color: Colors.white)),
                  value: option,
                  groupValue: settingItem.currentValue,
                  onChanged: (value) {
                    // Handle option selection
                    Navigator.of(context).pop();
                  },
                  activeColor: Colors.blueAccent,
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
