import 'package:flutter/material.dart';
import '../colors/colors.dart';

abstract class Styles {
  static TextStyle cairo14500Black(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .014,
    fontWeight: FontWeight.w600,
    fontFamily: "Cairo",
  );
  static TextStyle cairo14500Grey(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .014,
    fontWeight: FontWeight.w600,
    fontFamily: "Cairo",
    color: Colors.grey,
  );

  static TextStyle cairo14500C28(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .014,
    fontWeight: FontWeight.w600,
    fontFamily: "Cairo",
    color: AppColors.primaryTextColor(false), // Using theme-aware primary text
  );
  static TextStyle cairo8400C28(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .008,
    fontWeight: FontWeight.w500,
    fontFamily: "Cairo",
    color: AppColors.primaryTextColor(false), // Using theme-aware primary text
  );

  static TextStyle cairo14400HeavyGray(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .014,
    fontWeight: FontWeight.w500,
    color: AppColors.subtitleColor(false), // Using theme-aware subtitle color
    fontFamily: "Cairo",
  );

  static TextStyle cairo8600navGrey(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .008,
    fontWeight: FontWeight.w700,
    color: AppColors.secondaryTextColor(
      false,
    ), // Using theme-aware secondary text
    fontFamily: "Cairo",
  );

  static TextStyle cairo11400White(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .011,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontFamily: "Cairo",
  );

  static TextStyle cairo12500White(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .012,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: "Cairo",
  );
  static TextStyle cairo14700White(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .014,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    fontFamily: "Cairo",
  );

  static TextStyle cairo12500navGrey(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .012,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryTextColor(
      false,
    ), // Using theme-aware secondary text
    fontFamily: "Cairo",
  );

  static TextStyle cairo14500White(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .014,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: "Cairo",
  );

  static TextStyle cairo16500Black(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .016,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontFamily: "Cairo",
  );

  static TextStyle cairo16600C28(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .016,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryTextColor(false), // Using theme-aware primary text
    fontFamily: "Cairo",
  );

  static TextStyle cairo16600white(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .016,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: "Cairo",
  );

  static TextStyle cairo14400Subtitle(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .014,
    fontWeight: FontWeight.w500,
    color: AppColors.subtitleColor(false), // Using theme-aware subtitle color
    fontFamily: "Cairo",
  );

  static TextStyle cairo14600Kohly(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .014,
    fontWeight: FontWeight.w700,
    color: const Color(0xff041631),
    fontFamily: "Cairo",
  );
  static TextStyle cairo10500Kohly(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .01,
    fontWeight: FontWeight.w600,
    color: const Color(0xff041631),
    fontFamily: "Cairo",
  );

  static TextStyle cairo36700Secondary(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .028,
    fontWeight: FontWeight.w800,
    color: AppColors.secondaryColor,
    fontFamily: "Cairo",
  );
  static TextStyle cairo45700Kohly(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .045,
    fontWeight: FontWeight.w800,
    color: const Color(0xff041631),
    fontFamily: "Cairo",
  );

  static TextStyle cairo18700Black(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .018,
    fontWeight: FontWeight.w800,
    color: Colors.black,
    fontFamily: "Cairo",
  );
  static TextStyle cairo184002D(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .018,
    fontWeight: FontWeight.w500,
    color: const Color(0xff2D2B2E),
    fontFamily: "Cairo",
  );
  static TextStyle cairo206002C(context) => TextStyle(
    fontSize: MediaQuery.of(context).size.height * .02,
    fontWeight: FontWeight.w700,
    color: const Color(0xff2C2C2C),
    fontFamily: "Cairo",
  );

  //-------------------------------------------------------------------------------------------------//
}
