part of 'participants_list_imports.dart';

class ParticipantsListView extends StatefulWidget {
  const ParticipantsListView({super.key});

  @override
  State<ParticipantsListView> createState() => _ParticipantsListViewState();
}

class _ParticipantsListViewState extends State<ParticipantsListView> {
  ParticipantsListController controller = Get.put(ParticipantsListController());
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
        child: Column(
          children: [
            Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalSpacing,
              ),
              child: SafeArea(
                bottom: false,
                  child: liveSessionView()),
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
                    ParticipantsString.participants,
                    size: 16,
                  ),
                  SvgImageFromAsset(
                    AppCommonIcon.closeIcon,
                    colorFilter: ColorFilter.mode(
                      AppColors.greyColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
            Gap(25),
            _searchTextFiled(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(25),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: AppColors.greyColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ExpansionTile(
                            title: CommonText.medium(
                              '${ParticipantsString.host} (${controller.detail.value.hostList.length})',
                              size: 16,
                            ),
                            collapsedIconColor: isDarkMode
                                ? AppColors.bodyTextDarkColor
                                : AppColors.bodyTextColor,
                            iconColor: isDarkMode
                                ? AppColors.bodyTextDarkColor
                                : AppColors.bodyTextColor,
                            tilePadding: EdgeInsets.symmetric(horizontal: 15),
                            childrenPadding: EdgeInsets.zero,
                            children: [
                              CommonDivider(),
                              Gap(15),
                              ListView.builder(
                                itemCount:
                                    controller.detail.value.hostList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                itemBuilder: (context, index) {
                                  final data =
                                      controller.detail.value.hostList[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: CommonText.medium(
                                            data.name,
                                            size: 14,
                                            color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
                                          ),
                                        ),
                                        SvgImageFromAsset(
                                          AppCommonIcon.wifiNetworkIcon,
                                        ),
                                        Gap(15),
                                        Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                            color: AppColors.primary500,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: SvgImageFromAsset(
                                              AppCommonIcon.micIcon,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Gap(25),
                    Obx(
                          () => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: AppColors.greyColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ExpansionTile(
                            title: CommonText.medium(
                              '${ParticipantsString.participants} (${controller.detail.value.participantsList.length})',
                              size: 16,
                            ),
                            collapsedIconColor: isDarkMode
                                ? AppColors.bodyTextDarkColor
                                : AppColors.bodyTextColor,
                            iconColor: isDarkMode
                                ? AppColors.bodyTextDarkColor
                                : AppColors.bodyTextColor,
                            tilePadding: EdgeInsets.symmetric(horizontal: 15),
                            childrenPadding: EdgeInsets.zero,
                            children: [
                              CommonDivider(),
                              Gap(15),
                              ListView.builder(
                                itemCount:
                                controller.detail.value.participantsList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                itemBuilder: (context, index) {
                                  final data =
                                  controller.detail.value.participantsList[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: CommonText.medium(
                                            data.name,
                                            size: 14,
                                            color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
                                          ),
                                        ),

                                        data.showMe?Container(
                                          height: 25,
                                            width: 25,

                                            decoration: BoxDecoration(
                                              color: AppColors.primary500,
                                              shape: BoxShape.circle
                                            )
                                            ,
                                            child: Center(child: SvgImageFromAsset(AppCommonIcon.handsUpIcon,))):
                                        Gap(15),
                                        data.speaking?Padding(
                                          padding: const EdgeInsets.only(right: 15),
                                          child: SvgImageFromAsset(AppCommonIcon.speakingIcon,),
                                        ):
                                        Gap(15),
                                        Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                            color: AppColors.primary500,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: SvgImageFromAsset(
                                              AppCommonIcon.micIcon,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            commonBottomViewOfMeeting(() {},context),
          ],
        ),
      ),
    );
  }

  _searchTextFiled() {
    const double horizontalSpacing = 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
      child: CommonSearchField(
        controller: controller.searchController,
        hintText: ParticipantsString.findWhom,
        onSearchTap: () {},
      ),
    );
  }
}
