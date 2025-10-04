part of 'all_university_imports.dart';

class AllUniversityListView extends StatefulWidget {
  const AllUniversityListView({super.key});

  @override
  State<AllUniversityListView> createState() => _AllUniversityListViewState();
}

class _AllUniversityListViewState extends State<AllUniversityListView> {
  AllUniversityController controller = Get.put(AllUniversityController());
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
                child: CommonAppbar(
                  title: AllUniversityListStrings.exclusiveUniversityPartnership,
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.universityList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalSpacing,
                      vertical: 15,
                    ),
                    itemBuilder: (context, index) {
                      final data = controller.universityList[index];
                      return _universityView(data);
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
  _universityView(UniversityModel data){
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRouteName.universityDetailView,arguments: data);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: commonCacheImage(
                    data.image,
                    ImagePlaceHolder.imagePlaceHolderDark,
                    // fit: BoxFit.cover,
                    width: double.infinity,
                    height: 152,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      SharePlus.instance.share(
                        ShareParams(
                          text: data.name,

                        ),
                      );

                    },
                    child: SvgImageFromAsset(
                      CommonImageAssets.shareImg,
                    ),
                  ),
                ),
              ],
            ),
            Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText.semiBold(data.name, size: 15),
                CommonText.medium(
                  '${data.noOfCourses.toString()} ${TrainerProfileDetailStrings.courses}',
                  size: 14,
                  color:isDarkMode?AppColors.bodyTextDarkColor: AppColors.bodyTextColor,
                ),
              ],
            ),
            Gap(12),
            CommonText.regular(
              data.description,
              size: 14,
              color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
