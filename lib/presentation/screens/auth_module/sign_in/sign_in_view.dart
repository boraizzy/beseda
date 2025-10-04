part of 'sign_in_imports.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  SignInController controller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;

    const double verticalSpacing = 20;
    const double horizontalSpacing = 20;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: context.height,
        width: context.width,
        decoration: commonGradiantDecoration(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalSpacing,
                      vertical: verticalSpacing,
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(45),
                          authTitleHeader(SignInStrings.welcomeBack),
                          Gap(10),
                          authSubTitleHeader(SignInStrings.enterCredentials),
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
                          Gap(25),
                          authHeader(AppCommonStrings.password),
                          Gap(10),
                          CommonPasswordField(
                            labelText: AppCommonStrings.password,
                            autofillHints: const [AutofillHints.password],
                            controller: controller.passwordController,
                            focusNode: controller.passwordFocus,
                            textInputAction: TextInputAction.done,
                            validator: validatePassword,
                            hintText: SignInStrings.enterPassword,
                            onChange: (String? value) {},
                          ),
                          Gap(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(
                                () => SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Checkbox(
                                    value: controller.isRememberMe.value,
                                    onChanged: (value) {
                                      controller.isRememberMe.value = value!;
                                    },
                                  ),
                                ),
                              ),
                              Gap(5),
                              authSubTitleHeader(SignInStrings.rememberMe),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppRouteName.forgotPasswordView);

                                },
                                child: CommonText.medium(
                                  SignInStrings.forGotPassword,
                                  size: 14,
                                  height: 1.0,
                                  letterSpacing: 0.0,
                                  textAlign: TextAlign.center,
                                  color: AppColors.error500,
                                ),
                              ),
                            ],
                          ),
                          Gap(30),
                          Obx(() {
                            return controller.isLoading.value
                                ? const Center(child: CommonCircularLoader())
                                : PrimaryButton(
                              onPressed: () {
                                controller.submit();
                              },
                              label: AppCommonStrings.btnSignIn,
                            );
                          }),

                          Gap(30),
                          dividerWithText(),
                          Gap(30),
                          SocialButtonWithTitle(
                            icon: AppCommonIcon.googleIcon,
                            title: SignInStrings.loginWithGoogle,
                            onPressed: () {},
                          ),
                          Gap(10),
                          SocialButtonWithTitle(
                            icon: AppCommonIcon.appleIcon,
                            title: SignInStrings.loginWithApple,
                            colorFilter: ColorFilter.mode(isDarkMode?AppColors.white:AppColors.black, BlendMode.srcIn),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Gap(10),
              commonAuthBottomText(
                SignInStrings.doNotHaveAnAccount,
                AppCommonStrings.btnSignUp,
                () {
                  Get.offNamed(AppRouteName.signUpView);
                },
              ),
              Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
