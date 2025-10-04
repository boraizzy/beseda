part of 'contact_us_imports.dart';
class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  ContactUsController controller = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 20;
    bool isDarkMode = Get
        .find<ThemeController>()
        .isDarkMode;
    return Scaffold(
      body: Container(
        height: context.height,
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? AppCommonGradient.mainDarkBackgroundGradient
              : AppCommonGradient.mainBackgroundGradient,
        ), // 👈 only closes BoxDecoration
        child: SafeArea(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonAppbar(title: SettingString.contactUs),
                Gap(20),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalSpacing),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonHeader(ContactUsString.firstName),
                        Gap(12),
                        CommonTextField(
                          autofillHints: const [AutofillHints.name],
                          controller: controller.fNameController,
                          focusNode: controller.fNameFocus,
                          textInputAction: TextInputAction.next,
                          hintText: ContactUsString.enterFirstName,
                          validator: validateFirstName,
                          prefixIcon: SvgImageFromAsset(
                            AppCommonIcon.userIcon,
                            height: 18,
                            width: 18,
                          ),
                        ),
                        Gap(20),

                        commonHeader(ContactUsString.lastName),
                        Gap(12),
                        CommonTextField(
                          autofillHints: const [AutofillHints.name],
                          controller: controller.lNameController,
                          focusNode: controller.lNameFocus,
                          textInputAction: TextInputAction.next,
                          hintText: ContactUsString.enterLastName,
                          validator: validateLastName,
                          prefixIcon: SvgImageFromAsset(
                            AppCommonIcon.userIcon,
                            height: 18,
                            width: 18,
                          ),
                        ),
                        Gap(20),

                        authHeader(AppCommonStrings.email),
                        Gap(12),
                        CommonEmailField(
                          labelText: AppCommonStrings.email,
                          autofillHints: const [AutofillHints.email],
                          controller: controller.emailController,
                          focusNode: controller.emailFocus,
                          textInputAction: TextInputAction.next,
                          validator: validateEmail,
                        ),
                        Gap(20),

                        authHeader(SignUpStrings.phoneNumber),
                        Gap(10),
                        CommonMobileField(
                          hintText: SignUpStrings.enterMobileNo,
                          controller: controller.phoneNoController,
                          focusNode: controller.phoneNoFocus,
                        ),
                        Gap(20),

                        commonHeader(ContactUsString.message),
                        Gap(12),
                        CommonTextField(
                          controller: controller.messageController,
                          focusNode: controller.messageFocus,
                          textInputAction: TextInputAction.done,
                          hintText: FeedbackStrings.shareYourThoughts,
                          maxLines: 5,
                        ),
                        Gap(20),
                      ],
                    ),
                  ),
                ),
                Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: horizontalSpacing),
                  child: PrimaryButton(
                    onPressed: () => controller.submit(),
                    label: ContactUsString.sendMessage,
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

