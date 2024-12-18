import 'package:flutter/material.dart';

import 'bill_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool isGeofenceEnabled = false;

  void _navigateToBillScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BillScreen()),
    );
  }

  // Open Currency Dialog
  void _showCurrencyDialog(BuildContext context) {
    final List<String> currencies = ["USD", "EUR", "GBP", "INR", "AUD"];
    String selectedCurrency = "USD"; // Default value

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Select Currency"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: currencies
                    .map((currency) => RadioListTile<String>(
                  title: Text(currency),
                  value: currency,
                  groupValue: selectedCurrency,
                  onChanged: (value) {
                    setState(() {
                      selectedCurrency = value!;
                    });
                  },
                ))
                    .toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, selectedCurrency);
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color(0xFF476AD3),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Big Person Icon with Gradient
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF252D4C),
                      Color(0xFF113087),
                      Color(0xFF476AD3),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Profile Info
            Center(
              child: Column(
                children: const [
                  Text(
                    "Hamza",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "hamzafk7890@gmail.com",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Account Section
            const Text(
              "Account",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 10),
            _buildGradientOption(Icons.account_circle, "Profile"),
            _buildGradientOption(Icons.account_balance_wallet, "Wallet",
                trailing: "\$0.00"),
            _buildGradientOption(Icons.settings, "Preferences"),
            _buildGradientOption(Icons.security, "Security"),

            const SizedBox(height: 20),

            // Workspaces Section
            const Text(
              "Workspaces",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 10),
            _buildGradientOption(Icons.work, "Workspaces"),
            InkWell(
              onTap: _navigateToBillScreen,
              child: _buildGradientOption(
                  Icons.subscriptions, "Bill and Subscription"),
            ),


            const SizedBox(height: 20),

            // General Section
            const Text(
              "General",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 10),
            _buildGradientOption(Icons.help_outline, "Help"),
            GestureDetector(
              onTap: () => _showCurrencyDialog(context),
              child: _buildGradientOption(Icons.attach_money, "Currency"),
            ),
            _buildGradientOption(Icons.info_outline, "About"),

            const SizedBox(height: 20),

            // Geofence Reminder Section
            const Text(
              "Features",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 10),
            _buildGeofenceReminderOption(),
          ],
        ),
      ),
    );
  }

  // Reusable Gradient Option Widget
  Widget _buildGradientOption(IconData icon, String title,
      {String? trailing, String? trailingButton}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [
                  Color(0xFF252D4C),
                  Color(0xFF113087),
                  Color(0xFF476AD3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: Icon(icon, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            ),
          ),
          if (trailing != null)
            Text(
              trailing,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54),
            ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildGeofenceReminderOption() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [
                  Color(0xFF252D4C),
                  Color(0xFF113087),
                  Color(0xFF476AD3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: const Icon(Icons.location_on, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              "Geofence Reminder",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            ),
          ),
          Container(
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: isGeofenceEnabled
                  ? const LinearGradient(
                colors: [
                  Color(0xFF252D4C),
                  Color(0xFF113087),
                  Color(0xFF476AD3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
                  : null,
              color: isGeofenceEnabled ? null : Colors.grey.shade300,
            ),
            child: Switch(
              value: isGeofenceEnabled,
              activeColor: Colors.transparent,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade300,
              onChanged: (value) {
                setState(() {
                  isGeofenceEnabled = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
