// ignore: file_names
import 'package:flutter/material.dart';

// DATA_MODEL (You already have this, just including it for completeness)
class Store {
  final String name;
  final String location;
  final String imageUrl;

  Store({required this.name, required this.location, required this.imageUrl});
}

// NEW: Product Data Model (from previous interaction, keeping it here)
class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
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
      title:
          'Pet Shop', // Changed title to be more generic after removing "Food shop"
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(
          0xFFF2F2F2,
        ), // Changed background color
      ),
      home: const FoodShopScreen(), // Set FoodShopScreen as the home
    );
  }
}

class FoodShopScreen extends StatefulWidget {
  const FoodShopScreen({super.key});

  @override
  State<FoodShopScreen> createState() => _FoodShopScreenState();
}

class _FoodShopScreenState extends State<FoodShopScreen> {
  // This screen does not have tabs based on the image, so _tabController is not needed here
  // If you later add categories/tabs like "Dry Food", "Wet Food", etc., you'd reintroduce it.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the start (left)
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top + 8,
          ), // System status bar space + some padding
          const StatusBarPlaceholder(),
          // Removed the "Food shop" title as per the change description
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SearchBarWidget(), // Reusing the SearchBarWidget
          ),
          const Expanded(
            child:
                FoodShopItemsList(), // This widget will display your store items
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
        backgroundColor: const Color(0xFFFF8B14), // Changed color
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// Reusing existing components:

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

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: const Icon(Icons.search, color: Color(0xFFFF8B14)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        ),
      ),
    );
  }
}

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
              icon: const Icon(Icons.home, color: Color(0xFFFF8B14)),
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Home tapped!')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.bookmark_border, color: Colors.grey),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bookmark tapped!')),
                );
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

// NEW: Widget to display store items for the "Food shop"
class FoodShopItemsList extends StatelessWidget {
  const FoodShopItemsList({super.key});

  // Example list of "Food" products. You can expand this as needed.
  List<Product> getFoodProducts() {
    const String placeholderImageUrl =
        'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg'; // Placeholder image

    return [
      Product(
        name: 'Royal Canin Adult Dog Food',
        description: 'High-quality kibble for adult dogs.',
        price: 35.99,
        imageUrl: placeholderImageUrl,
      ),
      Product(
        name: 'Whiskas Wet Cat Food (Chicken)',
        description: 'Delicious wet food for cats.',
        price: 1.50,
        imageUrl: placeholderImageUrl,
      ),
      Product(
        name: 'Tropical Fish Flakes',
        description: 'Complete diet for all tropical fish.',
        price: 7.25,
        imageUrl: placeholderImageUrl,
      ),
      Product(
        name: 'Rabbit Pellets with Hay',
        description: 'Nutrient-rich food for rabbits.',
        price: 12.00,
        imageUrl: placeholderImageUrl,
      ),
      Product(
        name: 'Bird Millet Spray',
        description: 'Natural treat for small birds.',
        price: 4.99,
        imageUrl: placeholderImageUrl,
      ),
      // Add more food products here
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> foodProducts = getFoodProducts();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: foodProducts.length,
      itemBuilder: (BuildContext context, int index) {
        final Product product = foodProducts[index];
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 2,
          child: InkWell(
            onTap: () {
              // Handle tapping on a product, e.g., navigate to a detailed product page
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped on ${product.name}')),
              );
              // Example of navigating to a product detail screen:
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ProductDetailScreen(product: product),
              //   ),
              // );
            },
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Reduced padding
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.imageUrl,
                      width: 60, // Reduced size
                      height: 60, // Reduced size
                      fit: BoxFit.cover,
                      errorBuilder:
                          (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) => const Icon(
                            Icons.broken_image,
                            size: 60, // Reduced size
                            color: Colors.grey,
                          ),
                    ),
                  ),
                  const SizedBox(width: 10), // Reduced spacing
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14, // Slightly reduced font size
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3), // Reduced spacing
                        Text(
                          product.description,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10, // Slightly reduced font size
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5), // Reduced spacing
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF8B14),
                            fontSize: 13, // Slightly reduced font size
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Optional: Add a button to add to cart or view details
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 12, // Reduced icon size
                      color: Colors.grey[400],
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
