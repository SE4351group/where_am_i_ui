import 'package:flutter/material.dart';
import '../../presentation/home_screen.dart';
import '../../presentation/search_screen.dart';
import '../../presentation/favorites_screen.dart';
import '../../presentation/navigation_screen.dart';
import '../../presentation/settings_screen.dart';
import '../../presentation/emergency_screen.dart';

class AppRoutes {
  static const String homeScreen = '/';
  static const String searchScreen = '/search_screen';
  static const String favoritesScreen = '/favorites_screen';
  static const String navigationScreen = '/navigation_screen';
  static const String settingsScreen = '/settings_screen';
  static const String emergencyScreen = '/emergency_screen';

  static Map<String, WidgetBuilder> routes = {
    homeScreen: (context) => const HomeScreen(),
    searchScreen: (context) => const SearchScreen(),
    favoritesScreen: (context) => const FavoritesScreen(),
    navigationScreen: (context) => const NavigationScreen(destination: '',),
    settingsScreen: (context) => const SettingsScreen(),
    emergencyScreen: (context) => const EmergencyScreen(),
  };
}