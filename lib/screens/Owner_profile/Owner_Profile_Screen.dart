import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// DATA_MODEL
class UserProfile with ChangeNotifier {
  String _name;
  String _email;
  String _imageUrl;
  String _fullName;
  String _contactEmail;
  String _phoneNumber;
  String _address;

  UserProfile({
    required String name,
    required String email,
    required String imageUrl,
    required String fullName,
    required String contactEmail,
    required String phoneNumber,
    required String address,
  }) : _name = name,
       _email = email,
       _imageUrl = imageUrl,
       _fullName = fullName,
       _contactEmail = contactEmail,
       _phoneNumber = phoneNumber,
       _address = address;

  String get name => _name;
  String get email => _email;
  String get imageUrl => _imageUrl;
  String get fullName => _fullName;
  String get contactEmail => _contactEmail;
  String get phoneNumber => _phoneNumber;
  String get address => _address;

  set name(String newName) {
    if (_name != newName) {
      _name = newName;
      notifyListeners();
    }
  }

  set email(String newEmail) {
    if (_email != newEmail) {
      _email = newEmail;
      notifyListeners();
    }
  }

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

class PreferenceItem {
  final String title;
  final VoidCallback onTap;

  const PreferenceItem({required this.title, required this.onTap});
}

class NavBarItemData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const NavBarItemData({
    required this.icon,
    required this.label,
    required this.onTap,
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
      title: 'Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<UserProfile>(
        create: (BuildContext context) => UserProfile(
          name: 'John',
          email: 'John@gmail.com',
          imageUrl:
              'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
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
    final List<PreferenceItem> preferences = <PreferenceItem>[
      PreferenceItem(
        title: 'Change Password',
        onTap: () {
          // Handle change password action
        },
      ),
      PreferenceItem(
        title: 'Upcoming Appointments',
        onTap: () {
          // Handle upcoming appointments action
        },
      ),
    ];

    final List<NavBarItemData> navBarItems = <NavBarItemData>[
      NavBarItemData(
        icon: Icons.home,
        label: 'Home',
        onTap: () {
          // Handle home tap
        },
      ),
      NavBarItemData(
        icon: Icons.bookmark,
        label: 'Saved',
        onTap: () {
          // Handle saved tap
        },
      ),
      NavBarItemData(
        icon: Icons.shopping_bag,
        label: 'Cart',
        onTap: () {
          // Handle cart tap
        },
      ),
      NavBarItemData(
        icon: Icons.person,
        label: 'Profile',
        onTap: () {
          // Handle profile tap
        },
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // Changed background color
      appBar: AppBar(
        toolbarHeight: 0, // Hides the default AppBar
      ),
      body: Column(
        children: <Widget>[
          const TopSection(),
          // Added space to move everything below it down a bit
          const SizedBox(height: 20.0),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const PersonalDetailsCard(),
                  const SizedBox(height: 20),
                  PreferencesSection(preferences: preferences),
                ],
              ),
            ),
          ),
          CustomBottomNavigationBar(navBarItems: navBarItems),
        ],
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Increased sectionHeight to ensure name and email are fully visible
    final double sectionHeight =
        MediaQuery.of(context).size.height * 0.25 + 40.0;
    const double profilePictureRadius =
        53.5; // Changed from 60 to 53.5 for 107x107 diameter

    return SizedBox(
      height: sectionHeight,
      child: Stack(
        children: <Widget>[
          // Background - Orange top half with bottom radius
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: sectionHeight / 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
            ),
          ),
          // Background - White bottom half
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: sectionHeight / 2,
            child: Container(color: Colors.white),
          ),

          // Edit button (top-right of the orange section, with white background)
          Positioned(
            top:
                MediaQuery.of(context).padding.top +
                95, // Adjusted this value to move it down
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Color(0xFFFF8B14), // Specific color FF8B14
                  size: 20, // Adjusted size to match camera icon
                ),
                onPressed: () {
                  final UserProfile userProfile = Provider.of<UserProfile>(
                    context,
                    listen: false,
                  );
                  userProfile.name = userProfile.name == 'John'
                      ? 'Jane'
                      : 'John';
                  userProfile.email = userProfile.email == 'John@gmail.com'
                      ? 'jane@example.com'
                      : 'John@gmail.com';
                  userProfile.fullName = userProfile.fullName == 'Emily Johnson'
                      ? 'Jane Doe'
                      : 'Emily Johnson';
                  userProfile.contactEmail =
                      userProfile.contactEmail == 'emily.johnson@example.com'
                      ? 'jane.doe@example.com'
                      : 'emily.johnson@example.com';
                  userProfile.phoneNumber =
                      userProfile.phoneNumber == '+1 (555) 234-7890'
                      ? '+1 (987) 654-3210'
                      : '+1 (555) 234-7890';
                  userProfile.address =
                      userProfile.address == '123 Maple Lane, Springfield'
                      ? '456 Oak Avenue, Metropolis'
                      : '123 Maple Lane, Springfield';
                },
                padding: EdgeInsets.zero, // Remove default IconButton padding
                constraints:
                    const BoxConstraints(), // Remove default IconButton constraints
                splashRadius: 20, // Control splash radius if desired
              ),
            ),
          ),

          // Profile Picture and Details - Centered on the split line
          Positioned(
            top: sectionHeight / 2 - profilePictureRadius,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Consumer<UserProfile>(
                      builder:
                          (
                            BuildContext context,
                            UserProfile profile,
                            Widget? child,
                          ) {
                            return CircleAvatar(
                              radius: profilePictureRadius,
                              backgroundImage: NetworkImage(profile.imageUrl),
                              backgroundColor: Colors.white,
                            );
                          },
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.orange,
                            size: 20,
                          ),
                          onPressed: () {
                            // Handle camera icon tap
                            // For example, trigger image selection or camera
                          },
                          padding: EdgeInsets
                              .zero, // Remove default IconButton padding
                          constraints:
                              const BoxConstraints(), // Remove default IconButton constraints
                          splashRadius: 20, // Control splash radius if desired
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Consumer<UserProfile>(
                  builder:
                      (
                        BuildContext context,
                        UserProfile profile,
                        Widget? child,
                      ) {
                        return Text(
                          profile.name,
                          style: const TextStyle(
                            color:
                                Colors.black87, // Visible on white background
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                ),
                Consumer<UserProfile>(
                  builder:
                      (
                        BuildContext context,
                        UserProfile profile,
                        Widget? child,
                      ) {
                        return Text(
                          profile.email,
                          style: const TextStyle(
                            color: Colors.grey, // Visible on white background
                            fontSize: 15, // Changed from 16 to 15
                          ),
                        );
                      },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PersonalDetailsCard extends StatelessWidget {
  const PersonalDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProfile userProfile = Provider.of<UserProfile>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Personal Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DetailRow(label: 'Name:', value: userProfile.fullName),
                DetailRow(label: 'Email:', value: userProfile.contactEmail),
                DetailRow(
                  label: 'Phone Number:',
                  value: userProfile.phoneNumber,
                ),
                DetailRow(label: 'Address:', value: userProfile.address),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PreferencesSection extends StatelessWidget {
  final List<PreferenceItem> preferences;

  const PreferencesSection({required this.preferences, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Preferences',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        ...preferences.map<Widget>((PreferenceItem item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: PreferenceTile(title: item.title, onTap: item.onTap),
          );
        }).toList(),
      ],
    );
  }
}

class PreferenceTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const PreferenceTile({required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120, // Adjust width as needed for alignment
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final List<NavBarItemData> navBarItems;

  const CustomBottomNavigationBar({required this.navBarItems, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color.fromRGBO(158, 158, 158, 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ...navBarItems
              .sublist(0, 2)
              .map<Widget>(
                (NavBarItemData item) => NavBarItemWidget(
                  icon: item.icon,
                  label: item.label,
                  onTap: item.onTap,
                ),
              ),
          const NavBarFabWidget(),
          ...navBarItems
              .sublist(2, 4)
              .map<Widget>(
                (NavBarItemData item) => NavBarItemWidget(
                  icon: item.icon,
                  label: item.label,
                  onTap: item.onTap,
                ),
              ),
        ],
      ),
    );
  }
}

class NavBarItemWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const NavBarItemWidget({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(icon, color: Colors.grey[600]),
          onPressed: onTap,
        ),
        // Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }
}

class NavBarFabWidget extends StatelessWidget {
  const NavBarFabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Handle FAB tap
      },
      backgroundColor: Colors.orange,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
