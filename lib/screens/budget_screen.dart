import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  double totalBudget = 2000.0; // Default budget
  double spentAmount = 800.0; // Placeholder spent amount
  String selectedCategory = "Food"; // Default category
  final TextEditingController _budgetController = TextEditingController();

  // Categories List with icons
  final List<Map<String, dynamic>> categories = [
    {"name": "Food", "icon": Icons.fastfood},
    {"name": "Transport", "icon": Icons.directions_car},
    {"name": "Shopping", "icon": Icons.shopping_bag},
    {"name": "Entertainment", "icon": Icons.movie},
    {"name": "Health", "icon": Icons.favorite},
    {"name": "Travel", "icon": Icons.flight},
    {"name": "Education", "icon": Icons.school},
  ];

  @override
  Widget build(BuildContext context) {
    double remainingBudget = totalBudget - spentAmount;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color(0xFF476AD3),
        title: const Text(
          "Budget",
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Budget Input Section
              const Text(
                "Set Your Monthly Budget",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: _containerDecoration(),
                child: Row(
                  children: [
                    _gradientIcon(Icons.account_balance_wallet),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _budgetController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Enter budget amount",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF476AD3),
                      ),
                      onPressed: () {
                        if (_budgetController.text.isNotEmpty) {
                          setState(() {
                            totalBudget =
                                double.tryParse(_budgetController.text) ??
                                    totalBudget;
                          });
                        }
                      },
                      child: const Text("Set",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Category Selection
              const Text(
                "Select Category",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              _buildCategorySelection(),

              const SizedBox(height: 20),

              // Progress Bar with Gradient Fill
              const Text(
                "Budget Overview",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: _containerDecoration(),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 12,
                        child: _gradientProgressBar(spentAmount / totalBudget),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Spent: \$${spentAmount.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                        ),
                        Text(
                          "Remaining: \$${remainingBudget.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Budget Allocations
              const Text(
                "Budget Allocation",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              ...categories
                  .map((category) => _buildCategoryTile(category))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  // Gradient Progress Bar
  Widget _gradientProgressBar(double value) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              width: constraints.maxWidth,
              color: Colors.grey.shade300,
            ),
            Container(
              width: constraints.maxWidth * value,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF252D4C),
                    Color(0xFF113087),
                    Color(0xFF476AD3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Widget to build Category Selection Dropdown
  Widget _buildCategorySelection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _containerDecoration(),
      child: Row(
        children: [
          _gradientIcon(Icons.category),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedCategory,
                isExpanded: true,
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category["name"],
                    child: Text(category["name"]),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build Category Budget Tiles
  Widget _buildCategoryTile(Map<String, dynamic> category) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: _containerDecoration(),
      child: Row(
        children: [
          _gradientIcon(category['icon']),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              category['name'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            "\$${(totalBudget / categories.length).toStringAsFixed(2)}", // Divided equally for simplicity
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Gradient Icon Widget
  Widget _gradientIcon(IconData icon) {
    return ShaderMask(
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
      child: Icon(icon, size: 32),
    );
  }

  // Container Decoration
  BoxDecoration _containerDecoration() {
    return BoxDecoration(
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
    );
  }
}
