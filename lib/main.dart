import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme_provider.dart';
import 'core/favorite_provider.dart'; // Provider add
import 'core/utils/size_utils.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(
    MultiProvider( // Register multiple providers simultaneously
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Where Am I UI',

              // Global theme (automatically reflects the color selected in the settings screen)
              theme: ThemeData(
                scaffoldBackgroundColor:
                    themeProvider.selectedColor.withOpacity(0.9),
                appBarTheme: AppBarTheme(
                  backgroundColor: themeProvider.selectedColor,
                  iconTheme: IconThemeData(color: themeProvider.textColor),
                  titleTextStyle: TextStyle(
                    color: themeProvider.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

              // Initial screen and route registration
              initialRoute: AppRoutes.homeScreen,
              routes: AppRoutes.routes,
            );
          },
        );
      },
    );
  }
}
