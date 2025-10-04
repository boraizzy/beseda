part of 'profile_setup_imports.dart';

class ProfileSetupView extends StatefulWidget {
  const ProfileSetupView({super.key});

  @override
  State<ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends State<ProfileSetupView> {
  ProfileSetupController controller = Get.put(ProfileSetupController());

  final bioController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;

    return Scaffold(
      appBar: AppBar(title: const Text("Настройка на профил")),
      body: Container(
        height: context.height,
        width: context.width,
        decoration: commonGradiantDecoration(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: ProfileSetUpStrings.lets,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  color: isDarkMode
                      ? AppColors.white
                      : AppColors.headingsColor,
                ),
                children: [
                  const WidgetSpan(child: SizedBox(width: 5)),
                  TextSpan(
                    text: ProfileSetUpStrings.personalised,
                    style: TextStyle(
                      color: AppColors.primary500,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(width: 5)),
                  TextSpan(
                    text: ProfileSetUpStrings.personalisedDes,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: isDarkMode
                          ? AppColors.white
                          : AppColors.headingsColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // ✅ Bio input
            TextField(
              controller: bioController,
              decoration: const InputDecoration(
                labelText: "Биография",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Age input
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Години",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Save button
            ElevatedButton(
              onPressed: () async {
                await controller.saveProfile(
                  bio: bioController.text.trim(),
                  age: ageController.text.trim(),
                );

                Get.offNamed(AppRouteName.interestSubjectView);
              },
              child: const Text("Запази и продължи"),
            ),
          ],
        ),
      ),
    );
  }
}
