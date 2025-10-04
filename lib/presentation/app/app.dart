
import 'dart:async';

import 'package:education_app/presentation/app/theme_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helpers/connectivity_helper.dart';
import '../../core/themes/app_themes.dart';
import '../common_widgets/view_common_widget/route_observer.dart';

import 'app_route.dart';

class EducationApp extends StatefulWidget {
  final ConnectivityHelper connectivityHelper;

  const EducationApp({super.key, required this.connectivityHelper});

  @override
  State<EducationApp> createState() => _EducationAppState();
}

class _EducationAppState extends State<EducationApp> {
  final themeController = Get.put(ThemeController());
  final RxBool hasInternet = true.obs;

  late StreamSubscription internetSub;
  @override
  void initState() {
    //widget.connectivityHelper.initialize() ;
    super.initState();
    widget.connectivityHelper.initialize();

    internetSub = widget.connectivityHelper.onConnectivityChanged.listen((connected) {
      hasInternet.value = connected;
      if (!connected) {

        Get.toNamed(AppRouteName.noInternetView,);
      } else {
        Get.back();
      }
    });
    // initFirebase();
  }

  @override
  void dispose() {
    widget.connectivityHelper.dispose();
    internetSub.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: MediaQuery.of(
            context,
          ).textScaler.clamp(minScaleFactor: 1.0, maxScaleFactor: 1.0),
        ),
        child: GetMaterialApp(
          navigatorObservers: [routeObserver],
          debugShowCheckedModeBanner: false,
          themeMode: themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          initialRoute: AppRouteName.splashView,
          //initialRoute: AppRouteName.bottomView,

          getPages: AppRoute.routes,
          builder: (context, child) {
            themeController.updateStatusBarColor(context);
            return child!;
          },
        ),
      ),
    );
  }
}
