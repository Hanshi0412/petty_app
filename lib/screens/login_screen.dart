// Login Screen Code

import 'package:flutter/material.dart';
// Do NOT import home_screen.dart here if you are navigating by named routes.
// The route definition in main.dart handles the HomeScreen class reference.
// If you must use MaterialPageRoute.builder directly, then import it:
// import 'package:petty_app/screens/home_screen.dart';

class LoginFlowManager extends StatefulWidget {
  const LoginFlowManager({super.key});

  @override
  State<LoginFlowManager> createState() => _LoginFlowManagerState();
}

class _LoginFlowManagerState extends State<LoginFlowManager> {
  bool _isLogin =
      true; // This state is currently unused for UI switching in this example

  void _toggleLoginSignup() {
    setState(() {
      _isLogin = !_isLogin;
    });
    // In a real app, this might navigate to a SignUpScreen using a named route
    // For example: Navigator.pushNamed(context, '/signup');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sign up functionality would go here!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // We always display LoginScreen for this example.
    return LoginScreen(onToggle: _toggleLoginSignup);
  }
}

class LoginScreen extends StatelessWidget {
  final VoidCallback onToggle;
  const LoginScreen({super.key, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 40),
                    // Email Field
                    const ShadowedTextField(
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    // Password Field
                    const ShadowedTextField(
                      labelText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to HomeScreen using named route
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .orange, // Use a fixed color or Theme.of(context).primaryColor
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          // Simulate forgot password logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Forgot Password clicked!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Sign up prompt (sticky at the bottom)
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account yet?"),
                  TextButton(
                    onPressed:
                        onToggle, // Call the toggle callback (e.g., to navigate to signup)
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShadowedTextField extends StatelessWidget {
  final String labelText;
  final TextInputType? keyboardType;
  final bool obscureText;

  const ShadowedTextField({
    super.key,
    required this.labelText,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none, // Remove default border
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          labelStyle: TextStyle(color: Colors.grey[600]), // Style for the label
          floatingLabelBehavior:
              FloatingLabelBehavior.auto, // Ensures label floats nicely
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
      ),
    );
  }
}
