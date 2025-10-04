part of 'course_checkout_imports.dart';

class CourseCheckoutView extends StatefulWidget {
  const CourseCheckoutView({super.key});

  @override
  State<CourseCheckoutView> createState() => _CourseCheckoutViewState();
}

class _CourseCheckoutViewState extends State<CourseCheckoutView> {
  CourseCheckoutController controller = Get.put(CourseCheckoutController());
  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 20;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      body: Container(
        height: context.height,
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? AppCommonGradient.mainDarkBackgroundGradient
              : AppCommonGradient.mainBackgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: CommonAppbar(title: CourseCheckoutStrings.checkout),
              ),
              Expanded(
                child: Obx(() {
                  final isCartEmpty =
                      (controller.singleCourseData.value == null) &&
                      (controller.courseList?.isEmpty ?? true);

                  return isCartEmpty
                      ? commonEmptyView(
                          image: isDarkMode
                              ? CommonImageAssets.emptyDarkCart
                              : CommonImageAssets.emptyCart,
                          title: CourseCartStrings.emptyCart,
                          subtitle: CourseCartStrings.emptyCartDes,
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: horizontalSpacing,
                              vertical: horizontalSpacing,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: isDarkMode
                                      ? AppCommonShadow.commonDarkBoxShadow
                                      : AppCommonShadow.commonBoxShadow,
                                  child:
                                      controller.singleCourseData.value != null
                                      ? cartView(
                                          data:
                                              controller
                                                  .singleCourseData
                                                  .value ??
                                              CourseModel.empty(),
                                          context: context,
                                          onTap: () {
                                            showRemoveConfirmationDialog(
                                              context,
                                              () {},
                                            );
                                          },
                                          showRemoveOrWishlist: false,
                                        )
                                      : ListView.separated(
                                          itemCount:
                                              controller.courseList!.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),

                                          itemBuilder: (context, index) {
                                            final data =
                                                controller.courseList![index];
                                            return cartView(
                                              data: data,
                                              context: context,
                                              onTap: () {
                                                showRemoveConfirmationDialog(
                                                  context,
                                                  () {
                                                    controller.courseList
                                                        ?.removeAt(index);
                                                    showSuccessMessage(
                                                      context: context,
                                                      title: CourseCartStrings
                                                          .itemRemovedSuccessfully,
                                                      content: '',
                                                    );
                                                    Get.back();
                                                  },
                                                );
                                              },
                                              showRemoveOrWishlist: false,
                                            );
                                          },
                                          separatorBuilder:
                                              (
                                                BuildContext context,
                                                int index,
                                              ) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                      ),
                                                  child: CommonDivider(),
                                                );
                                              },
                                        ),
                                ),
                                Gap(25),
                                CommonText.semiBold(
                                  CourseCheckoutStrings.billingAddress,
                                  size: 16,
                                ),
                                Gap(25),
                                CommonText.medium(
                                  CourseCheckoutStrings.country,
                                  size: 15,
                                ),
                                Gap(12),
                                Obx(
                                  () => CommonTextField(
                                    readOnly: true,
                                    onTap: () => showCountryPickerDialog(),
                                    autofillHints: const [AutofillHints.name],
                                    controller:
                                        controller.countryNameController,
                                    // focusNode: controller.nameFocus,
                                    textInputAction: TextInputAction.next,
                                    hintText:
                                        controller.selectedCountry.value.isEmpty
                                        ? CourseCheckoutStrings.selectCountry
                                        : controller.selectedCountry.value,
                                    fillColor: Colors.transparent,
                                    prefixIcon: SvgImageFromAsset(
                                      CommonImageAssets.languageImg,
                                      colorFilter: ColorFilter.mode(
                                        isDarkMode
                                            ? AppColors.bodyTextDarkColor
                                            : AppColors.bodyTextColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    suffixIcon: SvgImageFromAsset(
                                      AppCommonIcon.arrowDownIcon,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.bodyTextColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                Gap(25),
                                CommonText.medium(
                                  CourseCheckoutStrings.state,
                                  size: 15,
                                ),
                                Gap(12),
                                Obx(
                                  () => CommonTextField(
                                    onTap:
                                        controller.selectedState.value.isEmpty
                                        ? () => showStatePickerDialog()
                                        : null,
                                    readOnly: true,
                                    autofillHints: const [AutofillHints.name],
                                    controller: controller.stateController,
                                    // focusNode: controller.nameFocus,
                                    textInputAction: TextInputAction.next,
                                    hintText:
                                        controller.selectedState.value.isEmpty
                                        ? CourseCheckoutStrings.selectState
                                        : controller.selectedState.value,
                                    fillColor: Colors.transparent,
                                    prefixIcon: SvgImageFromAsset(
                                      CommonImageAssets.languageImg,
                                      colorFilter: ColorFilter.mode(
                                        isDarkMode
                                            ? AppColors.bodyTextDarkColor
                                            : AppColors.bodyTextColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    suffixIcon: SvgImageFromAsset(
                                      AppCommonIcon.arrowDownIcon,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.bodyTextColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                Gap(25),
                                CommonText.medium(
                                  CourseCheckoutStrings.paymentMethod,
                                  size: 15,
                                ),
                                Gap(15),
                                //credit card view
                                creditCardView(),
                                Gap(15),
                                //selected upi
                                upiMethodView(),
                                Gap(20),
                                //paypal
                                paypalMethodView(),
                                Gap(20),
                                //razorpay
                                razorpayMethodView(),
                              ],
                            ),
                          ),
                        );
                }),
              ),
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.cardDarkBgColor
                      : AppColors.mainBgColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-6, -6),
                      color: AppColors.black.withValues(alpha: 0.09),
                      blurRadius: 23,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalSpacing,
                    vertical: 20,
                  ),
                  child: Obx(
                    () => PrimaryButton(
                      onPressed: () {
                        final isCartEmpty =
                            (controller.singleCourseData.value == null) &&
                            (controller.courseList?.isEmpty ?? true);

                        if (isCartEmpty) {
                          Get.offNamedUntil(
                            AppRouteName.bottomView,
                            (route) => route.isFirst,
                          );
                        } else {
                          String? error = controller.validatePaymentFields();
                          if (error != null) {
                            Get.snackbar(
                              "Payment Error",
                              error,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red.shade400,
                              colorText: Colors.white,
                              duration: Duration(seconds: 2),
                            );
                            return;
                          }

                          Get.offNamed(AppRouteName.paymentView);
                        }
                      },

                      // onPressed: () {
                      //   controller.singleCourseData == null &&
                      //           controller.courseList!.isEmpty
                      //       ? Get.offNamedUntil(
                      //           AppRouteName.bottomView,
                      //           (route) => route.isFirst,
                      //         )
                      //       : Get.toNamed(AppRouteName.paymentView);
                      // },
                      // label: controller.singleCourseData == null &&
                      //     controller.courseList!.isEmpty
                      //     ? CourseCartStrings.exploreCourses
                      //     : controller.totalPrice.value.toString(),
                      label:
                          (controller.singleCourseData.value == null &&
                              (controller.courseList?.isEmpty ?? true))
                          ? CourseCartStrings.exploreCourses
                          : 'Pay \$${controller.totalPrice.value.toString()}',
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

  void showCountryPickerDialog() {
    final searchText = ''.obs;
    final filteredList = controller.countryList.toList().obs;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    Get.dialog(
      AlertDialog(
        title: CommonText.medium(CourseCheckoutStrings.selectCountry, size: 18),
        content: SizedBox(
          height: 400,
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => CommonSearchField(
                    controller: controller.searchController,
                    hintText: CourseCheckoutStrings.searchCountry,
                    onChanged: (val) {
                      searchText.value = val!;
                      filteredList.value = controller.countryList
                          .where(
                            (c) => c.toLowerCase().contains(val.toLowerCase()),
                          )
                          .toList();
                    },
                    suffixWidget: searchText.value == ''
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              controller.searchController.clear();
                              searchText.value = '';
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgImageFromAsset(
                                AppCommonIcon.closeIcon,

                                colorFilter: ColorFilter.mode(
                                  isDarkMode
                                      ? AppColors.white
                                      : AppColors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                Gap(10),

                SizedBox(
                  height: 300,
                  child: Obx(() {
                    return filteredList.isEmpty
                        ? Center(
                            child: CommonText.medium(
                              CourseCheckoutStrings.noCountryFound,
                              size: 18,
                            ),
                          )
                        : ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (_, index) {
                              final country = filteredList[index];
                              return ListTile(
                                title: CommonText.medium(country, size: 15),
                                onTap: () {
                                  controller.selectedCountry.value = country;
                                  controller.selectedState.value = '';
                                  Get.back();
                                },
                              );
                            },
                          );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showStatePickerDialog() {
    final selectedCountry = controller.selectedCountry.value;
    final searchText = ''.obs;
    final states = controller.stateMap[selectedCountry] ?? [];
    final filteredStates = states.obs;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    Get.dialog(
      AlertDialog(
        title: CommonText.medium(CourseCheckoutStrings.selectState, size: 18),
        content: SizedBox(
          height: 400,
          width: double.maxFinite,

          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonSearchField(
                  controller: controller.searchController,
                  hintText: CourseCheckoutStrings.searchState,
                  onChanged: (val) {
                    searchText.value = val!;
                    filteredStates.value = states
                        .where(
                          (s) => s.toLowerCase().contains(val.toLowerCase()),
                        )
                        .toList();
                  },
                  suffixWidget: searchText.value == ''
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            controller.searchController.clear();
                            searchText.value = '';
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgImageFromAsset(
                              AppCommonIcon.closeIcon,

                              colorFilter: ColorFilter.mode(
                                isDarkMode ? AppColors.white : AppColors.black,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                ),

                Gap(10),
                SizedBox(
                  height: 300,
                  child: Obx(
                    () => filteredStates.isEmpty
                        ? const SizedBox(
                            height: 300,
                            child: Center(
                              child: CommonText.medium(
                                CourseCheckoutStrings.noStateFound,
                                size: 18,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: filteredStates.length,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              final state = filteredStates[index];
                              return ListTile(
                                title: CommonText.medium(state, size: 15),
                                onTap: () {
                                  controller.selectedState.value = state;
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
