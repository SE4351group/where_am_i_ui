import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme_provider.dart';
import '../core/favorite_provider.dart';
import 'navigation_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // List of Locations on ECSW 1st Floor
  final List<Map<String, String>> _rooms = [
    {"name": "ECSW 1.100", "desc": "Axxess Atrium"},
    {"name": "ECSW 1.120", "desc": "Cafe"},
    {"name": "ECSW 1.125", "desc": "Collaboration Area"},
    {"name": "ECSW 1.130", "desc": "Freshman Design"},
    {"name": "ECSW 1.160A", "desc": "Classroom"},
    {"name": "ECSW 1.315", "desc": "Classroom"},
    {"name": "ECSW 1.315B", "desc": "Restroom"},
    {"name": "ECSW 1.315C", "desc": "Classroom"},
    {"name": "ECSW 1.340", "desc": "Collaboration"},
    {"name": "ECSW 1.355", "desc": "Classroom"},
    {"name": "ECSW 1.375", "desc": "Collaboration"},
    {"name": "ECSW 1.435", "desc": "Lab"},
    {"name": "ECSW 1.440", "desc": "Research Lab"},
  ];

  List<Map<String, String>> _filteredRooms = [];

  @override
  void initState() {
    super.initState();
    _filteredRooms = _rooms;
  }

  void _filterResults(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredRooms = _rooms;
      } else {
        _filteredRooms = _rooms
            .where((room) =>
                room["name"]!.toLowerCase().contains(query.toLowerCase()) ||
                room["desc"]!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

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
          "Search ECSW 1st Floor",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search box
            TextField(
              controller: _searchController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: "Search ECSW 1.XXX or Room Name",
                hintStyle: TextStyle(color: textColor.withOpacity(0.7)),
                prefixIcon: Icon(Icons.search, color: textColor),
                filled: true,
                fillColor: Colors.white.withOpacity(0.15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: textColor.withOpacity(0.6)),
                ),
              ),
              onChanged: _filterResults,
            ),
            const SizedBox(height: 16),

            // Search results list
            Expanded(
              child: _filteredRooms.isEmpty
                  ? Center(
                      child: Text(
                        "No matching rooms found.",
                        style: TextStyle(color: textColor.withOpacity(0.7)),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredRooms.length,
                      itemBuilder: (context, index) {
                        final room = _filteredRooms[index];
                        final name = room["name"]!;
                        final desc = room["desc"]!;
                        final isFavorite =
                            favoriteProvider.favorites.contains(name);

                        return Card(
                          color: Colors.white.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: themeProvider.textColor.withOpacity(0.6),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              desc,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                isFavorite ? Icons.star : Icons.star_border,
                                color: isFavorite ? Colors.amber : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isFavorite) {
                                    favoriteProvider.removeFavorite(name);
                                  } else {
                                    favoriteProvider.addFavorite(name);
                                  }
                                });
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigationScreen(
                                    destination: name,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),

            // Voice button (UI only)
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text("Voice input coming soon! (ECSW 1st floor only)"),
                  ),
                );
              },
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: themeProvider.selectedColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(Icons.mic, size: 45, color: themeProvider.textColor),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
