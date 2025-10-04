import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../app/theme_controller.dart';


class PrivacyPolicyController extends GetxController {
  late WebViewController webViewController;
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController();
    initWebView();
  }

  Future<void> initWebView() async {
    String fileText = await rootBundle.loadString("assets/json/privacy_policy.html");

    String headingColor = isDarkMode ? "#9CA3AF" : "#6B7280";
    String paragraphColor = isDarkMode? "#E5E7EB" : "#1F2937";


    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..loadRequest(Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            webViewController.runJavaScript(
                "document.documentElement.style.setProperty('--heading-color', '$headingColor');"
                    "document.documentElement.style.setProperty('--paragraph-color', '$paragraphColor');"

            );
          },
        ),
      );
  }
}
