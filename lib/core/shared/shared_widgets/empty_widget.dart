import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });
  final String icon;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: MediaQuery.of(context).size.width * .62,
            ),
            SizedBox(height: AppConstants.height30(context) * 3),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height * .026,
                fontFamily: "Cairo",
                color: const Color(0xff141414),
              ),
            ),
            SizedBox(height: AppConstants.height5(context)),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.height * .018,
                fontFamily: "Cairo",
                color: const Color(0xff5F7983),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
