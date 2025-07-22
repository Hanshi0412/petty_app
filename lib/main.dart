// main.dart
import 'package:flutter/material.dart';
import 'package:petty_app/screens/splash_screen.dart';
import 'package:petty_app/screens/onboarding_screen.dart';
import 'package:petty_app/screens/login_screen.dart';
import 'package:petty_app/screens/home_screen.dart';
import 'package:petty_app/screens/forgot_password_screen.dart';
import 'package:petty_app/screens/signup_screen.dart';
import 'package:provider/provider.dart';
// Import the screens for navigation
import 'package:petty_app/screens/store/Shop_Screen.dart'; // Make sure this path is correct
import 'package:petty_app/screens/store/store_list_view.dart'; // Make sure this path is correct
import 'package:petty_app/screens/store/store_profile.dart'; // Make sure this path is correct

MaterialColor createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red;
  final int g = color.green;
  final int b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<ChangeNotifier>>[
        ChangeNotifierProvider<BottomNavBarData>(
          create: (BuildContext context) => BottomNavBarData(),
        ),
        ChangeNotifierProvider<SearchData>(
          create: (BuildContext context) => SearchData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pet Care App',
        theme: ThemeData(
          primarySwatch: createMaterialColor(const Color(0xFFFF8B14)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        // Set store_list_view.dart as the initial screen
        home: const PetStoreHomePage(),
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/login': (context) => const LoginFlowManager(),
          '/signup': (context) => const SignupScreen(),
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/home': (context) => const HomeScreen(),
          // Define routes for the store navigation flow
          '/store_list': (context) => const PetStoreHomePage(),
          '/store_profile': (context) =>
              const FoodShopProfileScreen(), // Correct: FoodShopProfileScreen from store_profile.dart
          '/shop_screen': (context) =>
              const FoodShopScreen(), // Corrected from ShopScreen to FoodShopScreen
        },
      ),
    );
  }
}

class LoginFlowManager extends StatefulWidget {
  const LoginFlowManager({super.key});

  @override
  State<LoginFlowManager> createState() => _LoginFlowManagerState();
}

class _LoginFlowManagerState extends State<LoginFlowManager> {
  void _toggleLoginSignup() {
    Navigator.pushReplacementNamed(context, '/signup');
  }

  void _navigateToForgotPassword() {
    Navigator.pushNamed(context, '/forgot-password');
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen(
      onToggle: _toggleLoginSignup,
      onForgotPassword: _navigateToForgotPassword,
      onLoginSuccess: _navigateToHome,
    );
  }
}

class LoginScreen extends StatelessWidget {
  final VoidCallback onToggle;
  final VoidCallback onForgotPassword;
  final VoidCallback onLoginSuccess;

  const LoginScreen({
    super.key,
    required this.onToggle,
    required this.onForgotPassword,
    required this.onLoginSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 40),
                    const ShadowedTextField(
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    const ShadowedTextField(
                      labelText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: onLoginSuccess,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: onForgotPassword,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account yet?"),
                  TextButton(
                    onPressed: onToggle,
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.orange),
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

class ShadowedTextField extends StatelessWidget {
  final String labelText;
  final TextInputType? keyboardType;
  final bool obscureText;

  const ShadowedTextField({
    super.key,
    required this.labelText,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
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
    _searchController.addListener(_onSearchControllerChanged);
  }

  bool get isSearching => _isSearching;
  TextEditingController get searchController => _searchController;
  String get searchText => _searchController.text;

  void toggleSearch() {
    _isSearching = !_isSearching;
    if (!_isSearching) {
      _searchController.clear();
    }
    notifyListeners();
  }

  void _onSearchControllerChanged() {
    notifyListeners();
  }

  void clearSearch() {
    _searchController.clear();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchControllerChanged);
    _searchController.dispose();
    super.dispose();
  }
}
