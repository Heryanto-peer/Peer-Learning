import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';

class AppButton extends StatelessWidget {
  final TaskCallback? onPressed;
  final String text;
  final String? imgIcon;
  final IconData? icon;
  final Color? iconColor;
  final Color? background;
  final Color? foreground;
  final bool? isLoading;
  final EdgeInsets? padding;
  final double? radius;
  final Color? borderColor;
  const AppButton(
      {super.key, required this.onPressed, required this.text, this.imgIcon, this.icon, this.iconColor, this.isLoading, this.background, this.foreground, this.padding, this.radius, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading == true ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: background ?? AppColors.usedFor.buttonBox,
          foregroundColor: foreground ?? AppColors.usedFor.buttonText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 5.0),
            side: borderColor == null ? BorderSide.none : BorderSide(color: borderColor!),
          ),
          padding: padding,
          disabledForegroundColor: AppColors.usedFor.buttonDisable),
      child: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (imgIcon != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.asset(
                      imgIcon!,
                      height: 18,
                      width: 18,
                      color: iconColor,
                      fit: BoxFit.contain,
                    ),
                  ),
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(icon, color: iconColor),
                  ),
                Expanded(
                  child: Text(
                    text,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );
  }
}

class Outlined extends StatelessWidget {
  final TaskCallback? onPressed;
  final String text;
  final String? imgIcon;
  final IconData? icon;
  final Color? iconColor;
  final Color? background;
  final Color? foreground;
  final bool? isLoading;
  final EdgeInsets? padding;
  final double? radius;
  final Color? borderColor;
  const Outlined(
      {super.key, this.onPressed, required this.text, this.imgIcon, this.icon, this.iconColor, this.background, this.foreground, this.isLoading, this.padding, this.radius, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          backgroundColor: background ?? AppColors.usedFor.buttonBox,
          foregroundColor: foreground ?? AppColors.usedFor.buttonText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 5.0),
          ),
          padding: padding,
          disabledForegroundColor: AppColors.usedFor.buttonDisable),
      child: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imgIcon != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.asset(
                      imgIcon!,
                      height: 18,
                      width: 18,
                      color: iconColor,
                      fit: BoxFit.contain,
                    ),
                  ),
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(icon, color: iconColor),
                  ),
                Text(
                  text,
                ),
              ],
            ),
    );
  }
}
