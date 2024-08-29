import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:gap/gap.dart';

class AppTextFormField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final Widget? prefix;
  final String? hintText;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? enabled;
  final int? maxLines;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final TaskCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  const AppTextFormField(
      {super.key,
      required this.title,
      required this.controller,
      this.prefix,
      this.hintText,
      this.suffix,
      this.validator,
      this.keyboardType,
      this.enabled,
      this.maxLines,
      this.obscureText,
      this.onChanged,
      this.onTap,
      this.inputFormatters});
  @override
  State<AppTextFormField> createState() => _TitleTextInputState();
}

enum _EnumStatusField { unfocus, focus, error }

class _TitleTextInputState extends State<AppTextFormField> {
  late FocusNode? _focusNode;
  _EnumStatusField _statusField = _EnumStatusField.unfocus;
  String? _errorText;
  Color bgColor = AppColors.usedFor.canvas;

  Color get _colorBorder {
    switch (_statusField) {
      case _EnumStatusField.unfocus:
        return AppColors.base.tertiary;
      case _EnumStatusField.focus:
        return AppColors.base.lightBlue;
      case _EnumStatusField.error:
        return AppColors.base.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(16),
        Row(
          children: [
            Text(
              widget.title,
              style: AppTextStyle.s14w400(),
            ),
            Expanded(child: Text(_errorText ?? '', style: AppTextStyle.s14w400(color: AppColors.base.red), textAlign: TextAlign.end)),
          ],
        ),
        const Gap(8),
        InkWell(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _colorBorder, width: 1.0),
              color: widget.enabled == false ? AppColors.base.tertiary.withOpacity(0.8) : AppColors.base.tertiary,
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.prefix != null) SizedBox(height: 24, width: 24, child: AspectRatio(aspectRatio: 24 / 24, child: widget.prefix)),
                  Expanded(
                    child: TextFormField(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      style: AppTextStyle.s14w400(color: AppColors.base.primary),
                      validator: (value) {
                        if (value != null) {
                          setState(() {
                            _statusField = _EnumStatusField.error;
                          });
                        }
                        if (widget.validator != null) {
                          setState(() {
                            _errorText = widget.validator!(value);
                          });
                        }
                        return null;
                      },
                      inputFormatters: widget.inputFormatters,
                      maxLines: widget.maxLines ?? 1,
                      minLines: 1,
                      keyboardType: widget.keyboardType,
                      enabled: widget.enabled,
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: widget.obscureText ?? false,
                      obscuringCharacter: '•',
                      onChanged: widget.onChanged,
                      onTap: widget.onTap,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: AppTextStyle.s14w400(color: AppColors.base.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.base.tertiary, width: 0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.base.tertiary, width: 0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.base.tertiary, width: 0),
                        ),
                        enabled: widget.enabled ?? true,
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: bgColor, width: 0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                        filled: true,
                        fillColor: bgColor,
                        hoverColor: bgColor,
                        focusColor: bgColor,
                        isDense: false,
                      ),
                    ),
                  ),
                  if (widget.suffix != null) SizedBox(height: 24, width: 24, child: AspectRatio(aspectRatio: 24 / 24, child: widget.suffix)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  detectFocusNode() {
    if (_focusNode?.hasFocus == true) {
      setState(() {
        _statusField = _EnumStatusField.focus;
      });
    } else {
      setState(() {
        _statusField = _EnumStatusField.unfocus;
      });
    }
  }

  @override
  void didChangeDependencies() {
    _focusNode?.addListener(detectFocusNode);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    bgColor = widget.enabled == false ? AppColors.base.lightBlue.withOpacity(0.1) : AppColors.base.tertiary;
    super.initState();
  }
}
