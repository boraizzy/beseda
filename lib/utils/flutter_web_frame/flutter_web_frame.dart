
import 'package:education_app/core/constants/app_colors.dart';
import 'package:education_app/core/constants/app_strings.dart';
import 'package:education_app/core/themes/app_themes.dart';
import 'package:education_app/presentation/app/app_route.dart';
import 'package:education_app/presentation/app/theme_controller.dart';
import 'package:education_app/presentation/common_widgets/widgets/button.dart';
import 'package:education_app/presentation/common_widgets/widgets/common_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'src/frame_content.dart';
import 'src/media_query_observer.dart';

class FlutterWebFrame extends StatefulWidget {
  /// If not [enabled], the [child] is used directly.
  final bool enabled;

  /// The previewed widget.
  ///
  /// It is common to give the root application widget.
  final WidgetBuilder builder;

  /// Background color in white space
  final Color? backgroundColor;

  /// Maximum size
  final Size maximumSize;

  /// Clip behavior
  final Clip clipBehavior;

  const FlutterWebFrame({
    super.key,
    required this.builder,
    this.enabled = true,
    this.backgroundColor,
    required this.maximumSize,
    this.clipBehavior = Clip.none,
  });

  /// A global builder that should be inserted into [WidgetApp]'s builder
  /// to simulated the simulated device screen and platform properties.
  static Widget appBuilder(BuildContext context, Widget? widget) {
    if (!_isEnabled(context)) {
      return widget ?? const SizedBox();
    }

    if (!_isEnabled(context)) return widget ?? const SizedBox();

    return MediaQuery(
      data: _mediaQuery(context),
      child: Theme(
        data: Theme.of(context).copyWith(
          visualDensity: _isEnabled(context) ? VisualDensity.standard : null,
        ),
        child: widget ?? const SizedBox(),
      ),
    );
  }

  static MediaQueryData _mediaQuery(BuildContext context) {
    return FrameContent.mediaQuery(
      context,
      context
              .findAncestorStateOfType<FlutterWebFrameState>()
              ?.widget
              .maximumSize ??
          const Size(375.0, 812.0),
    );
  }

  static bool _isEnabled(BuildContext context) {
    final state = context.findAncestorStateOfType<FlutterWebFrameState>();
    return state != null && state.widget.enabled;
  }

  @override
  FlutterWebFrameState createState() => FlutterWebFrameState();
}

class FlutterWebFrameState extends State<FlutterWebFrame> {
  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return Builder(builder: widget.builder);
    }

    return Container(
      color: widget.backgroundColor ?? Theme.of(context).dividerColor,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: MediaQueryObserver(
          child:
              widget.enabled
                  ? Builder(builder: _buildPreview)
                  : Builder(builder: widget.builder),
        ),
      ),
    );
  }

  Widget _buildPreview(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FittedBox(
      fit: BoxFit.contain,
      child: RepaintBoundary(
        child: FrameContent(
          size: widget.maximumSize,
          clipBehavior: widget.clipBehavior,
          headerSection: Observer(
            builder: (context) {
              return GetBuilder<ThemeController>(
                init: ThemeController(),
                builder: (themeController) {
                  return Obx(
                    () => Container(
                      width: 475.0,
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      color:
                          themeController.isDarkMode
                              ? AppColors.black
                              : AppColors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            textDirection: TextDirection.ltr,
                            children: [
                              /*  Container(
                                      // padding: const EdgeInsets.all(4),
                                      height: 40,
                                      width: 40,
                                      child: SvgPicture.asset(
                                          logo,
                                          height: 28,
                                          width: 28,
                                          fit: BoxFit.contain)),*/
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding: WidgetStatePropertyAll(
                                      EdgeInsets.zero,
                                    ),
                                    overlayColor: WidgetStateProperty.all(Colors.transparent), // No splash
                                    splashFactory: NoSplash.splashFactory, // No ripple animation
                                  ),
                                  onPressed: () {
                                    Get.offNamedUntil(
                                      AppRouteName.onboardingView,
                                      (route) => false,
                                    );
                                    // finish(context);
                                    // commonLaunchUrl(MainSiteUrl);
                                  },
                                  child: Text(
                                    AppStrings.appName,
                                    style: TextStyle(
                                      fontFamily: AppTheme.defaultFontFamily,
                                      letterSpacing: 0.8,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          themeController.isDarkMode
                                              ? Colors.white
                                              : AppColors.black,
                                    ),
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: SizedBox(
                                  width: 120,
                                  child: PrimaryButton(
                                    width: 120,
                                    height: 35,
                                    backgroundColor: AppColors.primary500,
                                    borderRadius: 8,
                                    onPressed: () {
                                     /* commonLaunchUrl(
                                        "https://codecanyon.net/item/epic-eats-flutter-food-delivery-restaurant-booking-ui-kit/59325861",
                                      );*/
                                    },
                                    label: 'Buy Now',
                                  ),
                                ),
                              ),
                            ],
                          ).paddingOnly(left: 8, right: 8),
                          CommonDivider(
                            height: 0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          footerSection: Observer(
            builder: (context) {
              return GetBuilder<ThemeController>(
                init: ThemeController(),
                builder: (themeController) {
                  return Obx(
                    () => Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 1,
                            color: Colors.grey.withValues(alpha: 0.2),
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                        color:
                            themeController.isDarkMode
                                ? AppColors.black
                                : AppColors.white,
                      ),
                      width: 475.0,
                      child: Column(
                        children: [
                          Divider(
                            height: 0,
                          ),
                          Text(
                            'Copyright © 2025. Crafted with passion by Imperia Themes.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color:
                                  themeController.isDarkMode
                                      ? AppColors.greyTextDarkColor
                                      : AppColors.greyTextColor,
                            ),
                            textDirection: TextDirection.ltr,
                          ).paddingAll(12),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          child: Builder(builder: widget.builder),
        ),
      ),
    );
  }
}

Future<bool> commonLaunchUrl(
  String address, {
  LaunchMode launchMode = LaunchMode.inAppWebView,
}) async {
  try {
    await launchUrl(Uri.parse(address), mode: launchMode);
    return true; // Success
  } catch (e) {
    Get.snackbar('Error', 'Failed to launch URL: $address');
    return false; // Error
  }
}
