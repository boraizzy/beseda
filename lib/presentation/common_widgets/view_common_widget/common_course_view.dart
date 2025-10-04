import 'package:education_app/presentation/common_widgets/view_common_widget/route_observer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../app/theme_controller.dart';
import '../../screens/home_module/home/model/course_model.dart';
import '../alerts/alerts.dart';
import '../widgets/common_cache_image.dart';
import '../widgets/image.dart';
import '../widgets/text.dart';

class CommonCourseView extends StatefulWidget {
  final double? width, wishlistIconSize;
  final CourseModel data;
  final bool? showLikeIcon;
  final EdgeInsetsGeometry? margin;
  final Widget? wishlistData;
  final void Function()? wishlistOnTap;
  final double? height;
  const CommonCourseView({
    super.key,
    required this.data,
    this.showLikeIcon,
    this.width,
    this.margin,
    this.wishlistIconSize,
    this.wishlistData,
    this.wishlistOnTap, this.height,
  });

  @override
  State<CommonCourseView> createState() => _CommonCourseViewState();
}

class _CommonCourseViewState extends State<CommonCourseView> {
  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 12;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;
    return Container(
      width: widget.width ?? 220,

      margin: widget.margin ?? EdgeInsets.only(right: 18, bottom: 12),
      decoration: isDarkMode
          ? AppCommonShadow.commonDarkBoxShadow
          : AppCommonShadow.commonBoxShadow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6),
                  topLeft: Radius.circular(6),
                ),
                child: Image.asset(
                  widget.data.image,
                  fit: BoxFit.cover,
                  height: 120,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.red,
                      child: const Center(child: Text("Image not found")),
                    );
                  },
                ),
              ),
              widget.showLikeIcon == false
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 24,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                          ),

                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            transform: GradientRotation(
                              106.37 * 3.14159265 / 180,
                            ),
                            colors: [
                              Color.fromRGBO(255, 255, 255, 0.7),
                              Color.fromRGBO(255, 255, 255, 0.35),
                            ],
                          ),
                        ),
                        child: Center(
                          child: CommonText.semiBold(
                            SearchViewStrings.bestseller,
                            size: 12,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    )
                  : Positioned(
                      top: 12,
                      right: 12,
                      child: Obx(
                        () => InkWell(
                          onTap:
                              widget.wishlistOnTap ??
                              () {
                                widget.data.isFavourite.value =
                                    !widget.data.isFavourite.value;
                                showSuccessMessage(
                                  context: context,
                                  title: widget.data.isFavourite.value
                                      ? CourseCartStrings.itemAddedSuccessfully
                                      : CourseCartStrings
                                      .itemRemoved,
                                  content: '',
                                );
                              },
                          child: Container(
                            height: widget.wishlistIconSize ?? 32,
                            width: widget.wishlistIconSize ?? 32,
                            decoration: BoxDecoration(
                              color: AppColors.black.withValues(alpha: 0.15),
                              border: Border.all(
                                color: AppColors.white.withValues(alpha: 0.75),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.white,
                                  AppColors.white.withValues(alpha: 0.50),
                                ],
                              ),
                              boxShadow: [BoxShadow(blurRadius: 14)],
                            ),
                            child: Center(
                              child: widget.data.isFavourite.value
                                  ? SvgImageFromAsset(AppCommonIcon.likeIcon)
                                  : SvgImageFromAsset(
                                      AppCommonIcon.wishlistIcon,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),

          Gap(7),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CommonText.semiBold(
                    widget.data.name,
                    size: 13,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: SvgImageFromAsset(
                    AppCommonIcon.starIcon,
                    height: 12,
                    width: 12,
                  ),
                ),
                Gap(3),
                CommonText.semiBold(
                  widget.data.rate.toString(),
                  size: 12,
                  color: AppColors.secondary500,
                ),
              ],
            ),
          ),
          Gap(7),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
            child: CommonText.regular(
              widget.data.instructorName,
              size: 11,
              color: AppColors.greyTextColor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Gap(7),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalSpacing),
            child: commonPriceText(widget.data.courseFees.toString()),
          ),
          Gap(2),
        ],
      ),
    );
  }
}

class FeaturedCoursesView extends StatefulWidget {
  final CourseModel data;
  final int index;
  const FeaturedCoursesView({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  State<FeaturedCoursesView> createState() => _FeaturedCoursesViewState();
}

class _FeaturedCoursesViewState extends State<FeaturedCoursesView>
    with WidgetsBindingObserver, RouteAware {
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // ✅ Only init video controller if videoUrl exists and is valid
    if (widget.data.videoUrl != null &&
        widget.data.videoUrl!.isNotEmpty &&
        UrlChecker.isValid(widget.data.videoUrl!)) {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.data.videoUrl!),
      );

      _videoPlayerController!.initialize().then((_) {
        if (mounted) {
          setState(() {
            _videoPlayerController!.setLooping(true);
            _videoPlayerController!.setVolume(1.0);
          });

          // Auto-play first video
          if (widget.index == 0 &&
              ModalRoute.of(context)?.isCurrent == true) {
            _videoPlayerController!.play();
          }
        }
      });

      _videoPlayerController!.addListener(() {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _videoPlayerController?.pause();
  }

  @override
  void didPopNext() {
    if (widget.index == 0 &&
        _videoPlayerController != null &&
        _videoPlayerController!.value.isInitialized &&
        !_videoPlayerController!.value.isPlaying) {
      _videoPlayerController!.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225,
      margin: const EdgeInsets.only(right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              GestureDetector(
                onTap: () {
                  if (_videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized) {
                    setState(() {
                      if (_videoPlayerController!.value.isPlaying) {
                        _videoPlayerController!.pause();
                      } else {
                        _videoPlayerController!.play();
                      }
                    });
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: (_videoPlayerController != null &&
                                _videoPlayerController!.value.isInitialized)
                            ? (_videoPlayerController!.value.isPlaying
                                ? VideoPlayer(_videoPlayerController!)
                                : commonCacheImage(
                                    widget.data.image,
                                    ImagePlaceHolder.imagePlaceHolderDark,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ))
                            : commonCacheImage( // 👈 fallback if no video
                                widget.data.image,
                                ImagePlaceHolder.imagePlaceHolderDark,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                      ),
                    ),
                    if (_videoPlayerController != null &&
                        !_videoPlayerController!.value.isInitialized)
                      const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 1,
                        ),
                      )
                    else if (_videoPlayerController != null &&
                        !_videoPlayerController!.value.isPlaying)
                      _buildPlayPauseIcon(Icons.play_arrow)
                    else if (_videoPlayerController != null &&
                        _videoPlayerController!.value.isPlaying)
                      _buildPlayPauseIcon(Icons.pause),
                  ],
                ),
              ),
              // favourite icon
              Positioned(
                top: 12,
                right: 12,
                child: Obx(
                  () => InkWell(
                    onTap: () {
                      widget.data.isFavourite.value =
                          !widget.data.isFavourite.value;
                      showSuccessMessage(
                        context: context,
                        title: widget.data.isFavourite.value
                            ? CourseCartStrings.itemAddedSuccessfully
                            : CourseCartStrings.itemRemoved,
                        content: '',
                      );
                    },
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: AppColors.black.withValues(alpha: 0.15),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.75),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.white,
                            AppColors.white.withValues(alpha: 0.50),
                          ],
                        ),
                        boxShadow: const [BoxShadow(blurRadius: 14)],
                      ),
                      child: Center(
                        child: widget.data.isFavourite.value
                            ? SvgImageFromAsset(AppCommonIcon.likeIcon)
                            : SvgImageFromAsset(
                                AppCommonIcon.wishlistIcon,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          CommonText.semiBold(
            widget.data.name,
            size: 16,
            height: 1.0,
            letterSpacing: 0.0,
            textAlign: TextAlign.start,
          ),
          const Gap(10),
          commonPriceText(widget.data.courseFees.toString()),
        ],
      ),
    );
  }

  Widget _buildPlayPauseIcon(IconData icon) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black45,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(12),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

class UrlChecker {
  static final urlCheckReg = RegExp(
    r"((http|https)://)(www.)?"
    "[a-zA-Z0-9@:%._\\+~#?&//=]"
    "{2,256}\\.[a-z]"
    "{2,6}\\b([-a-zA-Z0-9@:%"
    "._\\+~#?&//=]*)",
  );

  static final checkImageUrlReg = RegExp(
    r"(https?:\/\/.*\.(?:jpg|jpeg|png|webp|avif|gif|svg))",
  );

  static bool isImageUrl(String url) {
    return checkImageUrlReg.hasMatch(url);
  }

  static bool isValid(String url) {
    return urlCheckReg.hasMatch(url);
  }
}

class RelatedCoursesView extends StatefulWidget {
  final CourseModel data;

  const RelatedCoursesView({super.key, required this.data});

  @override
  State<RelatedCoursesView> createState() => _RelatedCoursesViewState();
}

class _RelatedCoursesViewState extends State<RelatedCoursesView>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: commonCacheImage(
            widget.data.image,
            ImagePlaceHolder.imagePlaceHolderDark,
            fit: BoxFit.cover,
            width: 72,
            height: 60,
          ),
        ),
        Gap(12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.medium(
                widget.data.name,
                size: 14,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(5),
              commonPriceText(widget.data.courseFees.toString()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: SvgImageFromAsset(
            AppCommonIcon.starIcon,
            height: 12,
            width: 12,
          ),
        ),
        Gap(3),
        CommonText.semiBold(
          widget.data.rate.toString(),
          size: 12,
          color: AppColors.secondary500,
        ),
      ],
    );
  }
}

class SuggestedCoursesView extends StatefulWidget {
  final CourseModel data;

  const SuggestedCoursesView({super.key, required this.data});

  @override
  State<SuggestedCoursesView> createState() => _SuggestedCoursesViewState();
}

class _SuggestedCoursesViewState extends State<SuggestedCoursesView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 225,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: commonCacheImage(
                  widget.data.image,
                  ImagePlaceHolder.imagePlaceHolderDark,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),

              // favorite icon (same as before)
              Positioned(
                top: 12,
                right: 12,
                child: Obx(
                  () => InkWell(
                    onTap: () {
                      widget.data.isFavourite.value =
                          !widget.data.isFavourite.value;
                    },
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: AppColors.black.withValues(alpha: 0.15),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.75),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.white,
                            AppColors.white.withValues(alpha: 0.50),
                          ],
                        ),
                        boxShadow: [BoxShadow(blurRadius: 14)],
                      ),
                      child: Center(
                        child: widget.data.isFavourite.value
                            ? SvgImageFromAsset(AppCommonIcon.likeIcon)
                            : SvgImageFromAsset(
                                AppCommonIcon.wishlistIcon,
                                colorFilter: ColorFilter.mode(
                                  AppColors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(10),
          CommonText.semiBold(
            widget.data.name,
            size: 16,
            height: 1.0,
            letterSpacing: 0.0,
            textAlign: TextAlign.start,
          ),
          Gap(10),
          commonPriceText(widget.data.courseFees.toString()),
        ],
      ),
    );
  }
}

Widget commonPriceText(String price) {
  return CommonText.semiBold('\$$price', size: 15, color: AppColors.primary500);
}
