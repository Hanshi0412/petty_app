import 'package:flutter/material.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> trainingList = [
      {
        'image':
            'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
        'title': 'DEUTSCHLAND K9 TRAINING N BOARDING LANKA PVT LTD',
        'location': 'Boralesgamuwa',
      },
      {
        'image':
            'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
        'title': 'Puppy to Buddy Training',
        'location': 'Nugegoda',
      },
      {
        'image':
            'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
        'title': 'Paw Paradise',
        'location': 'Homagama',
      },
      {
        'image':
            'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
        'title': 'The Dog Lady',
        'location': 'Peliyagoda',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '', // Removed "Training" text
          style: TextStyle(
            color: Colors.grey,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.orange),
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // List of Training Services
            Expanded(
              child: ListView.builder(
                itemCount: trainingList.length,
                itemBuilder: (context, index) {
                  final Map<String, String> item = trainingList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item['image']!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        item['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(item['location']!),
                    ),
                  );
                },
              ),
            ),
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
            children: const <Widget>[
              Icon(Icons.home_outlined, color: Colors.orange),
              SizedBox(width: 24), // Spacer for FloatingActionButton
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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Services', // Changed "Training App" to "Pet Services"
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const TrainingScreen(),
    );
  }
}
