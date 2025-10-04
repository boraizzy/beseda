part of 'sign_up_imports.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  SignUpController controller = Get.put(SignUpController());

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
        // decoration: BoxDecoration(
        //   gradient: AppCommonGradient.backgroundGradient,
        // ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalSpacing,
                      vertical: verticalSpacing,
                    ),
                    child: AutofillGroup(
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(45),
                            authTitleHeader(
                              SignUpStrings.startYourLearningJourney,
                            ),
                            Gap(10),
                            authSubTitleHeader(SignUpStrings.enterBelowDetail),
                            Gap(45),
                            authHeader(SignUpStrings.name),
                            Gap(10),
                            CommonTextField(
                              autofillHints: const [AutofillHints.name],
                              controller: controller.nameController,
                              focusNode: controller.nameFocus,
                              textInputAction: TextInputAction.next,
                              hintText: SignUpStrings.enterName,
                              validator: validateFullName,
                              prefixIcon: SvgImageFromAsset(
                                AppCommonIcon.userIcon,
                                height: 18,
                                width: 18,
                              ),
                            ),
                            Gap(25),

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
                            authHeader(SignUpStrings.phoneNumber),
                            Gap(10),
                            CommonMobileField(
                              hintText: SignUpStrings.enterMobileNo,
                              focusNode: controller.phoneNoFocus,
                            ),

                            Gap(25),
                            authHeader(AppCommonStrings.password),
                            Gap(10),
                            CommonPasswordField(
                              labelText: AppCommonStrings.password,
                              autofillHints: const [AutofillHints.password],
                              controller: controller.passwordController,
                              focusNode: controller.passwordFocus,
                              textInputAction: TextInputAction.next,
                              validator: validatePassword,
                              hintText: SignInStrings.enterPassword,
                              onChange: (String? value) {},
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),

                            Gap(25),
                            authHeader(SignUpStrings.confirmPassword),
                            Gap(10),
                            CommonPasswordField(
                              autofillHints: const [AutofillHints.password],
                              controller: controller.confirmPasswordController,
                              focusNode: controller.confirmPasswordFocus,
                              textInputAction: TextInputAction.done,

                              hintText: SignUpStrings.enterConfirmPassword,
                              onChange: (String? value) {},
                              validator: (value) => validateConfirmPassword(
                                value,
                                controller.passwordController.text,
                              ),
                            ),

                            Gap(30),
                            Obx(() {
                              return controller.isLoading.value
                                  ? const Center(child: CommonCircularLoader())
                                  : PrimaryButton(
                                onPressed: () {
                                  controller.submit();
                                },
                                label: AppCommonStrings.btnSignUp,
                              );
                            }),
                            // PrimaryButton(
                            //   onPressed: () {
                            //     controller.submit();
                            //   },
                            //   label: AppCommonStrings.btnSignUp,
                            // ),
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
              ),
              Gap(10),
              commonAuthBottomText(
                SignUpStrings.alreadyHaveAnAccount,
                AppCommonStrings.btnSignIn,
                () {
                  Get.offNamed(AppRouteName.signInView);
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
