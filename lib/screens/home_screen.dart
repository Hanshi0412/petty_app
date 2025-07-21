import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

MaterialColor createMaterialColor(Color color) {
  List<double> strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  // ignore: deprecated_member_use
  final int r = (color.value >> 16) & 0xFF;
  // ignore: deprecated_member_use
  final int g = (color.value >> 8) & 0xFF;
  // ignore: deprecated_member_use
  final int b = color.value & 0xFF;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (double strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  // ignore: deprecated_member_use
  return MaterialColor(color.value, swatch);
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
      title: 'Pet Care App',
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xFFFF8B14)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: MultiProvider(
        providers: <ChangeNotifierProvider<ChangeNotifier>>[
          ChangeNotifierProvider<BottomNavBarData>(
            create: (BuildContext context) => BottomNavBarData(),
          ),
          ChangeNotifierProvider<SearchData>(
            create: (BuildContext context) => SearchData(),
          ),
        ],
        builder: (BuildContext context, Widget? child) => const HomeScreen(),
      ),
    );
  }
}

class BottomNavBarData extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }
}

class SearchData extends ChangeNotifier {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  SearchData() {
    // Add a listener to the controller to notify consumers when the text changes.
    // This is because the suffix icon logic depends on `searchController.text.isNotEmpty`.
    _searchController.addListener(_onSearchControllerChanged);
  }

  bool get isSearching => _isSearching;
  TextEditingController get searchController => _searchController;
  String get searchText => _searchController.text;

  void toggleSearch() {
    _isSearching = !_isSearching;
    if (!_isSearching) {
      _searchController.clear(); // Clear search text when closing
    }
    notifyListeners(); // Notify when search mode changes
  }

  // Internal method to be called when _searchController's text changes.
  void _onSearchControllerChanged() {
    // This method is called whenever the text in the controller changes.
    // It should trigger a rebuild of widgets that depend on the search text,
    // e.g., the suffix icon logic in SearchInputWidget.
    notifyListeners();
  }

  // Method to clear the search input, exposed to external widgets
  void clearSearch() {
    _searchController.clear();
    // _onSearchControllerChanged will be called automatically due to clear(),
    // which then calls notifyListeners(). So no need for an explicit notifyListeners() here.
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchControllerChanged);
    _searchController.dispose();
    super.dispose();
  }
}

class ServiceItem {
  final String title;
  final String imageUrl; // Changed from IconData to String for image URL

  const ServiceItem({
    required this.title,
    required this.imageUrl, // Updated to imageUrl
  });
}

class PetItem {
  final String? imageUrl;
  final bool isAddButton;

  const PetItem({this.imageUrl, this.isAddButton = false});
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Updated serviceItems to use image URLs
  final List<ServiceItem> serviceItems = const <ServiceItem>[
    ServiceItem(title: 'Clinic', imageUrl: 'lib/assets/images/Clinic_icon.png'),
    ServiceItem(
      title: 'Grooming',
      imageUrl:
          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    ),
    ServiceItem(
      title: 'Store',
      imageUrl:
          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    ),
    ServiceItem(
      title: 'Training',
      imageUrl:
          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    ),
    ServiceItem(
      title: 'Booking',
      imageUrl:
          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    ),
    ServiceItem(
      title: 'Diary',
      imageUrl:
          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    ),
  ];

  final List<PetItem> petItems = const <PetItem>[
    PetItem(isAddButton: true),
    PetItem(
      imageUrl:
          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    ),
    PetItem(
      imageUrl:
          'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: const CustomBottomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const HomeHeader(),
            Consumer<SearchData>(
              builder:
                  (BuildContext context, SearchData searchData, Widget? child) {
                    if (searchData.isSearching) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 10.0,
                        ),
                        child: SearchInputWidget(
                          searchData: searchData,
                          onSearchClosed: () {
                            searchData.toggleSearch();
                          },
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.0, // Changed from 0.7 to 1.0
                        ),
                    itemCount: serviceItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ServiceItem item = serviceItems[index];
                      return ServiceCard(
                        title: item.title,
                        imageUrl: item.imageUrl, // Passed imageUrl
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Pets',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: petItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final PetItem pet = petItems[index];
                        if (pet.isAddButton) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xFFFF8B14),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(pet.imageUrl!),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchData>(
      builder: (BuildContext context, SearchData searchData, Widget? child) {
        return Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            bottom: 24,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFFF8B14),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hello Alex',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Good Morning',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      searchData.isSearching ? Icons.close : Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      searchData.toggleSearch();
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String imageUrl; // Changed from IconData to String for image URL

  const ServiceCard({
    super.key,
    required this.title,
    required this.imageUrl, // Updated to imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                child: Image.network(
                  imageUrl, // Display the image from URL
                  width: 36, // Match original icon size
                  height: 36, // Match original icon size
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchInputWidget extends StatelessWidget {
  final SearchData searchData;
  final VoidCallback onSearchClosed;

  const SearchInputWidget({
    super.key,
    required this.searchData,
    required this.onSearchClosed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchData.searchController,
      decoration: InputDecoration(
        hintText: 'Search...',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: searchData.searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  // Call the exposed method on SearchData to clear the text.
                  searchData.clearSearch();
                },
              )
            : IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: onSearchClosed,
              ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
      ),
      autofocus: true,
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavBarData bottomNavBarData = context.watch<BottomNavBarData>();

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomAppBar(
            color: Colors.white,
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            elevation: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.home_outlined,
                      color: bottomNavBarData.selectedIndex == 0
                          ? const Color(0xFFFF8B14)
                          : Colors.grey,
                    ),
                    onPressed: () => bottomNavBarData.setIndex(0),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: bottomNavBarData.selectedIndex == 1
                          ? const Color(0xFFFF8B14)
                          : Colors.grey,
                    ),
                    onPressed: () => bottomNavBarData.setIndex(1),
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: bottomNavBarData.selectedIndex == 2
                          ? const Color(0xFFFF8B14)
                          : Colors.grey,
                    ),
                    onPressed: () => bottomNavBarData.setIndex(2),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.person_outlined,
                      color: bottomNavBarData.selectedIndex == 3
                          ? const Color(0xFFFF8B14)
                          : Colors.grey,
                    ),
                    onPressed: () => bottomNavBarData.setIndex(3),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFFF8B14),
            elevation: 4.0,
            onPressed: () {},
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
