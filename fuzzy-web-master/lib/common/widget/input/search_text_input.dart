import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';

class SearchTextInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onTapX;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final BorderRadius? radius;
  const SearchTextInput({super.key, required this.controller, this.onSubmitted, this.onTapX, this.hintText, this.radius, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        style: AppTextStyle.s14w400(),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.grey.primary, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.grey.primary, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.grey.primary, width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          filled: true,
          alignLabelWithHint: true,
          fillColor: AppColors.white.primary,
          hoverColor: AppColors.white.primary,
          focusColor: AppColors.white.primary,
          hintText: hintText ?? 'Cari sepatu olahraga',
          hintStyle: AppTextStyle.s14w400(color: AppColors.grey.primary),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(Icons.search, color: AppColors.grey.primary),
          ),
          // suffixIcon: Padding(
          //   padding: const EdgeInsets.all(3.0),
          //   child: GestureDetector(
          //     onTap: () {
          //       if (onTapX != null) {
          //         onTapX!(controller.text);
          //       }
          //     },
          //     child: Icon(
          //       Icons.close,
          //       color: Colors.red[400],
          //       size: 24,
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
