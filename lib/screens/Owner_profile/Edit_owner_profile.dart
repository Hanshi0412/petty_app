import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// DATA_MODEL
class UserProfile with ChangeNotifier {
  String _imageUrl;
  String _fullName;
  String _contactEmail;
  String _phoneNumber;
  String _address;

  UserProfile({
    required String imageUrl,
    required String fullName,
    required String contactEmail,
    required String phoneNumber,
    required String address,
  }) : _imageUrl = imageUrl,
       _fullName = fullName,
       _contactEmail = contactEmail,
       _phoneNumber = phoneNumber,
       _address = address;

  String get imageUrl => _imageUrl;
  String get fullName => _fullName;
  String get contactEmail => _contactEmail;
  String get phoneNumber => _phoneNumber;
  String get address => _address;

  set imageUrl(String newUrl) {
    if (_imageUrl != newUrl) {
      _imageUrl = newUrl;
      notifyListeners();
    }
  }

  set fullName(String newFullName) {
    if (_fullName != newFullName) {
      _fullName = newFullName;
      notifyListeners();
    }
  }

  set contactEmail(String newContactEmail) {
    if (_contactEmail != newContactEmail) {
      _contactEmail = newContactEmail;
      notifyListeners();
    }
  }

  set phoneNumber(String newPhoneNumber) {
    if (_phoneNumber != newPhoneNumber) {
      _phoneNumber = newPhoneNumber;
      notifyListeners();
    }
  }

  set address(String newAddress) {
    if (_address != newAddress) {
      _address = newAddress;
      notifyListeners();
    }
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
      title: 'Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<UserProfile>(
        create: (BuildContext context) => UserProfile(
          imageUrl:
              'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg', // Placeholder image URL
          fullName: 'Emily Johnson',
          contactEmail: 'emily.johnson@example.com',
          phoneNumber: '+1 (555) 234-7890',
          address: '123 Maple Lane, Springfield',
        ),
        builder: (BuildContext context, Widget? child) => const ProfileScreen(),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Background color from the image
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Transparent to show curved background
        elevation: 0,
        toolbarHeight: 0, // Hides the default AppBar
      ),
      body: Column(
        children: <Widget>[
          // Top section with curved background and profile pic
          const TopProfileSection(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const PersonalDetailsSection(),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Save button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopProfileSection extends StatelessWidget {
  const TopProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfile>(
      builder: (BuildContext context, UserProfile profile, Widget? child) {
        return SizedBox(
          height:
              150, // Height needed to show the entire avatar (top 30 + diameter 104 + border 8 = 142, so 150 is fine)
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              // Orange background curve
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 86,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              // Profile picture
              Positioned(
                top: 30, // Avatar's top remains at 30 from the Stack's top
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ), // White border around the image
                      ),
                      child: CircleAvatar(
                        radius:
                            52, // Changed from 60 to 52 for 104 width/height
                        backgroundImage: NetworkImage(profile.imageUrl),
                      ),
                    ),
                    Positioned(
                      bottom: 5, // Adjust camera icon position
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                          onPressed: () {
                            // Handle camera icon tap
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          splashRadius: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PersonalDetailsSection extends StatelessWidget {
  const PersonalDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer is used here to listen to changes in UserProfile
    return Consumer<UserProfile>(
      builder: (BuildContext context, UserProfile userProfile, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Personal Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextFieldWithLabel('Name:', userProfile.fullName),
            const SizedBox(height: 15),
            _buildTextFieldWithLabel('Email:', userProfile.contactEmail),
            const SizedBox(height: 15),
            _buildTextFieldWithLabel('Phone Number:', userProfile.phoneNumber),
            const SizedBox(height: 15),
            _buildTextFieldWithLabel('Address:', userProfile.address),
          ],
        );
      },
    );
  }

  Widget _buildTextFieldWithLabel(String label, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withAlpha((255 * 0.1).round()),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            readOnly: true, // As per the image, fields seem read-only
            controller: TextEditingController(text: initialValue),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              border: InputBorder.none, // Removes the default underline
            ),
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
