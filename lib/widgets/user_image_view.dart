import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserImageView extends StatelessWidget {
  const UserImageView(
      {super.key,
      this.radius = 20,
      required this.url,
      this.local = false,
      this.backgroundColor,
      this.frameUrl,
      this.streamVisibility = 1,
      this.live = false,
      this.whiteBorder = 3.0,
      this.isWhiteBorder = false});
  final double radius;
  final String url;
  final bool local;
  final Color? backgroundColor;
  final String? frameUrl;
  final bool? live;
  final int streamVisibility;
  final bool isWhiteBorder;
  final double whiteBorder;


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: isWhiteBorder
              ? BoxDecoration(
                color: backgroundColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: whiteBorder,
                  ),
                )
              : null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: url.isEmpty
                ? Container(
                    width: radius * 2,
                    height: radius * 2,
                    color: const Color.fromARGB(255, 201, 201, 201),
                    // padding: EdgeInsets.all(radius / 1.5),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: radius / 1.2,
                      ),
                    ),
                  )
                : local
                    ? Image.file(
                        File(url),
                        height: radius * 2,
                        width: radius * 2,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: url,
                        height: radius * 2,
                        width: radius * 2,
                        fit: BoxFit.cover,
                        placeholder: (ctx, _) => Container(
                          width: radius * 2,
                          height: radius * 2,
                          color: const Color(0xFFEFEEEE),
                          // padding: EdgeInsets.all(radius / 1.5),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: radius / 1.4,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: radius * 2,
                          height: radius * 2,
                          color: const Color(0xFFEFEEEE),
                          // padding: EdgeInsets.all(radius / 1.5),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: radius / 1.4,
                          ),
                        ),
                      ),
          ),
        ),
        if (streamVisibility == 1 && live!)
          ClipRRect(
            borderRadius: BorderRadius.circular(radius * 2.2),
            child: SizedBox(
              width: radius * 2.2,
              height: radius * 2.2,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink, width: 1.5),
                      borderRadius: BorderRadius.circular(radius * 2.2),
                    ),
                  ),
                  Positioned(
                    top: 3.5,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                          vertical: 0,
                          horizontal: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.pink,
                        ),
                        child: Text(
                          "LIVE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: (radius ~/ 4).toDouble(),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
