import 'package:flutter/material.dart';

class LedgerScreen extends StatelessWidget {
  const LedgerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data for ledger entries
    final List<Map<String, dynamic>> entries = [
      {"title": "Opening Balance", "amount": 5000.00, "type": "credit", "date": "06/01 08:00 AM"},
      {"title": "Rent Payment", "amount": 1200.00, "type": "debit", "date": "06/02 09:30 AM"},
      {"title": "Groceries", "amount": 300.00, "type": "debit", "date": "06/03 02:15 PM"},
      {"title": "Salary Received", "amount": 4500.00, "type": "credit", "date": "06/04 10:00 AM"},
      {"title": "Electricity Bill", "amount": 150.00, "type": "debit", "date": "06/05 06:00 PM"},
      {"title": "Internet Bill", "amount": 75.00, "type": "debit", "date": "06/06 11:00 AM"},
      {"title": "Dining Out", "amount": 80.00, "type": "debit", "date": "06/06 08:00 PM"},
      {"title": "Freelance Payment", "amount": 800.00, "type": "credit", "date": "06/07 01:00 PM"},
      {"title": "Gasoline", "amount": 60.00, "type": "debit", "date": "06/07 05:30 PM"},
      {"title": "Closing Balance", "amount": 6535.00, "type": "credit", "date": "06/08 08:00 AM"},
    ];

    // Calculate totals
    double totalDebit = entries
        .where((entry) => entry["type"] == "debit")
        .fold(0.0, (sum, entry) => sum + entry["amount"]);

    double totalCredit = entries
        .where((entry) => entry["type"] == "credit")
        .fold(0.0, (sum, entry) => sum + entry["amount"]);

    double balance = totalCredit - totalDebit;

    return Scaffold(
      // AppBar with Gradient Background
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF476AD3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Ledger Management",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Body Section
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Ledger Entries
            Expanded(
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  bool isCredit = entry["type"] == "credit";
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: isCredit
                            ? Colors.green.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                        child: Icon(
                          isCredit ? Icons.arrow_upward : Icons.arrow_downward,
                          color: isCredit ? Colors.green : Colors.red,
                          size: 28,
                        ),
                      ),
                      title: Text(
                        entry["title"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        entry["date"],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      trailing: Text(
                        "${isCredit ? '+' : '-'}\$${entry["amount"].toStringAsFixed(2)}",
                        style: TextStyle(
                          color: isCredit ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Summary Row
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    spreadRadius: 2,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryItem(
                    label: "Debit",
                    amount: totalDebit,
                    gradientColors: [Colors.red, Colors.redAccent],
                    icon: Icons.arrow_downward,
                  ),
                  _buildSummaryItem(
                    label: "Credit",
                    amount: totalCredit,
                    gradientColors: [Colors.green, Colors.lightGreen],
                    icon: Icons.arrow_upward,
                  ),
                  _buildSummaryItem(
                    label: "Balance",
                    amount: balance,
                    gradientColors: [Color(0xFF113087), Color(0xFF476AD3)],
                    icon: Icons.account_balance_wallet,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build summary items with gradient icons
  Widget _buildSummaryItem({
    required String label,
    required double amount,
    required List<Color> gradientColors,
    required IconData icon,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: Icon(icon, size: 28, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
