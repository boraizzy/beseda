part of 'course_category_list_view_imports.dart';

class CourseCategoryListView extends StatefulWidget {
  const CourseCategoryListView({super.key});

  @override
  State<CourseCategoryListView> createState() => _CourseCategoryListViewState();
}

class _CourseCategoryListViewState extends State<CourseCategoryListView> {
  CourseCategoryController controller = Get.put(CourseCategoryController());
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
              CommonAppbar(title: SearchViewStrings.search),
              Gap(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                child: Obx(
                  () => CommonSearchField(
                    controller: controller.searchController.value,
                    hintText: HomeViewStrings.searchAnything,
                    suffixWidget: controller.searchQuery.value.isEmpty
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              controller.searchQuery.value = '';
                              controller.searchController.value.clear();
                              controller.search('');
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
                    onChanged: (query) {
                      controller.search(query!);
                    },
                  ),
                ),
              ),
              Gap(20),
              Expanded(
                child: Obx(
                  () => controller.filteredICourseCategoryList.isEmpty
                      ? commonEmptyView(
                          image: isDarkMode
                              ? CommonImageAssets.darkEmptySearch
                              : CommonImageAssets.emptySearch,
                          title: SearchViewStrings.oopsNothingFound,
                          subtitle: SearchViewStrings.oopsNothingFoundDes,
                        )
                      : ListView.separated(
                          itemCount:
                              controller.filteredICourseCategoryList.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                            horizontal: horizontalSpacing,
                          ),
                          itemBuilder: (context, index) {
                            final course =
                                controller.filteredICourseCategoryList[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 12,
                                top: 12,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    AppRouteName.courseCategoryDetailView,
                                    arguments: course,
                                  );
                                },
                                child: CommonCourseCategoryView(course: course),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return CommonDivider();
                          },
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
