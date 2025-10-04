import 'package:education_app/core/constants/app_colors.dart';
import 'package:get/get.dart';
import '../model/subject_model.dart';

class InterestSubjectController extends GetxController {
  final RxList selectedSubjects = [].obs;

  void toggleSelection(String subject) {
    if (selectedSubjects.contains(subject)) {
      selectedSubjects.remove(subject);
    } else {
      selectedSubjects.add(subject);
    }
  }

  final List<Subject> subjects = [
    Subject(
      name: 'Art & Design',
      color: AppColors.secondary500,
      width: 98,
      height: 98,
      bgColor: AppColors.secondary50,
    ),
    Subject(
      name: 'Economics',
      color: AppColors.success500,
      width: 103,
      height: 103,
      bgColor: AppColors.success50,
    ),
    Subject(
      name: 'Gujarati',
      color: AppColors.success500,
      width: 78,
      height: 78,
      bgColor: AppColors.success50,
    ),
    Subject(
      name: 'Maths',
      color: AppColors.error500,
      width: 78,
      height: 78,
      bgColor: AppColors.error50,
    ),
    Subject(
      name: 'UI & UX',
      color: AppColors.success500,
      width: 78,
      height: 78,
      bgColor: AppColors.success50,
    ),
    Subject(
      name: 'Hindi',
      color: AppColors.error500,
      width: 78,
      height: 78,
      bgColor: AppColors.error50,
    ),
    Subject(
      name: 'Marketing',
      color: AppColors.secondary500,
      width: 85,
      height: 85,
      bgColor: AppColors.secondary50,
    ),
    Subject(
      name: 'English',
      color: AppColors.secondary500,
      width: 78,
      height: 78,
      bgColor: AppColors.secondary50,
    ),
    Subject(
      name: 'Accounting',
      color: AppColors.error500,
      width: 104,
      height: 104,
      bgColor: AppColors.error50,
    ),
    Subject(
      name: 'Business',
      color: AppColors.secondary500,
      width: 88,
      height: 88,
      bgColor: AppColors.secondary50,
    ),
    Subject(
      name: 'Animation',
      color: AppColors.success500,
      width: 94,
      height: 94,
      bgColor: AppColors.success50,
    ),
    Subject(
      name: 'Video Editing',
      color: AppColors.success500,
      width: 98,
      height: 98,
      bgColor: AppColors.success50,
    ),
    Subject(
      name: 'Finance',
      color: AppColors.success500,
      width: 110,
      height: 110,
      bgColor: AppColors.success50,
    ),
    Subject(
      name: 'Data Science',
      color: AppColors.error500,
      width: 98,
      height: 98,
      bgColor: AppColors.error50,
    ),
    Subject(
      name: 'Cyber Security',
      color: AppColors.secondary500,
      width: 98,
      height: 98,
      bgColor: AppColors.secondary50,
    ),
  ];
}
