import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color(0xFF476AD3),
        centerTitle: true,
        title: const Text(
          "Statistics",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
            const SizedBox(height: 10),

            // Donut Chart Card
            _buildChartCard(
              title: "Expense Overview",
              child: const SizedBox(
                height: 300,
                child: DonutChartSection(),
              ),
            ),

            const SizedBox(height: 20),

            // Expense Legend Section
            const Text(
              "Expense Breakdown",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
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
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const ExpenseLegendWidget(),
            ),
          ],
        ),
      ),
    );
  }

  // Chart Card Widget
  Widget _buildChartCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

// Donut Chart Component
class DonutChartSection extends StatelessWidget {
  const DonutChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sectionsSpace: 4,
            centerSpaceRadius: 70, // Creates the donut space
            sections: _getPieChartSections(),
            borderData: FlBorderData(show: false),
          ),
        ),
        const Text(
          "\$5,639",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // Pie Chart Sections
  List<PieChartSectionData> _getPieChartSections() {
    return [
      PieChartSectionData(
        color: const Color(0xFF003F87),
        value: 42,
        title: "42%",
        radius: 50,
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
      ),
      PieChartSectionData(
        color: const Color(0xFFFCA311),
        value: 20,
        title: "20%",
        radius: 50,
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
      ),
      PieChartSectionData(
        color: const Color(0xFFEF233C),
        value: 23,
        title: "23%",
        radius: 50,
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
      ),
      PieChartSectionData(
        color: const Color(0xFF00B4D8),
        value: 15,
        title: "15%",
        radius: 50,
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
      ),
    ];
  }
}

// Expense Legend Widget
class ExpenseLegendWidget extends StatelessWidget {
  const ExpenseLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ExpenseLegendItem(
          color: Color(0xFF003F87),
          text: "Shopping",
          amount: "\$245",
          percentage: "42%",
        ),
        ExpenseLegendItem(
          color: Color(0xFFFCA311),
          text: "Grocery",
          amount: "\$134",
          percentage: "20%",
        ),
        ExpenseLegendItem(
          color: Color(0xFFEF233C),
          text: "Bill Payment",
          amount: "\$184",
          percentage: "23%",
        ),
        ExpenseLegendItem(
          color: Color(0xFF00B4D8),
          text: "Other",
          amount: "\$184",
          percentage: "15%",
        ),
      ],
    );
  }
}

// Expense Legend Item
class ExpenseLegendItem extends StatelessWidget {
  final Color color;
  final String text;
  final String amount;
  final String percentage;

  const ExpenseLegendItem({
    super.key,
    required this.color,
    required this.text,
    required this.amount,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                percentage,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold, // Make percentage bold
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
