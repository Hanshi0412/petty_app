// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';

// DATA_MODEL for Clinics
class Clinic {
  final String name;
  final String location;
  final String imageUrl; // For the clinic logo/image
  final String phoneNumber; // Added telephone number

  Clinic({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.phoneNumber, // Initialize phoneNumber
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinic Finder', // App title
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(
          0xFFF2F2F2,
        ), // Light grey background
      ),
      home: const ClinicFinderHomePage(), // Set this as the home screen
    );
  }
}

class ClinicFinderHomePage extends StatelessWidget {
  const ClinicFinderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top + 8,
          ), // System status bar space + some padding
          const StatusBarPlaceholder(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: SearchBarWidget(
              hintText: 'Find my clinic',
            ), // Reusing SearchBarWidget with custom hint
          ),
          const Expanded(
            child: ClinicListView(), // List of clinic cards
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Add button tapped!')));
        },
        backgroundColor: const Color(0xFFFF8B14), // Orange color for FAB
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// Reusable StatusBarPlaceholder
class StatusBarPlaceholder extends StatelessWidget {
  const StatusBarPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('9:41', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: <Widget>[
              Icon(Icons.signal_cellular_alt, size: 18),
              SizedBox(width: 4),
              Icon(Icons.wifi, size: 18),
              SizedBox(width: 4),
              Icon(Icons.battery_full, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}

// Modified SearchBarWidget to accept a hintText
class SearchBarWidget extends StatelessWidget {
  final String hintText;

  const SearchBarWidget({super.key, this.hintText = 'Search'});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(25),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText, // Use the provided hintText
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFFF8B14), // Orange color for search icon
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        ),
      ),
    );
  }
}

// Widget to display the list of clinics
class ClinicListView extends StatelessWidget {
  const ClinicListView({super.key});

  List<Clinic> getClinics() {
    // Placeholder image URLs - in a real app, these would be actual clinic logos
    const String defaultClinicImageUrl =
        'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg'; // Generic placeholder URL

    return <Clinic>[
      Clinic(
        name: 'Happy pet',
        location: 'Polgasowita',
        imageUrl:
            'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg', // Example image (replace with actual)
        phoneNumber: '+94 11 234 5678',
      ),
      Clinic(
        name: 'Vets & Pets Animal Hospital',
        location: 'Battaramulla',
        imageUrl:
            'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg', // Example image (replace with actual)
        phoneNumber: '+94 77 123 4567',
      ),
      Clinic(
        name: 'Petvet clinic',
        location: 'Pannipitiya',
        imageUrl:
            'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg', // Example image (replace with actual)
        phoneNumber: '+94 71 987 6543',
      ),
      Clinic(
        name: 'Royal Pets Care Animal Clinic',
        location: 'Pannipitiya',
        imageUrl:
            'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg', // Example image (replace with actual)
        phoneNumber: '+94 70 555 1234',
      ),
      Clinic(
        name: 'Animal Care Clinic Kandy',
        location: 'Kandy',
        imageUrl: defaultClinicImageUrl,
        phoneNumber: '+94 81 222 3344',
      ),
      Clinic(
        name: 'Colombo Pet Hospital',
        location: 'Colombo 7',
        imageUrl: defaultClinicImageUrl,
        phoneNumber: '+94 11 789 0123',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Clinic> clinics = getClinics();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: clinics.length,
      itemBuilder: (BuildContext context, int index) {
        final Clinic clinic = clinics[index];
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 2,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped on ${clinic.name}')),
              );
              // Here you can navigate to a detailed clinic profile screen
              // Example:
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ClinicDetailScreen(clinic: clinic),
              //   ),
              // );
            },
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              height:
                  100, // Increased height for clinic card to fit phone number
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(
                      8.0,
                    ), // Padding around the image
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Slightly less rounded than card
                      child: Image.network(
                        clinic.imageUrl,
                        width: 84, // Fixed width for the image
                        height: 84, // Fixed height for the image
                        fit: BoxFit.cover,
                        errorBuilder:
                            (
                              BuildContext context,
                              Object error,
                              StackTrace? stackTrace,
                            ) => const Icon(
                              Icons.broken_image,
                              size:
                                  84, // Adjusted icon size to match image dimensions
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ), // Spacing between image and text - REDUCED FROM 16.0
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          clinic.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          clinic.location,
                          style: TextStyle(color: Colors.grey[600]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          clinic.phoneNumber, // Display the phone number
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Reusable CustomBottomNavigationBar
class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Color(0xFFFF8B14), // Orange for selected home icon
              ),
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Home tapped!')));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.folder_open,
                color: Colors.grey,
              ), // Changed to folder_open for icon in image
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Folder tapped!')));
              },
            ),
            const SizedBox(width: 48), // Space for the FAB
            IconButton(
              icon: const Icon(Icons.shopping_bag_outlined, color: Colors.grey),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Shopping bag tapped!')),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person_outline, color: Colors.grey),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile tapped!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
