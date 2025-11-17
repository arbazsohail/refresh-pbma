import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../utils/app_colors.dart';

class CustomRefreshFooter extends StatelessWidget {
  const CustomRefreshFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const Text(
            "Pull up to load more",
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: 14,
              fontFamily: 'DMSans',
            ),
          );
        } else if (mode == LoadStatus.loading) {
          body = const SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          );
        } else if (mode == LoadStatus.canLoading) {
          body = const Text(
            "Release to load more",
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'DMSans',
            ),
          );
        } else if (mode == LoadStatus.noMore) {
          body = const Text(
            "No more data",
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: 14,
              fontFamily: 'DMSans',
            ),
          );
        } else {
          body = const Text(
            "Pull up to load more",
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: 14,
              fontFamily: 'DMSans',
            ),
          );
        }
        return SizedBox(
          height: 55,
          child: Center(child: body),
        );
      },
    );
  }
}
