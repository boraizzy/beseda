part of 'leader_board_imports.dart';

class LeaderBoardView extends StatefulWidget {
  const LeaderBoardView({super.key});

  @override
  State<LeaderBoardView> createState() => _LeaderBoardViewState();
}

class _LeaderBoardViewState extends State<LeaderBoardView> {
  LeaderBoardController controller = Get.put(LeaderBoardController());
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
                child: CommonAppbar(title: LeaderBoardStrings.leaderBoard),
              ),
              Gap(20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SvgImageFromAsset(
                          isDarkMode
                              ? CommonImageAssets.darkLeaderBoard
                              : CommonImageAssets.leaderBoard,
                        ),
                      ),
                      Gap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText.semiBold(
                              LeaderBoardStrings.leaderBoard,
                              size: 16,
                            ),
                            Obx(
                              () => SizedBox(
                                width: controller.showBackToTop.value ? 95 : 80,
                                child: PrimaryButton(
                                  height: 32,
                                  borderRadius: 4,
                                  onPressed: () {
                                    controller.showBackToTop.value
                                        ? controller.backToTop()
                                        : controller.findUser();
                                  },
                                  label: controller.showBackToTop.value
                                      ? LeaderBoardStrings.backToTop
                                      : LeaderBoardStrings.findMe,
                                  textSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(20),
                      Obx(
                        () => ListView.builder(
                          controller: controller.scrollController,
                          itemCount: controller.pagedList.length + 1,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final isLastItem =
                                index == controller.pagedList.length;

                            if (index == 0) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? AppColors.cardDarkBgColor
                                      : AppColors.cardBgColor,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: commonLevel(
                                        LeaderBoardStrings.rank,
                                      ),
                                    ),
                                    Expanded(
                                      child: commonLevel(SignUpStrings.name),
                                    ),
                                    Expanded(
                                      child: commonLevel(
                                        LeaderBoardStrings.score,
                                      ),
                                    ),
                                    Expanded(
                                      child: commonLevel(
                                        CourseCheckoutStrings.country,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            final data = controller.pagedList[index - 1];
                            final isHighlighted =
                                data.name == "Davon Johan" &&
                                controller.findMe.value;

                            return Container(
                              height: 64,
                              decoration: BoxDecoration(
                                color: isHighlighted
                                    ? isDarkMode
                                          ? AppColors.secondary40
                                          : AppColors.secondary50
                                    : Colors.transparent,
                                border: Border(
                                  top: BorderSide(
                                    color: isHighlighted
                                        ? AppColors.secondary500
                                        : AppColors.greyColor,
                                    width: 0.75,
                                  ),
                                  bottom: isLastItem
                                      ? BorderSide.none
                                      : BorderSide(
                                          color: isHighlighted
                                              ? AppColors.secondary500
                                              : AppColors.greyColor,
                                          width: 0.75,
                                        ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: commonText(
                                      '#${data.rank}',
                                      isHighlighted
                                          ? AppColors.secondary500
                                          : null,
                                    ),
                                  ),
                                  Expanded(
                                    child: commonText(
                                      data.name,
                                      isHighlighted
                                          ? AppColors.secondary500
                                          : null,
                                    ),
                                  ),
                                  Expanded(
                                    child: commonText(
                                      data.score.toString(),
                                      isHighlighted
                                          ? AppColors.secondary500
                                          : null,
                                    ),
                                  ),
                                  Expanded(
                                    child: commonText(
                                      data.country,
                                      isHighlighted
                                          ? AppColors.secondary500
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(top: 15,left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: controller.currentPage.value > 1
                            ? controller.goToPreviousPage
                            : null,
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: controller.currentPage.value > 1
                                ? AppColors.primary500
                                : isDarkMode
                                ? AppColors.greyDarkColor
                                : AppColors.cardBgColor,
                            border: Border.all(
                              color: controller.currentPage.value > 1
                                  ? Colors.transparent
                                  : isDarkMode
                                  ? AppColors.bodyTextColor
                                  : AppColors.primary500,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: SvgImageFromAsset(
                              AppCommonIcon.backIcon,
                              colorFilter: ColorFilter.mode(
                                controller.currentPage.value > 1
                                    ? AppColors.white
                                    : isDarkMode
                                    ? AppColors.white
                                    : AppColors.headingsColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),

                      CommonText.regular(
                        'Page ${controller.currentPage.value} of ${controller.totalPages}',
                      ),

                      InkWell(
                        onTap:
                            controller.currentPage.value < controller.totalPages
                            ? controller.goToNextPage
                            : null,
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: AppColors.primary500,

                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: SvgImageFromAsset(
                              AppCommonIcon.rightIcon,
                              colorFilter: ColorFilter.mode(
                                AppColors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //     DataTable(
              //     columnSpacing: 20.0,
              //     horizontalMargin: 10.0,
              //     //dividerThickness: 1.5,
              //     border: const TableBorder(
              //       bottom: BorderSide(
              //         width: 1.5,
              //         color: Colors.yellow,
              //       ),
              //       horizontalInside: BorderSide(
              //         width: 1.5,
              //         color: Colors.red,
              //       ),
              //     ),
              //
              //   headingRowColor: WidgetStateColor.resolveWith(
              //     (states) => AppColors.cardBgColor,
              //   ),
              //   // Datatable widget that have the property columns and rows.
              //   columns: [
              //     // Set the name of the column
              //     DataColumn(
              //       label: _commonLevel(LeaderBoardStrings.rank),
              //     ),
              //     DataColumn(label: _commonLevel(SignUpStrings.name)),
              //     DataColumn(
              //       label: _commonLevel(LeaderBoardStrings.score),
              //     ),
              //     DataColumn(
              //       label: _commonLevel(
              //         CourseCheckoutStrings.country,
              //       ),
              //     ),
              //   ],
              //   rows: List.generate(controller.pagedList.length, (index) {
              //     final data=controller.pagedList[index];
              //     return  DataRow(
              //
              //       cells: [
              //         DataCell(_commonText('#${data.rank.toString()}')),
              //         DataCell(_commonText(data.name)),
              //         DataCell(_commonText(data.score.toString())),
              //         DataCell(_commonText(data.country)),
              //       ],
              //     );
              //   },)
              //
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
