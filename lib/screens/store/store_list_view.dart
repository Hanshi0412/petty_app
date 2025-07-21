import 'package:flutter/material.dart';

// DATA_MODEL
class Store {
  final String name;
  final String location;
  final String imageUrl;

  Store({required this.name, required this.location, required this.imageUrl});
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Store Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(
          0xFFF2F2F2,
        ), // Changed background color
      ),
      home: const PetStoreHomePage(),
    );
  }
}

class PetStoreHomePage extends StatefulWidget {
  const PetStoreHomePage({super.key});

  @override
  State<PetStoreHomePage> createState() => _PetStoreHomePageState();
}

class _PetStoreHomePageState extends State<PetStoreHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _categories = ['Food', 'Accessories', 'Pet'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
            child: SearchBarWidget(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: CustomCategoryTabs(
              tabController: _tabController,
              categories: _categories,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _categories.map<Widget>((category) {
                return StoreListView(category: category.toLowerCase());
              }).toList(),
            ),
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
            color: Colors.grey.withAlpha(25), // Adjusted from withOpacity(0.1)
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFFF8B14),
          ), // Changed color
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        ),
      ),
    );
  }
}

class CustomCategoryTabs extends StatelessWidget {
  final TabController tabController;
  final List<String> categories;

  const CustomCategoryTabs({
    super.key,
    required this.tabController,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(25), // Adjusted from withOpacity(0.1)
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        dividerColor: Colors.transparent, // Remove divider
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xFFFF8B14), // Changed color
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black87,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        tabs: categories
            .map<Widget>((category) => Tab(text: category))
            .toList(),
      ),
    );
  }
}

class StoreListView extends StatelessWidget {
  final String category;

  const StoreListView({super.key, required this.category});

  List<Store> getStores() {
    const String placeholderImageUrl =
        'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg';

    List<Store> data;
    switch (category) {
      case 'food':
        data = [
          Store(
            name: 'Pet mart nawala',
            location: 'Sri Jayewardenepura kotte',
            imageUrl: placeholderImageUrl,
          ),
          Store(
            name: 'WOW PET STORE',
            location: 'Maharagama',
            imageUrl: placeholderImageUrl,
          ),
          Store(
            name: 'Catlitter.lk',
            location: 'Thimbirigasyaya',
            imageUrl: placeholderImageUrl,
          ),
          Store(
            name: 'Pet Eats Sri Lanka',
            location: 'Nugegoda',
            imageUrl: placeholderImageUrl,
          ),
        ];
        break;
      case 'accessories':
        data = [
          Store(
            name: 'A+ PETS ACCESSORIES',
            location: 'Piliyandala',
            imageUrl: placeholderImageUrl,
          ),
          Store(
            name: 'Best Care Pet\'s Shop',
            location: 'Nugegoda',
            imageUrl: placeholderImageUrl,
          ),
          Store(
            name: 'Lucky Pet\'s Accessories',
            location: 'Maradana',
            imageUrl: placeholderImageUrl,
          ),
          Store(
            name: 'Scooby Doo',
            location: 'Nugegoda',
            imageUrl: placeholderImageUrl,
          ),
        ];
        break;
      case 'pet':
        data = [
          Store(
            name: 'Happy Tails',
            location: 'Nawinna',
            imageUrl: placeholderImageUrl,
          ),
          Store(
            name: 'Paws & Claws',
            location: 'Sri Jayewardenepura kotte',
            imageUrl: placeholderImageUrl,
          ),
          Store(
            name: 'Pet mart nawala',
            location: 'Sri Jayewardenepura kotte',
            imageUrl: placeholderImageUrl,
          ),
          Store(
            name: 'Aqua World',
            location: 'Aquatic pets & supplies',
            imageUrl: placeholderImageUrl,
          ),
        ];
        break;
      default:
        data = [];
        break;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final stores = getStores();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: stores.length,
      itemBuilder: (BuildContext context, int index) {
        final Store store = stores[index];
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
                SnackBar(content: Text('Tapped on ${store.name}')),
              );
            },
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              height: 72,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      15,
                    ), // Apply radius to all corners
                    child: Image.network(
                      store.imageUrl,
                      width: 101,
                      height: 72,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) => const Icon(
                            Icons.broken_image,
                            size: 72,
                            color: Colors.grey,
                          ),
                    ),
                  ),
                  const SizedBox(width: 16.0), // Spacing between image and text
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          store.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          store.location,
                          style: TextStyle(color: Colors.grey[600]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 16.0,
                    ), // Right padding for the arrow
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
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
                color: Color(0xFFFF8B14),
              ), // Changed color
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
