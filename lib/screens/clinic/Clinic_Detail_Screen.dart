import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Pet Hospital',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(
            0xFFFF8B14, // Primary color value
            <int, Color>{
              50: Color(0xFFFF8B14),
              100: Color(0xFFFF8B14),
              200: Color(0xFFFF8B14),
              300: Color(0xFFFF8B14),
              400: Color(0xFFFF8B14),
              500: Color(0xFFFF8B14), // Your desired color
              600: Color(0xFFFF8B14),
              700: Color(0xFFFF8B14),
              800: Color(0xFFFF8B14),
              900: Color(0xFFFF8B14),
            },
          ),
          accentColor: const Color(0xFFFF8B14), // Accent color
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Using Inter font as per general instructions
      ),
      home: const HappyPetHomePage(),
    );
  }
}

class HappyPetHomePage extends StatelessWidget {
  const HappyPetHomePage({super.key});

  // Constants for positioning the logo to be half in the orange area and half out.
  static const double _orangeContainerHeight =
      60.0; // Height of the orange background section.
  static const double _logoHeight = 80.0;
  static const double _logoWidth = 102.0;
  // Fix: Directly assign the constant value for _logoOverlapHeight
  static const double _logoOverlapHeight =
      40.0; // How much of the logo overlaps into the bottom section (80.0 / 2 = 40.0)

  // The top position for the logo, calculated so its center aligns with the bottom of the orange container.
  // This means its top edge will be (orangeContainerHeight - _logoOverlapHeight) from the screen's top.
  static const double _logoTopPosition =
      _orangeContainerHeight - _logoOverlapHeight; // 60.0 - 40.0 = 20.0

  // The top padding for the content below the logo, to ensure it starts after the logo's bottom half
  // plus some additional desired spacing (16.0).
  // This padding is applied within the SingleChildScrollView, which starts right after the orange container.
  // So, it accounts for the _logoOverlapHeight (40.0) + desired spacing (16.0).
  static const double _contentPaddingTop =
      _logoOverlapHeight + 16.0; // 40.0 + 16.0 = 56.0

  final List<Service> _services = const <Service>[
    Service(
      title: 'Vaccinations',
      description:
          'Comprehensive vaccination programs to protect your pet from common diseases.',
      icon: Icons.local_hospital,
    ),
    Service(
      title: 'Routine Check-ups',
      description:
          'Regular examinations to monitor your pet\'s health and detect issues early.',
      icon: Icons.pets,
    ),
    Service(
      title: 'Emergency Care',
      description:
          '24/7 emergency services for urgent medical situations and critical care.',
      icon: Icons.emergency,
    ),
    Service(
      title: 'Surgical Procedures',
      description:
          'Expert surgical services including routine spay/neuter and complex operations.',
      icon: Icons.healing,
    ),
    Service(
      title: 'Dental Care',
      description:
          'Professional dental cleaning, extractions, and oral health assessments.',
      icon: Icons
          .health_and_safety, // Changed from Icons.dental_care to Icons.health_and_safety
    ),
    Service(
      title: 'X-rays & Diagnostics',
      description:
          'Advanced imaging and diagnostic tools for accurate and timely diagnoses.',
      icon: Icons.medical_services,
    ),
    Service(
      title: 'Grooming',
      description:
          'Full-service grooming to keep your pet clean, healthy, and looking great.',
      icon: Icons.cut,
    ),
    Service(
      title: 'Nutritional Counseling',
      description:
          'Personalized dietary plans to meet your pet\'s specific nutritional needs.',
      icon: Icons.food_bank,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[200], // Light grey background for the scaffold
      body: Stack(
        children: <Widget>[
          // Layer 1: Background content (Orange header and Main scrollable content)
          Column(
            children: <Widget>[
              // Orange Header
              Container(
                height:
                    _orangeContainerHeight, // Reduced height for the orange section
                decoration: const BoxDecoration(
                  color: Color(0xFFFF8B14), // The specified orange color
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0), // Corner radius 15
                    bottomRight: Radius.circular(15.0), // Corner radius 15
                  ),
                ),
              ),
              // Main content area - it needs to start lower due to the overlapping logo
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16.0,
                      _contentPaddingTop,
                      16.0,
                      16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // About Us Card
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ), // Rounded corners for the card
                          ),
                          elevation: 0, // No shadow for the card as per design
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'About Us',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Happy Pet Hospital is a friendly clinic offering expert care and advanced treatments. We\'re dedicated to keeping your pets healthy, happy, and loved.',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.phone, color: Colors.grey[700]),
                                    const SizedBox(width: 8),
                                    Text(
                                      '0112616161',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Location Card
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ), // Rounded corners for the card
                          ),
                          elevation: 0, // No shadow for the card
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Location',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Map Placeholder
                                Container(
                                  height: 150, // Height of the map area
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .grey, // Background color for the placeholder
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ), // Rounded corners for the map area
                                    image: const DecorationImage(
                                      // Using network image as per instructions, local assets are forbidden
                                      image: NetworkImage(
                                        'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
                                      ), // Replace with your map image
                                      fit: BoxFit.cover, // Cover the container
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Map will go here',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Services Section Title
                        const Text(
                          'Services',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // List of services details
                        Column(
                          children: _services.map<Widget>((Service service) {
                            return ServiceDetailCard(service: service);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Layer 2: The Logo, positioned above other content
          Positioned(
            top: _logoTopPosition, // Calculated top position for the logo
            left: 0,
            right: 0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  15.0,
                ), // Set corner radius to 15
                child: Image.network(
                  'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg', // Using placeholder URL as per instructions
                  width: _logoWidth, // Set width to 102
                  height: _logoHeight, // Set height to 80
                  fit: BoxFit.cover, // Ensure the image covers the given size
                  errorBuilder:
                      (
                        BuildContext context,
                        Object error,
                        StackTrace? stackTrace,
                      ) {
                        // Fallback text if image fails to load
                        return Container(
                          width: _logoWidth,
                          height: _logoHeight,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Text(
                              'Happy Pet Logo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Service {
  final String title;
  final String description;
  final IconData icon;

  const Service({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class ServiceDetailCard extends StatelessWidget {
  const ServiceDetailCard({required this.service, super.key});

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10.0,
        ), // Rounded corners for the card
      ),
      elevation: 0, // No shadow for the card
      margin: const EdgeInsets.only(
        bottom: 8.0,
      ), // Spacing between service cards
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(service.icon, color: Theme.of(context).primaryColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    service.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              service.description,
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
