import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

// DATA_MODEL
class FoodShopProfileModel {
  final String name;
  final String description;
  final String contactNumber;
  final String category;
  final List<String> productsAndServices;
  final List<String> productImageUrls;
  final String avatarUrl;

  FoodShopProfileModel({
    required this.name,
    required this.description,
    required this.contactNumber,
    required this.category,
    required this.productsAndServices,
    required this.productImageUrls,
    required this.avatarUrl,
  });
}

class FoodShopProfileData extends ChangeNotifier {
  late final FoodShopProfileModel _profile;

  FoodShopProfileData()
    : _profile = FoodShopProfileModel(
        name: 'Pet Mart Lanka',
        description:
            'A trusted destination for pedigree pets, premium foods, and all pet essentials. With in-house vet consultations, Pet Mart Lanka ensures your furry friends get the best care under one roof.',
        contactNumber: '+94 11 255 6789',
        category: 'All-in-one pet store',
        productsAndServices: <String>[
          'Wide range of pedigree puppies and kittens',
          'Imported pet foods (Royal Canin, Pedigree, Whiskas)',
          'Pet accessories, grooming products',
          'In-house vet consultations',
        ],
        productImageUrls: List<String>.generate(
          6,
          (int index) =>
              'https://placehold.co/150x150/E0E0E0/333333?text=Product+${index + 1}',
        ),
        avatarUrl:
            'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg', // Replaced local asset with network placeholder URL
      );

  FoodShopProfileModel get profile => _profile;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Mart Lanka',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: ChangeNotifierProvider<FoodShopProfileData>(
        create: (BuildContext context) => FoodShopProfileData(),
        builder: (BuildContext context, Widget? child) =>
            const FoodShopProfileScreen(),
      ),
    );
  }
}

class FoodShopProfileScreen extends StatelessWidget {
  const FoodShopProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodShopProfileModel profileData = Provider.of<FoodShopProfileData>(
      context,
    ).profile;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Top Status Bar and App Bar Area
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    // Status Bar Placeholder (simulating 9:41, signal, battery)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '9:41',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
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
                    ),
                    const SizedBox(height: 10),
                    // Orange Header Section (now full width)
                    Container(
                      height: 86,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),

              // Profile Card Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: const Color.fromARGB(0x33, 0x9E, 0x9E, 0x9E),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 50),
                          Text(
                            profileData.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            profileData.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(
                                Icons.call,
                                color: Colors.orange,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                profileData.contactNumber,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '• Category: ${profileData.category}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '• Products/Services:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: profileData.productsAndServices
                                        .map<Widget>(
                                          (String service) =>
                                              Text('• $service'),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Shop Avatar
                    Positioned(
                      // Lifts the avatar 50 pixels above the card's top edge
                      top: -50,
                      // Calculate left to center the 100px avatar within the Stack's width (screen width - 2*16px padding)
                      left:
                          (MediaQuery.of(context).size.width -
                              (2 * 16.0) -
                              100) /
                          2,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: const Color.fromARGB(
                                0x4D,
                                0x9E,
                                0x9E,
                                0x9E,
                              ),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          image: DecorationImage(
                            image: NetworkImage(profileData.avatarUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Products Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Products', // Changed from 'Produits' to 'Products'
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                      itemCount: profileData.productImageUrls.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            profileData.productImageUrls[index],
                            fit: BoxFit.cover,
                            errorBuilder:
                                (
                                  BuildContext context,
                                  Object error,
                                  StackTrace? stackTrace,
                                ) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                  ),
                                ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Show Products Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press, e.g., navigate to a full product list
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange, // Text color
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(
                        double.infinity,
                        50,
                      ), // Full width
                    ),
                    child: const Text(
                      'Show More Products',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: const Color.fromARGB(0x33, 0x9E, 0x9E, 0x9E),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
              const SizedBox(width: 48),
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
