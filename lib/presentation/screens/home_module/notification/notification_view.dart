part of 'notification_imports.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  NotificationController controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;

    return Scaffold(
      body: Container(
        height: context.height,
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? AppCommonGradient.mainDarkBackgroundGradient
              : AppCommonGradient.mainBackgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonAppbar(
                title: NotificationViewStrings.notification,
                actionWidget3: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      controller.notificationList.clear();
                    },
                    child: CommonText.medium(
                      NotificationViewStrings.clearAll,
                      size: 16,
          
                      color: AppColors.error500,
                    ),
                  ),
                ),
              ),
              Gap(12),
          
              Expanded(
                child: Obx(
                  () => controller.notificationList.isEmpty
                      ? commonEmptyView(
                          image: isDarkMode
                              ? CommonImageAssets.darkEmptyNotification
                              : CommonImageAssets.emptyNotification,
                          title: NotificationViewStrings.caughtUp,
                          subtitle: NotificationViewStrings.caughtUpDes,
                        )
                      : ListView.builder(
                          itemCount: controller.notificationList.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, mainIndex) {
                            final data = controller.notificationList[mainIndex];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 0,
                                  ),
                                  child: CommonText.semiBold(
                                    data.date,
                                    size: 18,
                                    color: AppColors.primary500,
                                  ),
                                ),
                                ListView.separated(
                                  itemCount: data.messagesList.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: 12, bottom: 12),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final notification =
                                        data.messagesList[index];
                                    return Column(
                                      children: [
                                        Slidable(
                                          key: UniqueKey(),
                                          startActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            // dismissible: DismissiblePane(
                                            //   onDismissed: () {},
                                            // ),
                                            extentRatio:
                                                0.5, // Adjust as needed
                                            children: [
                                              CustomSlidableAction(
                                                onPressed: (context) {
                                                  controller.toggleReadStatus(
                                                    mainIndex,
                                                    index,
                                                    context,
                                                  );
                                                  // Get.back();
                                                },
          
                                                backgroundColor:
                                                    AppColors.primary500,
                                                child: Column(
                                                  children: [
                                                    SvgImageFromAsset(
                                                      AppCommonIcon.msgIcon,
                                                    ),
                                                    Gap(5),
                                                    CommonText.regular(
                                                      notification.marAsRead
                                                          ? NotificationViewStrings
                                                                .markAsUnread
                                                          : NotificationViewStrings
                                                                .markAsRead,
                                                      size: 14,
                                                      color: AppColors.white,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            extentRatio:
                                                0.5, // 0.25 * 2 buttons
                                            children: [
                                              CustomSlidableAction(
                                                onPressed: (context) {
                                                  showDeleteConfirmationDialog(
                                                    context,
                                                    () {
                                                      controller
                                                          .deleteNotification(
                                                            mainIndex,
                                                            index,
                                                            context,
                                                          );
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                                backgroundColor:
                                                    AppColors.error500,
                                                child: SvgImageFromAsset(
                                                  AppCommonIcon.deleteIcon,
                                                ),
                                              ),
                                            ],
                                          ),
                                          child: notificationView(notification),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                        return CommonDivider();
                                      },
                                ),
                              ],
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
