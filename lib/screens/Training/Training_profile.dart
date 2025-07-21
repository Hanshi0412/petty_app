import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Training Center',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TrainingDetailScreen(),
      debugShowCheckedModeBanner: false, // Hide the debug banner
    );
  }
}

class TrainingDetailScreen extends StatelessWidget {
  const TrainingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // AppBar Hidden - Top Banner Used
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Banner Section
            Stack(
              children: [
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  top: 50, // Adjusted top position to move the image down
                  left: MediaQuery.of(context).size.width / 2 - 40,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    // Replaced AssetImage with Image.network as per instructions
                    backgroundImage: NetworkImage(
                      "https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // About Us
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "About us",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Pawsitive Start is a friendly pet training center focused on positive methods to help pets learn, grow, and thrive. We make training simple, safe, and fun!",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Icon(Icons.phone, size: 18, color: Colors.orange),
                      SizedBox(width: 8),
                      Text("+1 (555) 789-1234"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Services
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Our Services",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Basic Obedience Training\nSit, stay, come, leash walking\nFor puppies and adult dogs\nGroup or private sessions\n",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Puppy Socialization\nEarly training for pups [8–16 weeks]\nExposure to sounds, people, and other puppies\n",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Behavioral Correction\nOff-leash control\nTrick training\nTherapy or service dog prep",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Book Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Implement booking logic here
                  },
                  child: const Text(
                    "Book",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.home_outlined, color: Colors.orange),
              SizedBox(width: 24),
              Icon(Icons.notifications_none, color: Colors.orange),
              Icon(Icons.person_outline, color: Colors.orange),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
