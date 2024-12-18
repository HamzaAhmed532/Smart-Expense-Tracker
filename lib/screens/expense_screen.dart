import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  String selectedCategory = "Category";
  String selectedDate = "Date";
  final TextEditingController _amountController =
  TextEditingController(text: "0");
  final TextEditingController _descriptionController = TextEditingController();

  // List to hold added expenses
  final List<Map<String, dynamic>> _expenses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: true, // Adjust UI when keyboard appears
      appBar: AppBar(
        backgroundColor: const Color(0xFF476AD3),
        centerTitle: true,
        title: const Text(
          "Add Expenses",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView( // Makes content scrollable
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount Input Box
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _amountController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF476AD3),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefix: const Text(
                      "\$ ",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // Category Input
              _buildInputTile(
                title: selectedCategory,
                icon: Icons.category,
                onTap: () => _showCategorySelection(),
              ),
              const SizedBox(height: 16),

              // Description Input Field
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.description,
                        color: Colors.blueGrey, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: "Description",
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Date Selection
              _buildInputTile(
                title: selectedDate,
                icon: Icons.calendar_today,
                onTap: () => _selectDate(),
              ),

              const SizedBox(height: 16),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveExpense,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color(0xFF476AD3),
                  ),
                  child: const Text(
                    "SAVE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Display Added Expenses
              SizedBox(
                height: MediaQuery.of(context).size.height / 2, // Proper height
                child: _expenses.isEmpty
                    ? const Center(
                  child: Text(
                    "No expenses added yet!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: _expenses.length,
                  itemBuilder: (context, index) {
                    final expense = _expenses[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent.shade100,
                        child: Icon(
                          expense["icon"] as IconData,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(expense["category"]),
                      subtitle: Text(expense["date"]),
                      trailing: Text(
                        "\$${expense["amount"]}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Save Expense
  void _saveExpense() {
    if (_amountController.text == "0" ||
        selectedCategory == "Category" ||
        selectedDate == "Date") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _expenses.add({
        "category": selectedCategory,
        "icon": _getCategoryIcon(selectedCategory),
        "amount": _amountController.text,
        "date": selectedDate,
      });

      // Clear Fields
      _amountController.text = "0";
      _descriptionController.clear();
      selectedCategory = "Category";
      selectedDate = "Date";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Expense added successfully"),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Input Tile
  Widget _buildInputTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blueGrey, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Category Selection
  void _showCategorySelection() {
    final categories = [
      "Food",
      "Transport",
      "Shopping",
      "Entertainment",
      "Health",
      "Travel",
      "Education",
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        children: categories
            .map((category) => ListTile(
          title: Text(category),
          onTap: () {
            setState(() {
              selectedCategory = category;
            });
            Navigator.pop(context);
          },
        ))
            .toList(),
      ),
    );
  }

  // Date Picker
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  // Category Icon
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Food":
        return Icons.fastfood;
      case "Transport":
        return Icons.directions_car;
      case "Shopping":
        return Icons.shopping_bag;
      case "Entertainment":
        return Icons.movie;
      case "Health":
        return Icons.favorite;
      case "Travel":
        return Icons.flight;
      case "Education":
        return Icons.school;
      default:
        return Icons.category;
    }
  }
}
