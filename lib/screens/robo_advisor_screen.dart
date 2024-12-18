import 'package:flutter/material.dart';

class RoboAdvisorScreen extends StatelessWidget {
  const RoboAdvisorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with solid blue background and white arrow icon
      appBar: AppBar(
        title: const Text(
          "Robo Advisor",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF476AD3), // Solid blue background
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      backgroundColor: Colors.grey.shade200,

      // Body Section
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: const [
                _ChatBubble(
                  message: "Hello! I am your Robo Advisor. How can I assist you today?",
                  isUserMessage: false, // Bot message
                ),
                _ChatBubble(
                  message: "What is my current balance?",
                  isUserMessage: true, // User message with gradient
                ),
                _ChatBubble(
                  message: "Your current balance is \$4800.00.",
                  isUserMessage: false, // Bot message
                ),
                _ChatBubble(
                  message: "Would you like to create a new budget?",
                  isUserMessage: false, // Bot message
                ),
              ],
            ),
          ),
          const _ChatInputField(), // Input field at the bottom
        ],
      ),
    );
  }
}

// Chat Bubble Widget
class _ChatBubble extends StatelessWidget {
  final String message;
  final bool isUserMessage;

  const _ChatBubble({
    required this.message,
    required this.isUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: isUserMessage
              ? const LinearGradient(
            colors: [Color(0xFF252D4C), Color(0xFF476AD3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null, // Gradient for user messages only
          color: isUserMessage ? null : Colors.white, // White for bot messages
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isUserMessage ? const Radius.circular(12) : Radius.zero,
            bottomRight:
            isUserMessage ? Radius.zero : const Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isUserMessage ? Colors.white : Colors.black87,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// Chat Input Field
class _ChatInputField extends StatelessWidget {
  const _ChatInputField();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  const Icon(Icons.sentiment_satisfied_alt,
                      color: Colors.grey, size: 24),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                      cursorColor: const Color(0xFF476AD3),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: const Color(0xFF476AD3),
            radius: 26,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                // Handle send button logic
              },
            ),
          ),
        ],
      ),
    );
  }
}
