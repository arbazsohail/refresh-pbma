import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../utils/app_colors.dart';

class CustomRefreshHeader extends StatelessWidget {
  const CustomRefreshHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (BuildContext context, RefreshStatus? mode) {
        Widget body;
        if (mode == RefreshStatus.idle) {
          body = const Text(
            "Pull down to refresh",
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: 14,
              fontFamily: 'DMSans',
            ),
          );
        } else if (mode == RefreshStatus.refreshing) {
          body = const SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          );
        } else if (mode == RefreshStatus.canRefresh) {
          body = const Text(
            "Release to refresh",
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'DMSans',
            ),
          );
        } else if (mode == RefreshStatus.completed) {
          body = const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "Refresh completed",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                  fontFamily: 'DMSans',
                ),
              ),
            ],
          );
        } else {
          body = const Text(
            "Pull down to refresh",
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: 14,
              fontFamily: 'DMSans',
            ),
          );
        }
        return SizedBox(
          height: 60,
          child: Center(child: body),
        );
      },
    );
  }
}
