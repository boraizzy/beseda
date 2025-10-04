part of 'edit_profile_imports.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  EditProfileController controller = Get.put(EditProfileController());
  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 20;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                CommonAppbar(title: EditProfileViewStrings.editProfile),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: horizontalSpacing,
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(30),
                            Align(
                              alignment: Alignment.center,
                              child: Obx(() {
                                return controller.selectedImagePath.value == ''
                                    ? SvgImageFromAsset(
                                        CommonImageAssets.userProfileImg,
                                        height: 72,
                                        width: 72,
                                      )
                                    : CircleAvatar(
                                        radius: 33,
                                        backgroundImage: FileImage(
                                          File(
                                            controller.selectedImagePath.value,
                                          ),
                                        ),
                                      );
                              }),
                            ),
                            Gap(15),
                            Obx(
                              () =>  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      commonDialog(
                                        context: context,
                                        view: pickDocumentDialog(
                                          cameraOnTap: () {
                                            controller.pickImage(
                                              ImageSource.camera,
                                            );
                                            Get.back();
                                          },
                                          galleryTap: () {
                                            controller.pickImage(
                                              ImageSource.gallery,
                                            );
                                            Get.back();
                                          },
                                          fileOnTap: () {
                                            controller.pickImage(
                                              ImageSource.gallery,
                                            );
                                            Get.back();
                                          },
                                        ),
                                      );
                                    },
                                    child: SvgImageFromAsset(
                                      AppCommonIcon.editProfileIcon,
                                    ),
                                  ),
                                  Gap(controller.selectedImagePath.value == ''?0:20),
                                  controller.selectedImagePath.value == ''?SizedBox():
                                  InkWell(
                                    onTap: () {
                                      showDeleteConfirmationDialog(
                                        context,
                                            () {
                                          controller
                                              .selectedImagePath
                                              .value =
                                          "";
                                          showSuccessMessage(
                                            context: context,
                                            title: EditProfileViewStrings
                                                .profileRemoveSuccessfully,
                                            content: '',
                                          );
                                          Get.back();
                                        },
                                      );
                                    },
                                    child: SvgImageFromAsset(
                                      AppCommonIcon.deleteProfileIcon,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(30),
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
                              textInputAction: TextInputAction.done,
                              validator: validateEmail,
                            ),

                            Gap(25),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() {
                  return controller.isLoading.value
                      ? const Center(child: CommonCircularLoader())
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: horizontalSpacing,
                          ),
                          child: PrimaryButton(
                            onPressed: () {
                              controller.submit();
                            },
                            label: EditProfileViewStrings.updateProfile,
                          ),
                        );
                }),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: horizontalSpacing,
                //   ),
                //   child: PrimaryButton(
                //     onPressed: () {
                //       controller.submit();
                //     },
                //     label: EditProfileViewStrings.updateProfile,
                //   ),
                // ),
                Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
