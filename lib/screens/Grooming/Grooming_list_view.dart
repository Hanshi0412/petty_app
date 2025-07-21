import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: GroomingScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class GroomingScreen extends StatelessWidget {
  const GroomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> groomingList = [
      {
        'image': 'assets/images/grooming1.png',
        'title': 'Rainbow pet grooming',
        'location': 'Kottalagamulla',
      },
      {
        'image': 'assets/images/grooming2.png',
        'title': 'Fur Buddies Pet Grooming and Store',
        'location': 'Panipitiya',
      },
      {
        'image': 'assets/images/grooming3.png',
        'title': 'Dog Grooming',
        'location': 'Kadawatha',
      },
      {
        'image': 'assets/images/grooming4.png',
        'title': 'Zootopia Vets',
        'location': 'Nugegoda',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Grooming',
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

            // List of Grooming Services
            Expanded(
              child: ListView.builder(
                itemCount: groomingList.length,
                itemBuilder: (context, index) {
                  final item = groomingList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
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
            children: const [
              Icon(Icons.home_outlined, color: Colors.orange),
              SizedBox(width: 24), // For the FAB space
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
