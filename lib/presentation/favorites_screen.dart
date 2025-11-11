import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/favorite_provider.dart';
import '../core/theme_provider.dart';
import 'navigation_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final textColor = themeProvider.textColor;
    final bgColor = themeProvider.selectedColor.withOpacity(0.9);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: themeProvider.selectedColor,
        title: Text(
          "Favorites",
          style: TextStyle(color: textColor),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: favoriteProvider.favorites.isEmpty
          ? Center(
              child: Text(
                "No favorites added yet.",
                style: TextStyle(color: textColor, fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteProvider.favorites.length,
              itemBuilder: (context, index) {
                final destination = favoriteProvider.favorites[index];

                return Card(
                  color: Colors.white.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: textColor.withOpacity(0.6)),
                  ),
                  child: ListTile(
                    title: Text(
                      destination,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () {
                        favoriteProvider.removeFavorite(destination);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NavigationScreen(destination: destination),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
