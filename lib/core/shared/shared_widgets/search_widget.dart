import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import 'default_text_form_field.dart';
import '../../utils/text_styles/styles.dart';
import '../../../../../core/utils/assets/assets.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    required this.searchController,
    this.icon,
    this.onSearch,
  });
  final Widget? icon;
  final Function(String)? onSearch;
  final TextEditingController searchController;
  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextFormField(
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.search,
      borderSideEnabledColor: const Color(0xffD6D6D6),
      contentPaddingVertical: AppConstants.height15(context),
      hintText: "search_now".tr(),
      onFilledSubmit: widget.onSearch,
      hasBorder: false,
      hintStyle: Styles.cairo16600C28(
        context,
      ).copyWith(color: const Color(0xff6C6D6E), fontWeight: FontWeight.w500),
      borderSideColor: const Color(0xffD6D6D6),
      fillColor: const Color(0xffF5F5F5),
      controller: widget.searchController,
      borderRadius: AppConstants.sp10(context),
      suffixIcon: widget.icon,
      prefixIcon: SvgPicture.asset(
        AssetData.search,
        fit: BoxFit.scaleDown,
        // ignore: deprecated_member_use
        color: const Color(0xff6C6D6E),
      ),
    );
  }
}
