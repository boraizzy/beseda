part of 'quiz_imports.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  QuizController controller = Get.put(QuizController());


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
        child: Obx(
          () => SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CommonAppbar(
                    onPressedBack: () {
                      // controller.answerList?.isNotEmpty == true?Get.back():
                      showConfirmationDialog(context);
                    },
                    title: controller.answerList != null
                        ? QuizScreenStrings.answers
                        : controller.data?.name ?? "Quiz",
            
                  ),
                ),
                Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalSpacing,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.semiBold(
                        QuizScreenStrings.question,
                        size: 20,
                        color: isDarkMode
                            ? AppColors.bodyTextDarkColor
                            : AppColors.bodyTextColor,
                      ),
                      CommonText.semiBold(
                        '${controller.pageIndex.value + 1}/${controller.quizList.length}',
                        size: 20,
                      ),
                    ],
                  ),
                ),
                Gap(30),
                Expanded(
                  child: PageView.builder(
                    itemCount: controller.answerList?.isNotEmpty == true
                        ? controller.answerList!.length
                        : controller.quizList.length,
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, mainIndex) {
                      final isSubmitted =
                          controller.answerList?.isNotEmpty == true;
                      final data = isSubmitted
                          ? controller.answerList![mainIndex]
                          : controller.quizList[mainIndex];
            
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.medium(data.question, size: 18),
                            const Gap(80),
                            data.options[mainIndex].isImage
                                ? SizedBox()
                                : CommonText.medium(
                                    QuizScreenStrings.selectOption,
                                    size: 18,
                                  ),
            
                            data.options.any((e) => e.isImage == true)
                                ? GridView.builder(
                                    itemCount: data.options.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 300,
                                        ),
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          if (!isSubmitted) {
                                            controller.selectOption(
                                              mainIndex,
                                              index,
                                            );
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                Image.asset(
                                                  data.options[index].value,
                                                  width: double.infinity,
                                                  fit: BoxFit.contain,
                                                ),
                                                if (isSubmitted) ...[
                                                  if (index ==
                                                      data.correctOptionIndex)
                                                    buildCheck(),
                                                  if (index ==
                                                          data.selectedOptionIndex &&
                                                      index !=
                                                          data.correctOptionIndex)
                                                    buildWrong(),
                                                ] else if (data
                                                        .selectedOptionIndex ==
                                                    index)
                                                  buildCheck(),
                                              ],
                                            ),
                                            const Gap(8),
                                            buildKeyCircle(
                                              data.options[index].key,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : ListView.separated(
                                    itemCount: data.options.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          if (!isSubmitted) {
                                            controller.selectOption(
                                              mainIndex,
                                              index,
                                            );
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: !isSubmitted ? 0 : 10,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 15,
                                            horizontal: 15,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSubmitted
                                                ? getColorForSubmitted(
                                                    data,
                                                    index,
                                                  )
                                                : data.selectedOptionIndex ==
                                                      index
                                                ? isDarkMode
                                                      ? AppColors.cardDarkBg2Color
                                                      : AppColors.cardBgColor
                                                : Colors.transparent,
                                            border: Border.all(
                                              // color: isSubmitted
                                              //     ? getBorderColorForSubmitted(
                                              //   data,
                                              //   index,
                                              // )
                                              //     : data.selectedOptionIndex == index
                                              //     ? isDarkMode?AppColors.cardDarkBg2Color:AppColors.cardBgColor
                                              //     : Colors.transparent,
                                              color: isSubmitted
                                                  ? getBorderColorForSubmitted(
                                                      data,
                                                      index,
                                                    )
                                                  : Colors.transparent,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              isSubmitted &&
                                                      index ==
                                                          data.correctOptionIndex
                                                  ? 6
                                                  : isSubmitted &&
                                                        index !=
                                                            data.correctOptionIndex
                                                  ? 6
                                                  : 0,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: CommonText.regular(
                                                  data.options[index].value,
                                                  size: 14,
                                                  color: isSubmitted
                                                      ? getTextColorForSubmitted(
                                                          data,
                                                          index,
                                                        )
                                                      : isDarkMode
                                                      ? AppColors
                                                            .bodyTextDarkColor
                                                      : AppColors.bodyTextColor,
                                                ),
                                              ),
                                              const Gap(20),
                                              if (isSubmitted) ...[
                                                if (index ==
                                                    data.correctOptionIndex)
                                                  buildCheck(),
                                                if (index ==
                                                        data.selectedOptionIndex &&
                                                    index !=
                                                        data.correctOptionIndex)
                                                  buildWrong(),
                                              ] else
                                                buildRadioCircle(
                                                  data.selectedOptionIndex ==
                                                      index,
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        isSubmitted &&
                                            index == data.correctOptionIndex
                                        ? SizedBox()
                                        : isSubmitted &&
                                              index != data.correctOptionIndex
                                        ? SizedBox()
                                        : CommonDivider(),
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            
                Obx(() {
                    final isSubmitted = controller.answerList?.isNotEmpty == true;
                    final pageIndex = controller.pageIndex.value;
                    final totalLength = isSubmitted
                        ? controller.answerList!.length
                        : controller.quizList.length;
                    final isFirstPage = pageIndex == 0;
                    final isLastPage = pageIndex == totalLength - 1;
            
                    final showPrevButton =
                        isSubmitted || controller.data?.name.isNotEmpty == true ||
                        (!isSubmitted && !isFirstPage && !isLastPage);
            
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: horizontalSpacing,
                      ),
                      child: Row(
                        children: [
                          // 🔘 Previous button
                          if (showPrevButton)
                            Expanded(
                              child: OutlineButton(
                                onPressed: (isSubmitted && isFirstPage)
                                    ? null
                                    : controller.goToPreviousPage,
                                label: QuizScreenStrings.previousQuestion,
                                borderSide: BorderSide(
                                  color: (isSubmitted && isFirstPage)
                                      ? AppColors.greyColor
                                      : AppColors.primary500,
                                ),
                                textColor: (isSubmitted && isFirstPage)
                                    ? AppColors.greyColor
                                    : AppColors.primary500,
                                textSize: 16,
                                textWeight: FontWeight.w500,
                              ),
                            ),
            
                          if (showPrevButton) const Gap(20),
            
                          // ✅ Next / Submit / Go to Home
                          Expanded(
                            child: PrimaryButton(
                              onPressed: () {
            
                                if (isSubmitted && isLastPage) {
                                  Get.offNamedUntil(
                                    AppRouteName.bottomView,
                                    (route) => route.isFirst,
                                  );
                                } else {
                                  controller.goToNextPage();
                                }
                              },
                              label: isSubmitted && isLastPage
                                  ? PaymentViewStrings.goToHome
                                  : !isSubmitted && isLastPage
                                  ? QuizScreenStrings.submitQuiz
                                  : QuizScreenStrings.nextQuestion,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            
            
                Gap(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
