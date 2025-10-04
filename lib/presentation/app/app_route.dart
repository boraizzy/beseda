import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../screens/auth_module/forgot_password/forgot_password_imports.dart';
import '../screens/auth_module/interest_or_subject/interest_imports.dart';
import '../screens/auth_module/learning_goals/learning_goals_imports.dart';
import '../screens/auth_module/onboarding/onboarding_imports.dart';
import '../screens/auth_module/otp_verification_code/otp_verification_imports.dart';
import '../screens/auth_module/profile_set_up/profile_setup_imports.dart';
import '../screens/auth_module/reset_password/reset_password_imports.dart';
import '../screens/auth_module/reset_password_successfully/reset_password_successfully_imports.dart';
import '../screens/auth_module/sign_in/sign_in_imports.dart';
import '../screens/auth_module/sign_up/sign_up_imports.dart';
import '../screens/auth_module/skill_level/skill_level_imports.dart';
import '../screens/auth_module/splash/splash_imports.dart';
import '../screens/bottom_module/bottom_view_imports.dart';
import '../screens/courses_module/completed_test/completed_test_imports.dart';
import '../screens/courses_module/course_certificate/course_certificate_imports.dart';
import '../screens/courses_module/feedback/feedback_imports.dart';
import '../screens/courses_module/feedback_submitted/feedback_submitted_imports.dart';
import '../screens/courses_module/leave_session_confirmation/leave_session_confirmation_imports.dart';
import '../screens/courses_module/meeting_joining/meeting_joining_imports.dart';
import '../screens/courses_module/meeting_permission/meeting_permission_imports.dart';
import '../screens/courses_module/participants_list/participants_list_imports.dart';
import '../screens/courses_module/single_courses/single_courses_imports.dart';
import '../screens/courses_module/start_meeting/start_meeting_imports.dart';
import '../screens/courses_module/summarize_video/summarize_video_imports.dart';
import '../screens/courses_module/text_to_voice/text_to_voice_imports.dart';
import '../screens/courses_module/video_to_text/video_to_text_imports.dart';
import '../screens/courses_module/yet_to_start/yet_to_start_imports.dart';
import '../screens/home_module/ai_chatbot/ai_chatbot_imports.dart';
import '../screens/home_module/ai_learning/ai_learning_imports.dart';
import '../screens/home_module/all_university_list/all_university_imports.dart';
import '../screens/home_module/course_cart/course_cart_imports.dart';
import '../screens/home_module/course_category_detail/course_category_detail_imports.dart';
import '../screens/home_module/course_category_list/course_category_list_view_imports.dart';
import '../screens/home_module/course_checkout/course_checkout_imports.dart';
import '../screens/home_module/course_detail/course_detail_imports.dart';
import '../screens/home_module/course_listing/course_listing_imports.dart';
import '../screens/home_module/edit_profile/edit_profile_imports.dart';
import '../screens/home_module/home/home_imports.dart';
import '../screens/home_module/leader_board/leader_board_imports.dart';
import '../screens/home_module/my_profile/my_profile_imports.dart';
import '../screens/home_module/notification/notification_imports.dart';
import '../screens/home_module/payment_process/payment_imports.dart';
import '../screens/home_module/quiz_list/quiz_list_imports.dart';
import '../screens/home_module/quiz_screen/quiz_imports.dart';
import '../screens/home_module/quiz_submitted/quiz_submitted_imports.dart';
import '../screens/home_module/search/search_screen_imports.dart';
import '../screens/home_module/trainer_profile/trainer_profile_imports.dart';
import '../screens/home_module/university_detail/university_detail_imports.dart';
import '../screens/no_internet_module/no_internet_view_imports.dart';
import '../screens/setting_module/change_password/change_password_view_imports.dart';
import '../screens/setting_module/change_password_successfully/change_password_successfully_imports.dart';
import '../screens/setting_module/contact_us/contact_us_imports.dart';
import '../screens/setting_module/faq/faq_view_imports.dart';
import '../screens/setting_module/language_preference/language_preference_imports.dart';
import '../screens/setting_module/my_downloads/my_downloads_imports.dart';
import '../screens/setting_module/my_progress/my_progress_imports.dart';
import '../screens/setting_module/privacy_policy/privacy_policy_imports.dart';
import '../screens/home_module/course_how_ai_works/level_one_screen.dart' as level;
import '../screens/home_module/course_how_ai_works/part_one_screen.dart' as part1;
import '../screens/home_module/course_how_ai_works/part_two_screen.dart' as part2;
import '../screens/home_module/course_how_ai_works/part_three_screen.dart' as part3;
import '../screens/home_module/course_how_ai_works/part_four_screen.dart' as part4;


class AppRoute {
  AppRoute();

  static List<GetPage>? routes = [
    GetPage(name: AppRouteName.splashView, page: () => const SplashView()),
    GetPage(
      name: AppRouteName.onboardingView,
      page: () => const OnboardingView(),
    ),
    GetPage(name: AppRouteName.signInView, page: () => const SignInView()),
    GetPage(name: AppRouteName.signUpView, page: () => const SignUpView()),
    GetPage(
      name: AppRouteName.forgotPasswordView,
      page: () => const ForgotPasswordView(),
    ),
    GetPage(
      name: AppRouteName.verificationView,
      page: () => const VerificationView(),
    ),
    GetPage(
      name: AppRouteName.resetPasswordView,
      page: () => const ResetPasswordView(),
    ),
    GetPage(
      name: AppRouteName.resetPasswordSuccessfullyView,
      page: () => const ResetPasswordSuccessfullyView(),
    ),
    GetPage(
      name: AppRouteName.profileSetupView,
      page: () => const ProfileSetupView(),
    ),
    GetPage(
      name: AppRouteName.interestSubjectView,
      page: () => const InterestSubjectView(),
    ),
    GetPage(
      name: AppRouteName.learningGoalsView,
      page: () => const LearningGoalsView(),
    ),
    GetPage(
      name: AppRouteName.skillLevelView,
      page: () => const SkillLevelView(),
    ),
    GetPage(name: AppRouteName.bottomView, page: () => const BottomView()),
    GetPage(name: AppRouteName.homeView, page: () => const HomeView()),
    GetPage(
      name: AppRouteName.notificationView,
      page: () => const NotificationView(),
    ),
    GetPage(
      name: AppRouteName.myProfileView,
      page: () => const MyProfileView(),
    ),
    GetPage(
      name: AppRouteName.editProfileView,
      page: () => const EditProfileView(),
    ),
    GetPage(
      name: AppRouteName.searchScreenView,
      page: () => const SearchScreenView(),
    ),
    GetPage(
      name: AppRouteName.courseCategoryListView,
      page: () => const CourseCategoryListView(),
    ),
    GetPage(
      name: AppRouteName.courseCategoryDetailView,
      page: () => const CourseCategoryDetailView(),
    ),
    GetPage(
      name: AppRouteName.courseListingView,
      page: () => const CourseListingView(),
    ),
    GetPage(
      name: AppRouteName.courseDetailView,
      page: () => const CourseDetailView(),
    ),
    GetPage(
      name: AppRouteName.courseCartView,
      page: () => const CourseCartView(),
    ),
    GetPage(
      name: AppRouteName.courseCheckoutView,
      page: () => const CourseCheckoutView(),
    ),
    GetPage(name: AppRouteName.paymentView, page: () => const PaymentView()),
    GetPage(
      name: AppRouteName.trainerProfileView,
      page: () => const TrainerProfileView(),
    ),
    GetPage(
      name: AppRouteName.allUniversityListView,
      page: () => const AllUniversityListView(),
    ),
    GetPage(
      name: AppRouteName.universityDetailView,
      page: () => const UniversityDetailView(),
    ),
    GetPage(name: AppRouteName.quizListView, page: () => const QuizListView()),
    GetPage(name: AppRouteName.quizView, page: () => const QuizView()),
    GetPage(
      name: AppRouteName.quizSubmittedView,
      page: () => const QuizSubmittedView(),
    ),
    GetPage(
      name: AppRouteName.leaderBoardView,
      page: () => const LeaderBoardView(),
    ),
    GetPage(
      name: AppRouteName.aiLearningView,
      page: () => const AiLearningView(),
    ),
    GetPage(
      name: AppRouteName.aiChatbotView,
      page: () => const AiChatbotView(),
    ),
    GetPage(
      name: AppRouteName.singleCoursesView,
      page: () => const SingleCoursesView(),
    ),
    GetPage(
      name: AppRouteName.summarizeVideoView,
      page: () => const SummarizeVideoView(),
    ),
    GetPage(
      name: AppRouteName.videoToTextView,
      page: () => const VideoToTextView(),
    ),
    GetPage(
      name: AppRouteName.completedTestView,
      page: () => const CompletedTestView(),
    ),
    GetPage(
      name: AppRouteName.textToVoiceView,
      page: () => const TextToVoiceView(),
    ),
    GetPage(name: AppRouteName.feedbackView, page: () => const FeedbackView()),
    GetPage(
      name: AppRouteName.feedbackSubmittedView,
      page: () => const FeedbackSubmittedView(),
    ),
    GetPage(
      name: AppRouteName.courseCertificateView,
      page: () => const CourseCertificateView(),
    ),
    GetPage(
      name: AppRouteName.meetingPermissionView,
      page: () => const MeetingPermissionView(),
    ),
    GetPage(
      name: AppRouteName.meetingJoiningView,
      page: () => const MeetingJoiningView(),
    ),
    GetPage(
      name: AppRouteName.yetToStartView,
      page: () => const YetToStartView(),
    ),
    GetPage(
      name: AppRouteName.startMeetingView,
      page: () => const StartMeetingView(),
    ),
    GetPage(
      name: AppRouteName.participantsListView,
      page: () => const ParticipantsListView(),
    ),
    GetPage(
      name: AppRouteName.leaveSessionConfirmationView,
      page: () => const LeaveSessionConfirmationView(),
    ),
    GetPage(
      name: AppRouteName.myDownloadsView,
      page: () => const MyDownloadsView(),
    ),
    GetPage(
      name: AppRouteName.languagePreferenceView,
      page: () => const LanguagePreferenceView(),
    ),
    GetPage(
      name: AppRouteName.changePasswordView,
      page: () => const ChangePasswordView(),
    ),
    GetPage(
      name: AppRouteName.changePasswordSuccessfullyView,
      page: () => const ChangePasswordSuccessfullyView(),
    ),
    GetPage(name: AppRouteName.faqView, page: () => const FaqView()),
    GetPage(
      name: AppRouteName.contactUsView,
      page: () => const ContactUsView(),
    ),
    GetPage(
      name: AppRouteName.privacyPolicyView,
      page: () => const PrivacyPolicyView(),
    ),
    GetPage(
      name: AppRouteName.myProgressView,
      page: () => const MyProgressView(),
    ),
    GetPage(
      name: AppRouteName.noInternetView,
      page: () => const NoInternetView(),
    ),

    GetPage(name: AppRouteName.levelOneScreen, page: () => const level.LevelOneScreen()),
    GetPage(name: AppRouteName.partOneScreen, page: () => const part1.PartOneScreen()),
    GetPage(name: AppRouteName.partTwoScreen, page: () => const part2.PartTwoScreen()),
    GetPage(name: AppRouteName.partThreeScreen, page: () => const part3.PartThreeScreen()),
    GetPage(name: AppRouteName.partFourScreen, page: () => const part4.PartFourScreen()),
  ];
}

class AppRouteName extends AppRoute {
  static const levelOneScreen = "/levelOneScreen";
  static const partOneScreen = "/partOneScreen";
  static const partTwoScreen = "/partTwoScreen";
  static const partThreeScreen = "/partThreeScreen";
  static const partFourScreen = "/partFourScreen";
  static const String splashView = "/";
  static const String onboardingView = "/OnboardingView";
  static const String signInView = "/signInView";
  static const String signUpView = "/signUp";
  static const String forgotPasswordView = "/forgotPasswordView";
  static const String verificationView = "/verificationView";
  static const String resetPasswordView = "/resetPasswordView";
  static const String resetPasswordSuccessfullyView =
      "/resetPasswordSuccessfullyView";
  static const String profileSetupView = "/profileSetupView";
  static const String interestSubjectView = "/interestSubjectView";
  static const String learningGoalsView = "/learningGoalsView";
  static const String skillLevelView = "/skillLevelView";
  static const String bottomView = "/bottomView";
  static const String homeView = "/homeView";
  static const String notificationView = "/notificationView";
  static const String myProfileView = "/myProfileView";
  static const String editProfileView = "/editProfileView";
  static const String searchScreenView = "/searchScreenView";
  static const String courseCategoryListView = "/courseCategoryListView";
  static const String courseCategoryDetailView = "/courseCategoryDetailView";
  static const String courseListingView = "/courseListingView";
  static const String courseDetailView = "/courseDetailView";
  static const String courseCartView = "/courseCartView";
  static const String courseCheckoutView = "/courseCheckoutView";
  static const String paymentView = "/paymentView";
  static const String trainerProfileView = "/trainerProfileView";
  static const String allUniversityListView = "/allUniversityListView";
  static const String universityDetailView = "/universityDetailView";
  static const String quizListView = "/quizListView";
  static const String quizView = "/quizView";
  static const String quizSubmittedView = "/quizSubmittedView";
  static const String leaderBoardView = "/leaderBoardView";
  static const String aiLearningView = "/aiLearningView";
  static const String aiChatbotView = "/aiChatbotView";
  static const String singleCoursesView = "/singleCoursesView";
  static const String summarizeVideoView = "/summarizeVideoView";
  static const String videoToTextView = "/videoToTextView";
  static const String completedTestView = "/completedTestView";
  static const String textToVoiceView = "/textToVoiceView";
  static const String feedbackView = "/feedbackView";
  static const String feedbackSubmittedView = "/feedbackSubmittedView";
  static const String courseCertificateView = "/courseCertificateView";
  static const String meetingPermissionView = "/meetingPermissionView";
  static const String meetingJoiningView = "/meetingJoiningView";
  static const String yetToStartView = "/yetToStartView";
  static const String startMeetingView = "/startMeetingView";
  static const String participantsListView = "/participantsListView";
  static const String leaveSessionConfirmationView =
      "/leaveSessionConfirmationView";
  static const String myDownloadsView = "/myDownloadsView";
  static const String languagePreferenceView = "/languagePreferenceView";
  static const String changePasswordView = "/changePasswordView";
  static const String changePasswordSuccessfullyView =
      "/changePasswordSuccessfullyView";
  static const String faqView = "/faqView";
  static const String contactUsView = "/contactUsView";
  static const String privacyPolicyView = "/privacyPolicyView";
  static const String myProgressView = "/myProgressView";
  static const String noInternetView = "/noInternetView";
}
