import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../app/theme_controller.dart';
import '../widgets/icon.dart';
import '../widgets/text.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isAvailableSwitch;
  final VoidCallback? onPressedBack;
  final String? title;
  final Widget? actionWidget;
  final Widget? actionWidget2;
  final Widget? actionWidget3;
  final PreferredSizeWidget? bottomWidget;

   CommonAppbar({
    super.key,
    this.title,
    this.isAvailableSwitch = false,
    this.onPressedBack,
    this.actionWidget,
    this.bottomWidget,
    this.actionWidget2,
    this.actionWidget3,
  });
  final bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: BackIcon(
        onPressed:
            onPressedBack ??
            () {
              Get.back();
            },
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      //leadingWidth: 30,
      centerTitle: false,
      title: CommonText.semiBold(title ?? "", size: 18),
      bottom: bottomWidget,
      actions: [
        if (actionWidget != null) actionWidget!,
        if (actionWidget2 != null) actionWidget2!,
        if (actionWidget3 != null) actionWidget3!,
        isAvailableSwitch
            ? Obx(
                () => Switch(
                  value: Get.find<ThemeController>().isDarkMode,
                  onChanged: (bool value) {
                    Get.find<ThemeController>().toggleTheme();
                    Get.forceAppUpdate();
                  },
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(40);
}
