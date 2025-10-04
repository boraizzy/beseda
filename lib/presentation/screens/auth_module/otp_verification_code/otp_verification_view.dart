part of 'otp_verification_imports.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  OtpVerificationController controller = Get.put(OtpVerificationController());

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      body: Container(
        height: context.height,
        width: context.width,
        decoration: commonGradiantDecoration(),
        child: SafeArea(
          child: Column(
            children: [
              const Gap(20),
              CommonAppbar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const Gap(20),
                        SvgImageFromAsset(
                          isDarkMode
                              ? CommonImageAssets.darkOtpVerify
                              : CommonImageAssets.otpVerify,
                        ),
                        const Gap(45),
                        authTitleHeader(SignUpStrings.verifyYourEmail),
                        const Gap(10),
                        authSubTitleHeader(
                          "Моля, проверете имейла си, за да потвърдите регистрацията.",
                        ),
                        const Gap(5),
                        CommonText.semiBold(
                          controller.email,
                          size: 14,
                          color: AppColors.primary500,
                          textAlign: TextAlign.center,
                        ),

                        const Gap(45),

                        // ✅ "I've verified" button
                        PrimaryButton(
                          onPressed: () async {
                            User? user = _auth.currentUser;
                            await user?.reload();
                            user = _auth.currentUser;

                            if (user != null && user.emailVerified) {
                              Get.offNamed(AppRouteName.profileSetupView);
                            } else {
                              Get.snackbar(
                                "Info",
                                "Имейлът все още не е потвърден",
                              );
                            }
                          },
                          label: "Проверих имейла",
                        ),

                        const Gap(20),

                        // ✅ Resend verification email
                        Obx(() {
                          return controller.isLoading.value
                              ? const Center(child: CommonCircularLoader())
                              : TextButton(
                                  onPressed: () async {
                                    try {
                                      User? user = _auth.currentUser;
                                      await user?.sendEmailVerification();
                                      Get.snackbar(
                                        "Успешно",
                                        "Нов имейл за потвърждение изпратен",
                                      );
                                    } catch (e) {
                                      Get.snackbar("Error", e.toString());
                                    }
                                  },
                                  child: const Text(
                                    "Изпрати отново",
                                    style: TextStyle(color: AppColors.primary500),
                                  ),
                                );
                        }),
                      ],
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
