import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import '../core/theme_provider.dart';

class NavigationScreen extends StatefulWidget {
  final String destination;
  const NavigationScreen({super.key, required this.destination});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with SingleTickerProviderStateMixin {
  late List<Map<String, String>> _steps;
  int _currentStep = 0;
  late AnimationController _pingController;

  @override
  void initState() {
    super.initState();
    _steps = _generateSteps(widget.destination);

    // Sonar Ping Animation
    _pingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      lowerBound: 0.9,
      upperBound: 1.1,
    );
  }

  @override
  void dispose() {
    _pingController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _generateSteps(String room) {
    switch (room) {
      case "ECSW 1.315":
        return [
          {"main": "Walk Straight", "distance": "20 feet"},
          {"main": "Turn Right", "distance": "15 feet"},
          {"main": "Arrived!", "distance": ""},
        ];
      case "ECSW 1.355":
        return [
          {"main": "Walk Straight", "distance": "30 feet"},
          {"main": "Turn Left", "distance": "10 feet"},
          {"main": "Arrived!", "distance": ""},
        ];
      case "ECSW 1.120":
        return [
          {"main": "Walk Straight", "distance": "15 feet"},
          {"main": "Turn Left", "distance": "10 feet"},
          {"main": "Arrived!", "distance": ""},
        ];
      default:
        return [
          {"main": "Walk Straight", "distance": "25 feet"},
          {"main": "Turn Right", "distance": "15 feet"},
          {"main": "Arrived!", "distance": ""},
        ];
    }
  }

  // Sonar Ping behavior (vibration + animation + step transition)
  void _pingAction() async {
    // Vibration (mobile only)
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 200);
    }

    // Run animation
    _pingController.forward(from: 0.9);

    // Step transition
    setState(() {
      if (_currentStep < _steps.length - 1) {
        _currentStep++;
      }
    });
  }

  void _repeatInstruction() {
    final step = _steps[_currentStep];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Repeat: ${step["main"]} ${step["distance"]}"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bgColor = themeProvider.selectedColor.withOpacity(0.9);
    final textColor = themeProvider.textColor;

    final currentStep = _steps[_currentStep];
    final nextStep =
        _currentStep < _steps.length - 1 ? _steps[_currentStep + 1] : null;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: themeProvider.selectedColor,
        title: Text(
          "Destination: ${widget.destination}",
          style: TextStyle(
            color: textColor,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Current stage
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: textColor, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    currentStep["main"] ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentStep["distance"] ?? "",
                    style: const TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            // Show next steps
            if (nextStep != null)
              Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Next:",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "${nextStep["main"]} in ${nextStep["distance"]}",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),

            const Spacer(),

            // 2 buttons at the bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Repeat button
                Column(
                  children: [
                    const Text("Repeat",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: _repeatInstruction,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.refresh, size: 40),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 50),

                // Sonar Ping button
                Column(
                  children: [
                    const Text("Sonar Ping",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    AnimatedBuilder(
                      animation: _pingController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pingController.value,
                          child: child,
                        );
                      },
                      child: GestureDetector(
                        onTap: _pingAction,
                        child: Container(
                          width: 85,
                          height: 85,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: textColor, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.waves, size: 42),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
