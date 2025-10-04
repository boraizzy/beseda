part of 'faq_view_imports.dart';

class FaqView extends StatefulWidget {
  const FaqView({super.key});

  @override
  State<FaqView> createState() => _FaqViewState();
}

class _FaqViewState extends State<FaqView> {
  FaqController controller = Get.put(FaqController());
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppbar(title: FaqViewString.faqTitle),
              Gap(20),
              Expanded(
                child: ListView.separated(
                  itemCount: controller.frequentQuestionsList.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                  itemBuilder: (context, index) {
                    final FaqModel data = controller.frequentQuestionsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Obx(
                        () => Theme(
                          data: Theme.of(
                            context,
                          ).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            title: CommonText.medium(data.question, size: 16),
                            childrenPadding: EdgeInsets.zero,
                            tilePadding: EdgeInsets.zero,
          
                            trailing: Icon(
                              data.isExpanded.value ? Icons.remove : Icons.add,
                              color:isDarkMode?AppColors.white: AppColors.headingsColor,
                            ),
                            onExpansionChanged: (value) {
                              controller.toggleExpansion(data);
                            },
                            children: [
                              CommonText.regular(
                                data.answer,
                                size: 15,
                                color: isDarkMode
                                    ? AppColors.bodyTextDarkColor
                                    : AppColors.bodyTextColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CommonDivider(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
