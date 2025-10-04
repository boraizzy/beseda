import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'utils/flutter_web_frame/flutter_web_frame.dart';
import 'utils/helpers/connectivity_helper.dart';
import 'presentation/app/app.dart';
import 'presentation/app/bootstrap.dart';
import 'package:education_app/presentation/screens/wishlist_module/controller/wishlist_controller.dart';
import 'presentation/screens/courses_module/my_courses/controller/my_courses_controller.dart';
void main() {
  bootstrap(() async {
    Get.put(WishlistController(), permanent: true);
    // ✅ Initialize Firebase here
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    Get.put(MyCoursesController(), permanent: true);

    final ConnectivityHelper connectivityHelper = ConnectivityHelper();

    return FlutterWebFrame(
      maximumSize: const Size(475.0, 812.0),
      enabled: kIsWeb,
      builder: (context) {
        return Observer(
          builder: (_) => EducationApp(connectivityHelper: connectivityHelper),
        );
      },
    );
  });
}
