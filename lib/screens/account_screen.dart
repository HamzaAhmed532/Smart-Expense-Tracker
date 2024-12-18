import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // List of accounts
  List<Map<String, dynamic>> accounts = [
    {"name": "Cash", "type": "Wallet", "balance": 500.0},
    {"name": "Debit Card", "type": "Card", "balance": 2500.0},
    {"name": "Credit Card", "type": "Card", "balance": 300.0},
  ];

  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  String selectedType = "Wallet";

  // Open Add/Edit Account Dialog
  void _showAccountDialog({Map<String, dynamic>? account, int? index}) {
    bool isEdit = account != null; // Check if editing
    _accountNameController.text = isEdit ? account!["name"] : "";
    _balanceController.text = isEdit ? account["balance"].toString() : "";
    selectedType = isEdit ? account["type"] : "Wallet";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? "Edit Account" : "Add New Account"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _accountNameController,
                decoration: const InputDecoration(labelText: "Account Name"),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedType,
                items: const [
                  DropdownMenuItem(value: "Wallet", child: Text("Wallet")),
                  DropdownMenuItem(value: "Card", child: Text("Card")),
                  DropdownMenuItem(value: "Bank", child: Text("Bank")),
                  DropdownMenuItem(value: "Other", child: Text("Other")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedType = value!;
                  });
                },
                decoration: const InputDecoration(labelText: "Account Type"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _balanceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Initial Balance"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_accountNameController.text.isNotEmpty &&
                    _balanceController.text.isNotEmpty) {
                  setState(() {
                    if (isEdit) {
                      // Update account details
                      accounts[index!] = {
                        "name": _accountNameController.text,
                        "type": selectedType,
                        "balance": double.parse(_balanceController.text),
                      };
                    } else {
                      // Add new account
                      accounts.add({
                        "name": _accountNameController.text,
                        "type": selectedType,
                        "balance": double.parse(_balanceController.text),
                      });
                    }
                  });
                  _accountNameController.clear();
                  _balanceController.clear();
                  Navigator.pop(context);
                }
              },
              child: Text(isEdit ? "Save" : "Add"),
            ),
          ],
        );
      },
    );
  }

  // Delete Account
  void _deleteAccount(int index) {
    setState(() {
      accounts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color(0xFF476AD3),
        title: const Text(
          "Manage Accounts",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Accounts",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Account List
            Expanded(
              child: ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  return _buildAccountTile(account, index);
                },
              ),
            ),

            const SizedBox(height: 20),

            // Add Account Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showAccountDialog(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFF476AD3),
                ),
                child: const Text(
                  "Add New Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Account Tile
  Widget _buildAccountTile(Map<String, dynamic> account, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
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
          // Gradient Icon
          _buildGradientIcon(
            account["type"] == "Card"
                ? Icons.credit_card
                : Icons.account_balance_wallet,
          ),
          const SizedBox(width: 8), // Space between icon and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Type: ${account["type"]}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${account["balance"].toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 2), // Reduced space
          IconButton(
            icon: _buildGradientIcon(Icons.edit, size: 24),
            onPressed: () => _showAccountDialog(account: account, index: index),
          ),
          const SizedBox(width: 0), // Further reduced space between icons
          IconButton(
            icon: _buildGradientIcon(Icons.delete, size: 24),
            onPressed: () => _deleteAccount(index),
          ),
        ],
      ),
    );
  }


  // Gradient Icon Widget
  Widget _buildGradientIcon(IconData icon, {double size = 28}) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFF252D4C), Color(0xFF113087), Color(0xFF476AD3)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: Icon(icon, size: size, color: Colors.white),
    );
  }
}
