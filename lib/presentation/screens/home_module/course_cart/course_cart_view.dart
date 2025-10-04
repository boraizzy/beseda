part of 'course_cart_imports.dart';

class CourseCartView extends StatefulWidget {
  const CourseCartView({super.key});

  @override
  State<CourseCartView> createState() => _CourseCartViewState();
}

class _CourseCartViewState extends State<CourseCartView> {
  CourseCartController controller = Get.put(CourseCartController());
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
                child: CommonAppbar(title: CourseCartStrings.cart),
              ),

              Expanded(
                child: Obx(
                  () => controller.courseCartList.isEmpty
                      ? commonEmptyView(
                          image: isDarkMode
                              ? CommonImageAssets.emptyDarkCart
                              : CommonImageAssets.emptyCart,
                          title: CourseCartStrings.emptyCart,
                          subtitle: CourseCartStrings.emptyCartDes,
                        )
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: horizontalSpacing,
                                ),
                                child: Container(
                                  decoration: isDarkMode
                                      ? AppCommonShadow.commonDarkBoxShadow
                                      : AppCommonShadow.commonBoxShadow,
                                  child: ListView.separated(
                                    itemCount: controller.courseCartList.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    // padding: EdgeInsets.symmetric(
                                    //   horizontal: 15,
                                    //   vertical: 15,
                                    // ),
                                    itemBuilder: (context, index) {
                                      final data =
                                          controller.courseCartList[index];
                                      return cartView(
                                        data: data,
                                        context: context,
                                        onTap: () {
                                          showRemoveConfirmationDialog(
                                            context,
                                            () {
                                              controller.courseCartList
                                                  .removeAt(index);
                                              showSuccessMessage(
                                                context: context,
                                                title: CourseCartStrings
                                                    .itemRemovedSuccessfully,
                                                content: '',
                                              );
                                              Get.back();
                                            },
                                          );
                                        }, showRemoveOrWishlist: true,
                                        wishlistOnTap: () {
                                          controller.courseCartList
                                              .removeAt(index);
                                          showSuccessMessage(
                                            context: context,
                                            title: CourseCartStrings.itemAddedSuccessfully,
                                            content: '',
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            child: CommonDivider(),
                                          );
                                        },
                                  ),
                                ),
                              ),
                              Gap(30),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: horizontalSpacing,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgImageFromAsset(AppCommonIcon.coinsIcon),
                                    Gap(5),
                                    CommonText.medium(
                                      CourseCartStrings.useCoins,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                              Gap(25),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: horizontalSpacing,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CommonTextField(
                                        controller: controller.nameController,
                                        focusNode: controller.nameFocus,
                                        textInputAction: TextInputAction.next,
                                        hintText: CourseCartStrings
                                            .enterCoinsQuantity,
                                        fillColor: Colors.transparent,
                                      ),
                                    ),
                                    Gap(12),
                                    SizedBox(
                                      width: 75,

                                      child: PrimaryButton(
                                        onPressed: () {},
                                        label: AppCommonStrings.btnAdd,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(25),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: horizontalSpacing,
                                ),
                                child: commonSeeAllText(
                                  CourseDetailStrings.youMayAlsoLike,

                                  true,
                                  () {},
                                ),
                              ),
                              Gap(15),
                              Obx(
                                () => SizedBox(
                                  height: 240,
                                  child: ListView.builder(
                                    itemCount:
                                        controller.topRecommendedList.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(left: 20),
                                    itemBuilder: (context, index) {
                                      final data =
                                          controller.topRecommendedList[index];
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                            AppRouteName.courseDetailView,
                                            arguments: data,
                                          );
                                        },
                                        child: CommonCourseView(data: data),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Gap(20),
                            ],
                          ),
                        ),
                ),
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
                        controller.courseCartList.isEmpty
                            ? Get.offNamedUntil(
                          AppRouteName.bottomView,
                              (route) => route.isFirst,
                        )
                            : Get.toNamed(
                          AppRouteName.courseCheckoutView,
                         // arguments: List<CourseModel>.from(controller.courseCartList),

                          arguments: controller.courseCartList,
                        );
                      },
                      label: controller.courseCartList.isEmpty
                          ? CourseCartStrings.exploreCourses
                          : CourseCartStrings.proceedToCheckout,
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
}
