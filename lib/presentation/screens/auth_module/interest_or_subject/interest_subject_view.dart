part of 'interest_imports.dart';

class InterestSubjectView extends StatefulWidget {
  const InterestSubjectView({super.key});

  @override
  InterestSubjectViewState createState() => InterestSubjectViewState();
}

class InterestSubjectViewState extends State<InterestSubjectView> {
  InterestSubjectController controller = Get.put(InterestSubjectController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:commonCardDecoration(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                child: BackIcon(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Gap(15),
                      Align(
                        alignment: Alignment.center,
                        child: CommonText.semiBold(
                          InterestOrSubjectStrings.whatWouldYouLike,
                          size: 24,
                          textAlign: TextAlign.center,

                        ),
                      ),
                      Gap(40),
                      Center(
                          child: Obx(
                            () => Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 16,
                              runSpacing: 10,
                              children: controller.subjects.map((subject) {
                                final isSelected = controller.selectedSubjects.contains(
                                  subject.name,
                                );
                                return GestureDetector(
                                  onTap: () {
                                    if (isSelected) {
                                      controller.selectedSubjects.remove(subject.name);
                                    } else {
                                      controller.selectedSubjects.add(subject.name);
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: subject.width,
                                    height: subject.height,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:  isSelected
                                          ? AppColors.primary50
                                          :subject.bgColor,
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.primary500
                                            : subject.color,
                                        width: 2,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(8),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        isSelected?SvgImageFromAsset(CommonImageAssets.selectedSubject):SizedBox.shrink(),
                                        CommonText.medium(
                                          subject.name,
                                          size: 14,
                                          textAlign: TextAlign.center,
                                          color: subject.color,
                                        ),
                                      ],
                                    )



                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                      Gap(25),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PrimaryButton(
                  onPressed: () {
                    Get.toNamed(AppRouteName.learningGoalsView);
                  },
                  label: AppCommonStrings.btnNext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

