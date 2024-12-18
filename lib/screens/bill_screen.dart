import 'package:flutter/material.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final _amountController = TextEditingController();
  String _selectedCategory = "Internet Bill";

  // List to hold upcoming bills dynamically
  final List<Map<String, dynamic>> _billList = [
    {"icon": Icons.electrical_services, "title": "Electricity Bill", "amount": 150.50},
    {"icon": Icons.water_drop, "title": "Water Bill", "amount": 75.25},
    {"icon": Icons.wifi, "title": "Internet Bill", "amount": 65.00},
    {"icon": Icons.phone_android, "title": "Mobile Bill", "amount": 50.00},
  ];

  // Method to get an icon based on the category
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Internet Bill":
        return Icons.wifi;
      case "Electricity Bill":
        return Icons.electrical_services;
      case "Water Bill":
        return Icons.water_drop;
      case "Mobile Bill":
        return Icons.phone_android;
      default:
        return Icons.receipt_long;
    }
  }

  // Add Bill to the List
  void _addBill() {
    final enteredAmount = _amountController.text;

    if (enteredAmount.isEmpty || double.tryParse(enteredAmount) == null) {
      // Show error message if the amount is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid amount."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _billList.add({
        "icon": _getCategoryIcon(_selectedCategory),
        "title": _selectedCategory,
        "amount": double.parse(enteredAmount),
      });

      // Clear input after adding
      _amountController.clear();
      _selectedCategory = "Internet Bill";
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Bill added successfully."),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF476AD3),
        title: const Text(
          "Bill Reminders & Payment Scheduling",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
            // Title: Set Bill Amount
            const Text(
              "Set Your Bill Amount",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            // Input Field for Bill Amount
            Container(
              padding: const EdgeInsets.all(12),
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
                  const Icon(Icons.account_balance_wallet,
                      color: Color(0xFF476AD3), size: 32),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Enter bill amount",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF476AD3),
                    ),
                    onPressed: _addBill,
                    child: const Text("Set"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Title: Select Bill Category
            const Text(
              "Select Bill Category",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            // Dropdown for Category Selection
            Container(
              padding: const EdgeInsets.all(12),
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
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: const [
                  DropdownMenuItem(
                      value: "Internet Bill", child: Text("Internet Bill")),
                  DropdownMenuItem(
                      value: "Electricity Bill", child: Text("Electricity Bill")),
                  DropdownMenuItem(
                      value: "Water Bill", child: Text("Water Bill")),
                  DropdownMenuItem(
                      value: "Mobile Bill", child: Text("Mobile Bill")),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title: Upcoming Bills
            const Text(
              "Upcoming Bills",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            // Upcoming Bills List
            Column(
              children: _billList.map((bill) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
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
                      Icon(bill['icon'], color: const Color(0xFF476AD3), size: 32),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          bill['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        "\$${bill['amount'].toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
