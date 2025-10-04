part of 'search_screen_imports.dart';

class SearchScreenView extends StatefulWidget {
  const SearchScreenView({super.key});

  @override
  State<SearchScreenView> createState() => _SearchScreenViewState();
}

class _SearchScreenViewState extends State<SearchScreenView> {
  SearchScreenController controller = Get.put(SearchScreenController());
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: CommonSearchField(
                          controller: controller.searchController,
                          hintText: HomeViewStrings.searchAnything,
                        ),
                      ),
                      Gap(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: commonSeeAllText(
                          SearchViewStrings.topSearches,

                          false,
                          () {},
                        ),
                      ),
                      Gap(15),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.start,

                          children: controller.courseCategoryList.map((
                            category,
                          ) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:isDarkMode?AppColors.grey100Color:AppColors.greyColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(70),
                              ),
                              child: CommonText.regular(
                                category.name,
                                size: 14,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Gap(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                        ),
                        child: commonSeeAllText(
                          SearchViewStrings.smartCoursesForYou,

                          false,
                          () {},
                        ),
                      ),
                    ],
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
