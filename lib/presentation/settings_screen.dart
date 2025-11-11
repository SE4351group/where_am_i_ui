import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _speechRate = 0.5;
  double _voiceIntensity = 0.5;
  String _selectedVoice = 'Voice 1';

  final List<Color> uiColors = [
    Colors.white,
    Colors.black,
    const Color(0xFF90EE90),
    const Color(0xFFFFD580),
  ];

  final List<String> voiceOptions = [
    'Voice 1',
    'Voice 2',
    'Voice 3',
    'Voice 4',
    'Voice 5'
  ];

  Color getTextColor(Color bgColor) {
    Brightness brightness = ThemeData.estimateBrightnessForColor(bgColor);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final selectedColor = themeProvider.selectedColor;
    final textColor = themeProvider.textColor;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double scaleFactor = screenHeight / 800;

    return Scaffold(
      backgroundColor: selectedColor.withOpacity(0.9),
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: textColor)),
        backgroundColor: selectedColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * scaleFactor),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Speech Rate
              Text("Speech Rate",
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18 * scaleFactor)),
              Slider(
                value: _speechRate,
                onChanged: (v) => setState(() => _speechRate = v),
                activeColor: textColor,
                inactiveColor: textColor.withOpacity(0.3),
              ),
              SizedBox(height: 24 * scaleFactor),

              // Voice Type
              Text("Voice Type",
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18 * scaleFactor)),
              SizedBox(height: 8 * scaleFactor),
              DropdownButtonFormField<String>(
                dropdownColor: selectedColor,
                style: TextStyle(color: textColor),
                value: _selectedVoice,
                items: voiceOptions.map((voice) {
                  return DropdownMenuItem(
                    value: voice,
                    child: Text(voice, style: TextStyle(color: textColor)),
                  );
                }).toList(),
                onChanged: (v) => setState(() => _selectedVoice = v!),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8 * scaleFactor),
                    borderSide: BorderSide(color: textColor.withOpacity(0.5)),
                  ),
                ),
              ),
              SizedBox(height: 24 * scaleFactor),

              // Voice Intensity
              Text("Voice Intensity",
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18 * scaleFactor)),
              Slider(
                value: _voiceIntensity,
                onChanged: (v) => setState(() => _voiceIntensity = v),
                activeColor: textColor,
                inactiveColor: textColor.withOpacity(0.3),
              ),
              SizedBox(height: 24 * scaleFactor),

              // Change UI
              Text("Change UI",
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18 * scaleFactor)),
              SizedBox(height: 12 * scaleFactor),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: uiColors.map((color) {
                  final bool isSelected = color == selectedColor;
                  return GestureDetector(
                    onTap: () => themeProvider.updateTheme(color),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 70 * scaleFactor,
                      height: 100 * scaleFactor,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12 * scaleFactor),
                        border: Border.all(
                          color: isSelected
                              ? textColor
                              : textColor.withOpacity(0.4),
                          width: isSelected ? 3 : 1.5,
                        ),
                      ),
                      child: isSelected
                          ? Icon(Icons.check,
                              color: getTextColor(color), size: 30)
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
