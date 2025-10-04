part of 'change_password_view_imports.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  ChangePasswordController controller = Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 20;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
              CommonAppbar(title: SettingString.changePassword),
              Gap(20),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalSpacing,
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          authHeader(ChangePasswordString.currentPassword),
                          Gap(10),
                          CommonPasswordField(
                            labelText: '',
                            autofillHints: const [AutofillHints.password],
                            controller: controller.currentPasswordController,
                            focusNode: controller.currentPasswordFocus,
                            textInputAction: TextInputAction.next,
                            validator: validatePassword,
                            hintText: ChangePasswordString.enterCurrentPassword,
                            onChange: (String? value) {},
                            fillColor: Colors.transparent,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                          ),

                          Gap(25),
                          authHeader(ResetPasswordStrings.newPassword),
                          Gap(10),
                          CommonPasswordField(
                            labelText: '',
                            autofillHints: const [AutofillHints.password],
                            controller: controller.passwordController,
                            focusNode: controller.passwordFocus,
                            textInputAction: TextInputAction.next,
                            validator: validatePassword,
                            hintText: ChangePasswordString.enterNewPassword,
                            fillColor: Colors.transparent,
                            onChange: (String? value) {},
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                          ),

                          Gap(25),
                          authHeader(ChangePasswordString.confirmNewPassword),
                          Gap(10),
                          CommonPasswordField(
                            autofillHints: const [AutofillHints.password],
                            controller: controller.confirmPasswordController,
                            focusNode: controller.confirmPasswordFocus,
                            textInputAction: TextInputAction.done,
                            hintText: ChangePasswordString.confirmNewPassword,
                            onChange: (String? value) {},
                            fillColor: Colors.transparent,
                            validator: (value) => validateConfirmPassword(
                              value,
                              controller.passwordController.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalSpacing,
                ),
                child: PrimaryButton(
                  onPressed: () {
                    controller.submit(context);
                  },
                  label: SettingString.changePassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
