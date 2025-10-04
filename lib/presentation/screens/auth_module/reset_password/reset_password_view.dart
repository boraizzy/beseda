part of 'reset_password_imports.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  ResetPasswordController controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      body: Container(
        height: context.height,
        width: context.width,
        decoration: commonGradiantDecoration(),
        child: Column(
          children: [
            const Gap(20),
            CommonAppbar(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(10),
                        SvgImageFromAsset(
                          isDarkMode
                              ? CommonImageAssets.darkResetPassword
                              : CommonImageAssets.resetPassword,
                        ),
                        const Gap(45),
                        authTitleHeader(ResetPasswordStrings.resetYourPassword),
                        const Gap(10),
                        authSubTitleHeader(
                          "Въведете вашия имейл и ще ви изпратим линк за възстановяване.",
                        ),
                        const Gap(45),

                        // ✅ Email input
                        authHeader("Email"),
                        const Gap(10),
                        TextFormField(
                          controller: controller.emailController,
                          focusNode: controller.emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Въведете имейл";
                            }
                            if (!GetUtils.isEmail(value.trim())) {
                              return "Невалиден имейл";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Въведете имейл",
                            filled: true,
                            fillColor: isDarkMode ? AppColors.cardDarkBgColor : AppColors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),

                        const Gap(40),

                        Obx(() {
                          return controller.isLoading.value
                              ? const Center(child: CommonCircularLoader())
                              : PrimaryButton(
                                  onPressed: () {
                                    controller.submit();
                                  },
                                  label: "Изпрати линк",
                                );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
