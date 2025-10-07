import 'package:flutter/material.dart';
import 'package:pingora/constants.dart';
import 'package:pingora/core/shared/theme/app_theme.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    this.image,
    required this.title,
    required this.description,
  });
  final String? image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: AppConstants.height30(context) * 2),
            image != null
                ? Image.asset(
                    image!,
                    width: MediaQuery.of(context).size.width * .62,
                  )
                : const SizedBox.shrink(),
            SizedBox(height: AppConstants.height30(context)),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height * .026,
                fontFamily: "Cairo",
                color: context.primaryTextColor,
              ),
            ),
            SizedBox(height: AppConstants.height10(context)),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.height * .020,
                fontFamily: "Cairo",
                color: context.secondaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
