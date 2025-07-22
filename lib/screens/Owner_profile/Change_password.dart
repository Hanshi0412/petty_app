import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Change Password',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ChangePasswordScreen(),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0, // Hide default app bar
      ),
      body: Column(
        children: [
          // Removed the top status bar area as per request.
          // const SizedBox(height: 50), // Spacing below status bar - No longer needed here as the status bar is gone.

          // Main input fields
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 50.0,
              ), // Added vertical padding to give space at the top
              child: Column(
                children: [
                  _buildInputField('Email'),
                  const SizedBox(height: 20),
                  _buildInputField('Password', obscureText: true),
                  const SizedBox(height: 20),
                  _buildInputField('Re enter password', obscureText: true),
                  const SizedBox(height: 40),
                  _buildContinueButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String hintText, {bool obscureText = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(
              26,
              158,
              158,
              158,
            ), // Replaced Colors.grey.withOpacity(0.1)
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          border: InputBorder.none, // Removes the default underline
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent, // No border for enabled state
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent, // No border for focused state
            ),
          ),
        ),
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity, // Make button full width
      child: ElevatedButton(
        onPressed: () {
          // Handle Continue button press
          // ignore: avoid_print
          print('Continue button pressed!');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(
            0xFFFF8B14,
          ), // Changed button color to FF8B14
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
          elevation: 5,
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            fontSize: 16, // Changed from 18 to 16
            color: Colors.white,
            fontWeight: FontWeight
                .w600, // Changed from FontWeight.bold to FontWeight.w600 (semi-bold)
          ),
        ),
      ),
    );
  }
}
