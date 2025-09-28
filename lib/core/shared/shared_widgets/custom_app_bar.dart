import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import '../../utils/assets/assets.dart';
import '../../utils/router/router_helper.dart';
import '../../utils/text_styles/styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, this.backOnTap});
  final String title;
  final Function()? backOnTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.width20(context)),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          InkWell(
            onTap:
                backOnTap ??
                () {
                  MagicRouter.pop();
                },
            child: Container(
              padding: EdgeInsets.all(AppConstants.sp15(context)),
              decoration: const BoxDecoration(
                color: Color(0xffF2F2F2),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                AssetData.arrowFromTo,
                width: MediaQuery.of(context).size.width * .03,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(title, style: Styles.cairo18700Black(context))],
            ),
          ),
        ],
      ),
    );
  }
}
