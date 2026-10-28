import 'package:contact_app/core/utils/app_assets.dart';
import 'package:contact_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BodyIsEmpty extends StatelessWidget {
  const BodyIsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(AppAssets.bodyAnimation),
                Text(
                  'There is No Contacts Added Here',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.goldColor,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
