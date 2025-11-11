import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_export.dart';
import '../core/theme_provider.dart';
import '../widgets/custom_image_view.dart';
import '../widgets/custom_search_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final bgColor = themeProvider.selectedColor.withOpacity(0.9);
        final textColor = themeProvider.textColor;
        final borderColor = textColor.withOpacity(0.7);

        return Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double scaleFactor = constraints.maxHeight / 800;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 8.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Search bar
                      SizedBox(
                        height: 55 * scaleFactor,
                        child: _buildSearchSection(context, themeProvider),
                      ),

                      /// Where Am I?
                      Container(
                        height: 160 * scaleFactor,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: bgColor,
                          border: Border.all(color: borderColor, width: 2),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              offset: const Offset(0, 3),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Where Am I?",
                              style: TextStyleHelper.instance.display40BoldInter
                                  .copyWith(
                                color: textColor,
                                fontSize: 28 * scaleFactor,
                              ),
                            ),
                            SizedBox(height: 10 * scaleFactor),
                            CustomImageView(
                              imagePath: ImageConstant.imgGroup,
                              width: 55 * scaleFactor,
                              height: 55 * scaleFactor,
                            ),
                          ],
                        ),
                      ),

                      /// Favorites + Navigation
                      SizedBox(
                        height: 140 * scaleFactor,
                        child: Row(
                          children: [
                            Expanded(
                              child: _featureCard(
                                context,
                                themeProvider,
                                title: "Favorites",
                                image: ImageConstant.imgFluentEmojiFlatStar,
                                color: themeProvider.selectedColor.withOpacity(0.4),
                                route: AppRoutes.favoritesScreen,
                                scale: scaleFactor,
                              ),
                            ),
                            const SizedBox(width: 10), // Maintain spacing between buttons
                            Expanded(
                              child: _featureCard(
                                context,
                                themeProvider,
                                title: "Navigation",
                                image: ImageConstant.imgVector,
                                color: themeProvider.selectedColor.withOpacity(0.25),
                                route: AppRoutes.navigationScreen,
                                scale: scaleFactor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Settings + Emergency
                      SizedBox(
                        height: 90 * scaleFactor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _iconButton(
                              context,
                              themeProvider,
                              route: AppRoutes.settingsScreen,
                              icon: ImageConstant.imgIconGray90001,
                              scale: scaleFactor,
                            ),
                            _iconButton(
                              context,
                              themeProvider,
                              route: AppRoutes.emergencyScreen,
                              icon: ImageConstant.imgIconGray9000164x58,
                              scale: scaleFactor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  /// Search Section
  Widget _buildSearchSection(BuildContext context, ThemeProvider themeProvider) {
    final textColor = themeProvider.textColor;

    return CustomSearchAppBar(
      searchPlaceholder: "Search",
      backgroundColor: themeProvider.selectedColor.withOpacity(0.15),
      borderColor: textColor.withOpacity(0.5),
      textColor: textColor,
      placeholderColor: textColor.withOpacity(0.7),
      borderRadius: 8.h,
      height: 50.h,
      hasShadow: true,
      onSearchSubmitted: (value) {
        Navigator.pushNamed(context, AppRoutes.searchScreen);
      },
    );
  }

  /// Feature Card
  Widget _featureCard(BuildContext context, ThemeProvider themeProvider,
      {required String title,
      required String image,
      required Color color,
      required String route,
      required double scale}) {
    final textColor = themeProvider.textColor;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: (MediaQuery.of(context).size.width / 2) - 22,
        height: 130 * scale,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: textColor.withOpacity(0.5), width: 2),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(0, 3),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
                imagePath: image, height: 40 * scale, width: 40 * scale),
            SizedBox(height: 6 * scale),
            Text(
              title,
              style: TextStyleHelper.instance.headline25BoldInter.copyWith(
                color: textColor,
                fontSize: 18 * scale,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Icon Button
  Widget _iconButton(BuildContext context, ThemeProvider themeProvider,
      {required String route, required String icon, required double scale}) {
    final textColor = themeProvider.textColor;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: SizedBox(
        width: 70 * scale,
        height: 70 * scale,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 70 * scale,
              height: 70 * scale,
              decoration: BoxDecoration(
                color: themeProvider.selectedColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: textColor.withOpacity(0.5), width: 1.5),
              ),
            ),
            CustomImageView(
              imagePath: icon,
              width: 50 * scale,
              height: 50 * scale,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
