import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/themes/app_size.dart';
import '../../app/theme_controller.dart';

class CommonDatePicker extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final List<String>? autofillHints;
  final String? hintText;
  final GlobalKey<FormFieldState>? fieldKey;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? currentDate;
  final void Function(String date) onDatePicked;

  const CommonDatePicker({
    super.key,
    this.controller,
    this.focusNode,
    this.validator,
    this.autofillHints,
    this.hintText,
    this.fieldKey,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    required this.onDatePicked,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.currentDate,
  });

  @override
  State<CommonDatePicker> createState() => _CommonDatePickerState();
}

class _CommonDatePickerState extends State<CommonDatePicker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      key: widget.fieldKey,
      controller: widget.controller,
      focusNode: widget.focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: widget.autofillHints,
      validator: widget.validator,
      readOnly: true,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color:
            Get.find<ThemeController>().isDarkMode
                ? AppColors.headingsLightColor
                : AppColors.headingsColor,
      ),
      decoration: InputDecoration(
        counterText: "",
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          borderRadius: ShapeBorderRadius.small,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: ShapeBorderRadius.small,
          borderSide: BorderSide(
            color:
            Get.find<ThemeController>().isDarkMode
                ? AppColors.grey100Color
                : AppColors.greyColor,
            width: 0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          borderRadius: ShapeBorderRadius.small,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: ShapeBorderRadius.small,
        ),
        fillColor: Theme.of(context).colorScheme.surface,
        errorStyle: TextStyle(color: Theme.of(context).colorScheme.error),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: AppColors.bodyTextColor, fontSize: 14),
        prefixIconConstraints: BoxConstraints(
          minWidth: widget.prefixIcon != null ? 40 : 25,
        ),
        prefixIcon:
            (widget.prefixIcon?.isBlank ?? false)
                ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 10,
                        top: 20,
                        bottom: 20,
                      ),
                      child: widget.prefixIcon ?? const SizedBox.shrink(),
                    ),
                    const Gap(6),
                  ],
                )
                : const SizedBox.shrink(),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [widget.suffixIcon ?? const SizedBox.shrink()],
        ),
      ),
      onSaved: (value) {},
      onTap: () {
        _selectDate(context);
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }

  Future _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          widget.initialDate ??
          DateTime.now().subtract(const Duration(days: 18 * 365)),
      firstDate: widget.firstDate ?? DateTime(DateTime.now().year - 100),
      lastDate:
          widget.lastDate ??
          DateTime.now().subtract(const Duration(days: 18 * 365)),
      currentDate: widget.currentDate ?? DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (picked != null) {
      widget.onDatePicked(picked.toString());
    }
  }
}
