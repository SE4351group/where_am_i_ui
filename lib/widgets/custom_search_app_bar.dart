import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'custom_image_view.dart';

class CustomSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomSearchAppBar({
    Key? key,
    this.searchPlaceholder,
    this.onSearchSubmitted,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.placeholderColor,
    this.borderRadius,
    this.height,
    this.hasShadow,
  }) : super(key: key);

  final String? searchPlaceholder;
  final Function(String)? onSearchSubmitted;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? placeholderColor;
  final double? borderRadius;
  final double? height;
  final bool? hasShadow;

  @override
  Size get preferredSize => Size.fromHeight(height ?? 48.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: hasShadow ?? true ? 4 : 0,
      backgroundColor: backgroundColor ?? appTheme.gray_100,
      title: TextFormField(
        onFieldSubmitted: onSearchSubmitted,
        style: TextStyleHelper.instance.title16RegularInter
            .copyWith(color: textColor ?? appTheme.gray_600),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.all(10.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgSearch,
              height: 24.h,
              width: 24.h,
            ),
          ),
          hintText: searchPlaceholder ?? "Search",
          hintStyle: TextStyleHelper.instance.title16RegularInter
              .copyWith(color: placeholderColor ?? appTheme.gray_600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.h),
            borderSide: BorderSide(color: borderColor ?? appTheme.gray_600),
          ),
        ),
      ),
    );
  }
}
