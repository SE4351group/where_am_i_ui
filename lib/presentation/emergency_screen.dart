import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme_provider.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final bgColor = themeProvider.selectedColor.withOpacity(0.9);
        final textColor = themeProvider.textColor;

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            title: Text("Emergency", style: TextStyle(color: textColor)),
            backgroundColor: themeProvider.selectedColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_amber_rounded,
                    size: 70, color: Colors.redAccent),
                SizedBox(height: 16),
                Text(
                  "Emergency Assistance",
                  style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  "Contacting campus security...\nStay where you are.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor.withOpacity(0.9), fontSize: 16),
                ),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.home),
                  label: Text("Return Home"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeProvider.selectedColor,
                    foregroundColor: textColor,
                    side: BorderSide(color: textColor.withOpacity(0.5)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
