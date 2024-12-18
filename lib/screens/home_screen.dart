import 'package:flutter/material.dart';
import 'package:expenses/screens/ledger_screen.dart';
import 'package:expenses/screens/robo_advisor_screen.dart';
import 'package:expenses/screens/expense_screen.dart';
import 'package:expenses/screens/profile_screen.dart';
import 'package:expenses/screens/statistics_screen.dart';
import 'package:expenses/screens/budget_screen.dart';
import 'package:expenses/screens/account_screen.dart';

class FinanceHomePage extends StatefulWidget {
  const FinanceHomePage({super.key});

  @override
  State<FinanceHomePage> createState() => _FinanceHomePageState();
}

class _FinanceHomePageState extends State<FinanceHomePage> {
  int _selectedIndex = 0; // State to track the selected bottom nav icon

  void _showPopupMenu() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Close popup on tapping outside
            GestureDetector(
              onTap: () {
                overlayEntry.remove();
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: position.dy + 130, // Position popup
              left: MediaQuery.of(context).size.width / 2 - 150, // Center it
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPopupOption(
                        icon: Icons.attach_money,
                        label: "Expense",
                        onTap: () {
                          overlayEntry.remove();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ExpenseScreen()),
                          );
                        },
                      ),
                      _buildPopupOption(
                        icon: Icons.account_balance_wallet,
                        label: "Budget",
                        onTap: () {
                          overlayEntry.remove();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BudgetScreen()),
                          );
                        },
                      ),
                      _buildPopupOption(
                        icon: Icons.account_balance,
                        label: "Account",
                        onTap: () {
                          overlayEntry.remove();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AccountScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    // Insert the overlay
    overlay.insert(overlayEntry);
  }





  Widget _buildPopupOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            child: Icon(
              icon,
              size: 36,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left Side: Welcome Text and User Name
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Hamza",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    // Right Side: Person Icon
                    // Right Side: Person Icon
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfileScreen()),
                        );
                      },
                      child: Container(
                        width: 48,
                        height: 48,
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
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 20),

                // Balance Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Total Balance",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "\$ 4800.00",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.arrow_downward,
                                  color: Colors.greenAccent),
                              SizedBox(width: 5),
                              Text(
                                "Income\n2.500.000",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(Icons.arrow_upward, color: Colors.redAccent),
                              SizedBox(width: 5),
                              Text(
                                "Expenses\n800.00",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Transactions Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Transactions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 20),

                // Transaction Items
                TransactionItem(
                  icon: Icons.fastfood,
                  title: "Food",
                  amount: "-\$45.00",
                  date: "Today",
                  color: Colors.orange,
                ),
                TransactionItem(
                  icon: Icons.shopping_bag,
                  title: "Shopping",
                  amount: "-\$280.00",
                  date: "Today",
                  color: Colors.purple,
                ),
                TransactionItem(
                  icon: Icons.movie,
                  title: "Entertainment",
                  amount: "-\$60.00",
                  date: "Yesterday",
                  color: Colors.redAccent,
                ),
                TransactionItem(
                  icon: Icons.flight,
                  title: "Travel",
                  amount: "-\$250.00",
                  date: "Yesterday",
                  color: Colors.green,
                ),
                TransactionItem(
                  icon: Icons.flight,
                  title: "Travel",
                  amount: "-\$250.00",
                  date: "Yesterday",
                  color: Colors.green,
                ),
                TransactionItem(
                  icon: Icons.flight,
                  title: "Travel",
                  amount: "-\$250.00",
                  date: "Yesterday",
                  color: Colors.green,
                ),
                TransactionItem(
                  icon: Icons.flight,
                  title: "Travel",
                  amount: "-\$250.00",
                  date: "Yesterday",
                  color: Colors.green,
                ),
                // Add more items as needed...
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPopupMenu, // Call the _showPopupMenu function
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xFF252D4C),
                Color(0xFF113087),
                Color(0xFF476AD3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.add, size: 36, color: Colors.white),
        ),
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavIcon(icon: Icons.home, index: 0),
              _buildNavIcon(icon: Icons.menu_book, index: 1),
              _buildNavIcon(icon: Icons.bar_chart, index: 2),
              _buildNavIcon(icon: Icons.smart_toy, index: 3),
            ],
          ),
        ),
      ),
    );
  }

  // Build Bottom Navigation Icon
  // Build Bottom Navigation Icon
  Widget _buildNavIcon({required IconData icon, required int index}) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });

        // Navigate to LedgerScreen when Book icon is clicked
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LedgerScreen()),
          );

        }else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StatisticsScreen()),
          );
        }
        else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RoboAdvisorScreen()),
          );
        }
      },
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return isSelected
              ? const LinearGradient(
            colors: [
              Color(0xFF252D4C),
              Color(0xFF113087),
              Color(0xFF476AD3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds)
              : const LinearGradient(
            colors: [
              Colors.grey,
              Colors.grey,
            ],
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcIn, // Ensures the gradient is applied to the icon
        child: Icon(
          icon,
          size: 28,
        ),
      ),
    );
  }


}

// Transaction Item Widget
class TransactionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final String date;
  final Color color;

  const TransactionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.date,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            radius: 20,
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
