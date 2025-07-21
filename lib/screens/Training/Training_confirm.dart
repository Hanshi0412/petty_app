import 'package:flutter/material.dart';

/// Defines the primary accent color for the application.
const Color primaryAppColor = Color(0xFFFF8B14);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking Confirmation',
      theme: ThemeData(
        // Define the color scheme using the custom primary color
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryAppColor,
          brightness: Brightness.light,
        ),
        fontFamily: 'Inter', // Consistent font
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(fontSize: 16.0, color: Colors.grey),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryAppColor, // Button background color
            foregroundColor: Colors.white, // Button text color
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12.0,
              ), // Rounded corners for buttons
            ),
            textStyle: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: const BookingSuccessScreen(),
    );
  }
}

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(
        context,
      ).scaffoldBackgroundColor, // Light gray background
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          children: [
            // Spacer to push content down from the status bar area
            const Spacer(flex: 2),

            // Success Checkmark Icon
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: primaryAppColor, // Background color for the circle
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    // Use primaryAppColor with opacity for the shadow
                    color: Color.fromARGB(
                      (0.3 * 255)
                          .round(), // Calculate new alpha for 30% opacity
                      primaryAppColor.red,
                      primaryAppColor.green,
                      primaryAppColor.blue,
                    ),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0, 5), // Soft shadow
                  ),
                ],
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 60.0, // Large checkmark icon
              ),
            ),
            const SizedBox(height: 32.0), // Spacing below the icon
            // Booking Successfully! Text
            Text(
              'Booking Successfully!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0), // Spacing below the main title
            // Your appointment has been fixed Text
            Text(
              'Your appointment has been fixed',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),

            // Spacer to push the button to the bottom
            const Spacer(flex: 3),

            // Home Button
            SizedBox(
              width: double.infinity, // Make button full width
              child: ElevatedButton(
                onPressed: () {
                  // This is a placeholder for navigation.
                  // In a real app, this would navigate to the home screen.
                  debugPrint('Home button pressed!');
                },
                child: const Text('Home'),
              ),
            ),
            const SizedBox(height: 24.0), // Padding at the very bottom
          ],
        ),
      ),
    );
  }
}
