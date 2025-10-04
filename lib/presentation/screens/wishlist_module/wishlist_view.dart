part of 'wishlist_imports.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  final WishlistController controller = Get.find<WishlistController>();
  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 20;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Scaffold(
      body: Container(
        height: context.height,
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? AppCommonGradient.mainDarkBackgroundGradient
              : AppCommonGradient.mainBackgroundGradient,
        ),
        child: Column(
          children: [
            Gap(50),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalSpacing,
              ),
              child: commonAppBar(),
            ),
            Expanded(
              child: Obx(
                () => controller.wishList.isEmpty
                    ? commonEmptyView(
                        image: isDarkMode
                            ? CommonImageAssets.darkEmptyWishlist
                            : CommonImageAssets.emptyWishlistView,
                        title: WishlistStrings.noCourseSavedYet,
                        subtitle: WishlistStrings.noCourseSavedYetDes,
                      )
                    : GridView.builder(
                        itemCount: controller.wishList.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalSpacing,
                          vertical: 30,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 190,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                        ),
                        itemBuilder: (context, index) {
                          final data = controller.wishList[index];
                          //final isFavourite=data.isFavourite.value=true;
                          return InkWell(
                            onTap: () {
                              Get.toNamed(AppRouteName.courseDetailView, arguments: data);
                            },
                            child: CommonCourseView(
                              width: double.infinity,
                              data: data,
                              height: 85,
                              margin: EdgeInsets.zero,
                              wishlistIconSize: 28,
                              wishlistOnTap: () {
                                final removed = !controller.toggleWishlist(data);
                                if (removed) {
                                  showDeleteConfirmationDialog(context, () {
                                    showSuccessMessage(
                                      context: context,
                                      title: "Артикулът е успешно премахнат от списъка с желания.",
                                      content: '',
                                    );
                                    Get.back();
                                  });
                                }
                              },
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> showDeleteConfirmationDialog(
      BuildContext context,
      VoidCallback onConfirm,
      ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return CommonAlertDialog(
          title: WishlistStrings.removeFromWishlist,
          subTitle: WishlistStrings.removeFromWishlistDes,
          primaryButtonTitle: NotificationViewStrings.delete,
          primaryButtonPressed: onConfirm,
        );
      },
    );
  }
}
