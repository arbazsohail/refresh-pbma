// add following dependencies
//    -> easy_image_viewer ^1.5.0
//    -> flutter_svg ^2.0.10+1
//    -> cached_network_image ^3.3.1

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


enum ImageType { asset, file, network, unknown }

enum ImageFormat { raster, vector }

class ImageWidget extends StatelessWidget {
  final String path;
  final bool preview;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double opacity;
  final double borderRadius;
  final String placeholderImage;
  final double loadingIndicatorSize;
  final Color? loadingIndicatorColor;
  final Color? color;
  final BlendMode blendMode;
  final ImageType? type;
  final ImageFormat? format;
  final Function()? onTap;
  const ImageWidget(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.opacity = 1,
    this.borderRadius = 0,
    this.loadingIndicatorSize = 24,
    this.preview = false,
    this.placeholderImage = 'assets/images/app_icon_android.png',
    this.loadingIndicatorColor,
    this.type,
    this.format,
    this.color,
    this.blendMode = BlendMode.srcIn,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: preview && !_isVector && _imageType != ImageType.unknown
          ? () => Get.to(
              () => _ImagePreview(path: path),
              curve: Curves.easeInOut,
              duration: 500.milliseconds,
              transition: Transition.circularReveal,
            )
          : onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: switch (type ?? _imageType) {
          ImageType.network when _isVector => _buildSvgNetwork(),
          ImageType.asset when _isVector => _buildSvgAsset(),
          ImageType.file when _isVector => _buildSvgFile(),
          ImageType.network => _buildImageNetwork(),
          ImageType.asset => _buildImageAsset(),
          ImageType.file => _buildImageFile(),
          ImageType.unknown => _buildError(),
        },
      ),
    );
  }

  // MARK: HELPERS

  ImageType get _imageType {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return ImageType.network;
    } else if (path.startsWith('/') || path.startsWith('file://')) {
      return ImageType.file;
    } else if (path.startsWith('assets/')) {
      return ImageType.asset;
    } else {
      return ImageType.unknown;
    }
  }

  bool get _isVector =>
      format == ImageFormat.vector || path.toLowerCase().endsWith('.svg');

  Widget get _placeholder => Image.asset(
    placeholderImage,
    height: height,
    width: width,
    fit: BoxFit.cover,
  );

  // MARK: BUILDERS

  Container _buildError() {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        "Error\n\n$path",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  CachedNetworkImage _buildImageNetwork() {
    return CachedNetworkImage(
      imageUrl: path,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      color: color,
      colorBlendMode: blendMode,
      errorWidget: (context, url, error) => _placeholder,
      progressIndicatorBuilder: (_, _, progress) => Center(
        child: SizedBox(
          width: loadingIndicatorSize,
          height: loadingIndicatorSize,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            value: progress.progress,
            color: loadingIndicatorColor,
          ),
        ),
      ),
    );
  }

  Image _buildImageFile() {
    return Image.file(
      File(path),
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      color: color,
      colorBlendMode: blendMode,
    );
  }

  Image _buildImageAsset() {
    return Image.asset(
      path,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      color: color,
      colorBlendMode: blendMode,
    );
  }

  SvgPicture _buildSvgNetwork() {
    return SvgPicture.network(
      path,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(color!, BlendMode.srcIn),
      placeholderBuilder: (_) => _placeholder,
    );
  }

  SvgPicture _buildSvgFile() {
    return SvgPicture.file(
      File(path),
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(color!, BlendMode.srcIn),
      placeholderBuilder: (_) => _placeholder,
    );
  }

  SvgPicture _buildSvgAsset() {
    return SvgPicture.asset(
      path,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      colorFilter: color == null ? null : ColorFilter.mode(color!, blendMode),
      placeholderBuilder: (_) => _placeholder,
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final String path;
  const _ImagePreview({required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0),
        leading: IconButton(
          color: Colors.white,
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.close,
            shadows: [BoxShadow(color: Colors.black, blurRadius: 8)],
          ),
        ),
      ),
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: Center(
          child: ImageWidget(
            path,
            fit: BoxFit.contain,
            preview: false,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
      ),
    );
  }
}
