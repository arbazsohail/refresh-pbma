import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class SmallLoader extends StatelessWidget {
  const SmallLoader({super.key, this.adaptive = false, this.color});
  final bool adaptive;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return adaptive
        ? Platform.isIOS
            ? CupertinoActivityIndicator(
                color: color ?? AppColors.primary,
                radius: 12,
              )
            : SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    color ?? AppColors.primary,
                  ),
                ),
              )
        : SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? AppColors.primary,
              ),
            ),
          );
  }
}
