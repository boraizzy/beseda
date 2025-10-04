part of 'course_certificate_imports.dart';

class CourseCertificateView extends StatefulWidget {
  const CourseCertificateView({super.key});

  @override
  State<CourseCertificateView> createState() => _CourseCertificateViewState();
}

class _CourseCertificateViewState extends State<CourseCertificateView> {
  CourseCertificateController controller=Get.put(CourseCertificateController());
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
                padding: const EdgeInsets.only(right: 17),
                child: CommonAppbar(
                  title: CourseCertificateStrings.courseCompleted,
                ),
              ),
              Gap(20),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonText.medium(
                          CourseCertificateStrings.congratulationOnMastering,
                          size: 16,
                          color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
                        ),
                        Gap(10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: CommonText.semiBold(
                            controller.title,
                            size: 16,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Gap(40),
                        Image.asset(CommonImageAssets.courseCertificate,height: 255,width: double.infinity,),
                        Gap(15),
                        CommonText.regular(
                          CourseCertificateStrings.youHaveSuccessfully,
                          size: 16,
                          color: isDarkMode?AppColors.bodyTextDarkColor:AppColors.bodyTextColor,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
                  child: PrimaryButton(
                    onPressed: () {
                      Get.offNamedUntil(
                        AppRouteName.bottomView,
                       (route) => route.isFirst,
                      );
                      showSuccessMessage(
                        context: context,
                        title: CourseCertificateStrings.certificateDownloadSuccessfully,
                        content: '',
                      );
                    },
                    label: CourseCertificateStrings.downloadCertificate,
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
