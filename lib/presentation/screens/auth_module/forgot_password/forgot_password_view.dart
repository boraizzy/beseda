part of 'forgot_password_imports.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  ForgotPasswordController controller = Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: context.height,
        width: context.width,
        decoration: commonGradiantDecoration(),
        child: SafeArea(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Gap(20),
                CommonAppbar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Gap(20),
                          SvgImageFromAsset(
                            isDarkMode
                                ? CommonImageAssets.darkForgotPassword
                                : CommonImageAssets.forgotPassword,
                          ),
                          Gap(45),
                          authTitleHeader(
                            ForgotPasswordStrings.forgotPasswordTitle,
                          ),
                          Gap(12),
                          authSubTitleHeader(
                            ForgotPasswordStrings.forgotPasswordDes,
                          ),
                          Gap(45),
                          authHeader(AppCommonStrings.email),
                          Gap(10),
                          CommonEmailField(
                            labelText: AppCommonStrings.email,
                            autofillHints: const [AutofillHints.email],
                            controller: controller.emailController,
                            focusNode: controller.emailFocus,
                            textInputAction: TextInputAction.next,
                            validator: validateEmail,
                          ),
                          Gap(40),
                          Obx(() {
                            return controller.isLoading.value
                                ? const Center(child: CommonCircularLoader())
                                : PrimaryButton(
                                    onPressed: () {
                                      controller.submit();
                                    },
                                    label: ForgotPasswordStrings.sendCode,
                                  );
                          }),
                          // PrimaryButton(
                          //   onPressed: () {
                          //   controller.submit();
                          //   },
                          //   label: ForgotPasswordStrings.sendCode,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
