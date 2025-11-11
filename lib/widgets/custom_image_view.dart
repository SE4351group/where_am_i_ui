import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/app_export.dart';

enum ImageType { svg, png, network, networkSvg, file }

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http')) {
      return endsWith('.svg') ? ImageType.networkSvg : ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

class CustomImageView extends StatelessWidget {
  final String? imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final String? placeHolder;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  final BoxBorder? border;

  const CustomImageView({
    Key? key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.margin,
    this.radius,
    this.border,
    this.placeHolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String finalImagePath = (imagePath == null || imagePath!.isEmpty)
        ? ImageConstant.imgImageNotFound
        : imagePath!;

    return alignment != null
        ? Align(alignment: alignment!, child: _buildWidget(finalImagePath))
        : _buildWidget(finalImagePath);
  }

  Widget _buildWidget(String finalImagePath) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(finalImagePath),
      ),
    );
  }

  Widget _buildCircleImage(String finalImagePath) {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(finalImagePath),
      );
    } else {
      return _buildImageWithBorder(finalImagePath);
    }
  }

  Widget _buildImageWithBorder(String finalImagePath) {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(finalImagePath),
      );
    } else {
      return _buildImageView(finalImagePath);
    }
  }

  Widget _buildImageView(String finalImagePath) {
    switch (finalImagePath.imageType) {
      case ImageType.svg:
        return SvgPicture.asset(
          finalImagePath,
          height: height,
          width: width,
          fit: fit ?? BoxFit.contain,
          colorFilter: color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
        );
      case ImageType.file:
        return Image.file(
          File(finalImagePath),
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
        );
      case ImageType.networkSvg:
        return SvgPicture.network(
          finalImagePath,
          height: height,
          width: width,
          fit: fit ?? BoxFit.contain,
          colorFilter: color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
        );
      case ImageType.network:
        return CachedNetworkImage(
          height: height,
          width: width,
          fit: fit,
          imageUrl: finalImagePath,
          color: color,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          errorWidget: (context, url, error) => Image.asset(
            placeHolder ?? ImageConstant.imgImageNotFound,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          ),
        );
      case ImageType.png:
        return Image.asset(
          finalImagePath,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          color: color,
        );
    }
  }
}
