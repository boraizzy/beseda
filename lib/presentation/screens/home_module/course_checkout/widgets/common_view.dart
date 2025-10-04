import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/input_field/common_text_field.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../../../../common_widgets/widgets/validations.dart';
import '../controller/course_checkout_controller.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final groups = <String>[];

    for (int i = 0; i < digits.length; i += 4) {
      groups.add(
        digits.substring(i, i + 4 > digits.length ? digits.length : i + 4),
      );
    }

    final formatted = groups.join(' ');
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll('/', '');

    if (text.isEmpty) return newValue;
    if (text.length > 4) text = text.substring(0, 4);

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

Widget creditCardView() {
  CourseCheckoutController controller = Get.put(CourseCheckoutController());
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Container(
    width: double.infinity,
    //padding: EdgeInsets.symmetric(vertical: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: AppColors.greyColor, width: 1),
    ),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => InkWell(
              onTap: () {
                controller.selectedCreditCard.value = true;
                controller.selectedUpi.value = false;
                controller.selectedPaypal.value = false;
                controller.selectedRazorpay.value = false;
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: controller.selectedCreditCard.value
                      ? isDarkMode
                            ? AppColors.greyDarkColor
                            : AppColors.cardBgColor
                      : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: controller.selectedCreditCard.value
                          ? Colors.transparent
                          : AppColors.greyColor,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    topLeft: Radius.circular(6),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgImageFromAsset(
                      CommonImageAssets.creditCard,
                      height: 35,
                      width: 35,
                    ),
                    Gap(12),
                    Expanded(
                      child: CommonText.semiBold(
                        CourseCheckoutStrings.creditDebitCard,
                        size: 15,
                      ),
                    ),
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.selectedCreditCard.value
                            ? AppColors.primary500
                            : Colors.transparent,
                        border: Border.all(
                          color: controller.selectedCreditCard.value
                              ? Colors.transparent
                              : AppColors.greyColor,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.selectedCreditCard.value
                                ? isDarkMode
                                      ? AppColors.greyDarkColor
                                      : AppColors.white
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CommonText.medium(
              CourseCheckoutStrings.cardNumber,
              size: 15,
            ),
          ),
          Gap(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CommonTextField(
              autofillHints: [AutofillHints.creditCardNumber],
              controller: controller.creditCardNumberController,
              // focusNode: controller.nameFocus,
              textInputAction: TextInputAction.next,
              hintText: CourseCheckoutStrings.cardNo,
              validator: validateCardNumber,
              fillColor: Colors.transparent,
              prefixIcon: SvgImageFromAsset(
                CommonImageAssets.card,
                colorFilter: ColorFilter.mode(
                  isDarkMode
                      ? AppColors.bodyTextDarkColor
                      : AppColors.bodyTextColor,
                  BlendMode.srcIn,
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(19),
                CardNumberInputFormatter(),
              ],
            ),
          ),
          Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CommonText.medium(
              CourseCheckoutStrings.cardHolderName,
              size: 15,
            ),
          ),
          Gap(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CommonTextField(
              autofillHints: [AutofillHints.creditCardName],
              controller: controller.creditCardNameController,
              // focusNode: controller.nameFocus,
              textInputAction: TextInputAction.next,
              hintText: CourseCheckoutStrings.enterCardHolderName,
              validator: validateFullName,
              fillColor: Colors.transparent,
              prefixIcon: SvgImageFromAsset(
                CommonImageAssets.card,
                colorFilter: ColorFilter.mode(
                  isDarkMode
                      ? AppColors.bodyTextDarkColor
                      : AppColors.bodyTextColor,
                  BlendMode.srcIn,
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("^[a-zA-Z -]*")),
              ],
            ),
          ),
          Gap(20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonText.medium(
                        CourseCheckoutStrings.expiryDate,
                        size: 14,
                      ),
                      Gap(10),
                      CommonTextField(
                        autofillHints: [AutofillHints.creditCardExpirationDate],
                        controller: controller.expireDateController,
                        // focusNode: controller.nameFocus,
                        textInputAction: TextInputAction.next,
                        hintText: CourseCheckoutStrings.expiryDate,
                        validator: validateExpiryDate,

                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5), // MM/YY
                          ExpiryDateInputFormatter(),
                        ],
                        fillColor: Colors.transparent,
                        prefixIcon: SvgImageFromAsset(
                          CommonImageAssets.card,
                          colorFilter: ColorFilter.mode(
                            isDarkMode
                                ? AppColors.bodyTextDarkColor
                                : AppColors.bodyTextColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonText.medium(CourseCheckoutStrings.cvv, size: 14),
                      Gap(10),
                      CommonTextField(
                        controller: controller.cvvController,
                        // focusNode: controller.nameFocus,
                        textInputAction: TextInputAction.done,
                        hintText: CourseCheckoutStrings.enterCvv,

                        validator: validateCVVValue,
                        fillColor: Colors.transparent,
                        prefixIcon: SvgImageFromAsset(
                          CommonImageAssets.card,
                          colorFilter: ColorFilter.mode(
                            isDarkMode
                                ? AppColors.bodyTextDarkColor
                                : AppColors.bodyTextColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        maxLength: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget upiMethodView() {
  CourseCheckoutController controller = Get.put(CourseCheckoutController());
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: AppColors.greyColor, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => InkWell(
            onTap: () {
              controller.selectedUpi.value = true;
              controller.selectedCreditCard.value = false;
              controller.selectedPaypal.value = false;
              controller.selectedRazorpay.value = false;
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: controller.selectedUpi.value
                    ? isDarkMode
                          ? AppColors.greyDarkColor
                          : AppColors.cardBgColor
                    : Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: controller.selectedUpi.value
                        ? Colors.transparent
                        : AppColors.greyColor,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6),
                  topLeft: Radius.circular(6),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgImageFromAsset(
                    CommonImageAssets.upi,
                    height: 30,
                    width: 30,
                  ),
                  Gap(12),
                  Expanded(
                    child: CommonText.semiBold(
                      CourseCheckoutStrings.uPI,
                      size: 15,
                    ),
                  ),
                  Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.selectedUpi.value
                          ? AppColors.primary500
                          : Colors.transparent,
                      border: Border.all(
                        color: controller.selectedUpi.value
                            ? Colors.transparent
                            : AppColors.greyColor,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.selectedUpi.value
                              ? isDarkMode
                                    ? AppColors.greyDarkColor
                                    : AppColors.white
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Gap(20),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CommonText.medium(CourseCheckoutStrings.uPIId, size: 15),
        ),
        Gap(12),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15),
        //   child: Obx(() {
        //     return CommonTextField(
        //       controller: controller.upiIdController,
        //       textInputAction: TextInputAction.next,
        //       hintText: CourseCheckoutStrings.enterUPId,
        //       fillColor: Colors.transparent,
        //       validator: (value) {
        //         if (controller.selectedUpi.value) {
        //           String upi =
        //               "${controller.upiIdController.text.trim()}${controller.selectedUpiSuffix.value}";
        //           return controller.validateUPIId(upi);
        //         }
        //         return null;
        //       },
        //       suffixIcon: Align(
        //         alignment: Alignment.centerRight,
        //         child: DropdownButtonHideUnderline(
        //           child: DropdownButton<String>(
        //             value: controller.selectedUpiSuffix.value,
        //
        //             icon: Padding(
        //               padding: const EdgeInsets.only(right: 12),
        //               child: SvgImageFromAsset(
        //                 AppCommonIcon.arrowDownIcon,
        //                 colorFilter: ColorFilter.mode(
        //                   AppColors.bodyTextColor,
        //                   BlendMode.srcIn,
        //                 ),
        //               ),
        //             ),
        //             items: controller.upiSuffixList.map((suffix) {
        //               return DropdownMenuItem(
        //                 alignment: Alignment.centerRight,
        //                 value: suffix,
        //                 child: CommonText.medium(suffix, size: 14),
        //               );
        //             }).toList(),
        //             onChanged: (value) {
        //               if (value != null) {
        //                 controller.selectedUpiSuffix.value = value;
        //               }
        //             },
        //           ),
        //         ),
        //       ),
        //     );
        //   }),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Obx(() {
            return CommonTextField(
              controller: controller.upiIdController,
              textInputAction: TextInputAction.next,
              hintText: CourseCheckoutStrings.enterUPId,
              fillColor: Colors.transparent,
              validator: (value) {
                if (controller.selectedUpi.value) {
                  String upi =
                      "${controller.upiIdController.text.trim()}${controller.selectedUpiSuffix.value}";
                  return controller.validateUPIId(upi);
                }
                return null;
              },
              suffixIcon: GestureDetector(
                onTap: () async {
                  final selected = await showModalBottomSheet<String>(
                    context: Get.context!,
                    builder: (context) {
                      return ListView(
                        shrinkWrap: true,
                        children: controller.upiSuffixList.map((suffix) {
                          return ListTile(
                            title: CommonText.medium(suffix, size: 14),
                            onTap: () {
                              Navigator.pop(context, suffix);
                            },
                          );
                        }).toList(),
                      );
                    },
                  );
                  if (selected != null) {
                    controller.selectedUpiSuffix.value = selected;
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText.medium(
                      controller.selectedUpiSuffix.value,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    SvgImageFromAsset(
                      AppCommonIcon.arrowDownIcon,
                      colorFilter: ColorFilter.mode(
                        AppColors.bodyTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ), // for spacing between text and field edge
                  ],
                ),
              ),
            );
          }),
        ),

        Gap(20),
      ],
    ),
  );
}

Widget paypalMethodView() {
  CourseCheckoutController controller = Get.put(CourseCheckoutController());
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Obx(
    () => InkWell(
      onTap: () {
        controller.selectedPaypal.value = true;
        controller.selectedRazorpay.value = false;
        controller.selectedUpi.value = false;
        controller.selectedCreditCard.value = false;
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: controller.selectedPaypal.value
              ? isDarkMode
                    ? AppColors.greyDarkColor
                    : AppColors.cardBgColor
              : Colors.transparent,

          border: Border.all(
            color: controller.selectedPaypal.value
                ? Colors.transparent
                : isDarkMode
                ? AppColors.greyDarkColor
                : AppColors.greyColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgImageFromAsset(CommonImageAssets.paypal, height: 30, width: 30),
            Gap(12),
            Expanded(
              child: CommonText.semiBold(
                CourseCheckoutStrings.payPal,
                size: 15,
              ),
            ),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.selectedPaypal.value
                    ? AppColors.primary500
                    : Colors.transparent,
                border: Border.all(
                  color: controller.selectedPaypal.value
                      ? Colors.transparent
                      : AppColors.greyColor,
                  width: 1,
                ),
              ),
              child: Center(
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.selectedPaypal.value
                        ? isDarkMode
                              ? AppColors.greyDarkColor
                              : AppColors.white
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget razorpayMethodView() {
  CourseCheckoutController controller = Get.put(CourseCheckoutController());
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Obx(
    () => InkWell(
      onTap: () {
        controller.selectedRazorpay.value = true;
        controller.selectedUpi.value = false;
        controller.selectedCreditCard.value = false;
        controller.selectedPaypal.value = false;
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: controller.selectedRazorpay.value
              ? isDarkMode
                    ? AppColors.greyDarkColor
                    : AppColors.cardBgColor
              : Colors.transparent,

          border: Border.all(
            color: controller.selectedRazorpay.value
                ? Colors.transparent
                : isDarkMode
                ? AppColors.greyDarkColor
                : AppColors.greyColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgImageFromAsset(
              isDarkMode
                  ? CommonImageAssets.darkRazorpay
                  : CommonImageAssets.razorpay,
              height: 15,
              width: 15,
            ),
            Gap(12),
            Expanded(
              child: CommonText.semiBold(
                CourseCheckoutStrings.razorPay,
                size: 15,
              ),
            ),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.selectedRazorpay.value
                    ? AppColors.primary500
                    : Colors.transparent,
                border: Border.all(
                  color: controller.selectedRazorpay.value
                      ? Colors.transparent
                      : AppColors.greyColor,
                  width: 1,
                ),
              ),
              child: Center(
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.selectedRazorpay.value
                        ? isDarkMode
                              ? AppColors.greyDarkColor
                              : AppColors.white
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
