import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/theme_controller.dart';
import '../../../../common_widgets/widgets/common_cache_image.dart';
import '../../../../common_widgets/widgets/image.dart';
import '../../../../common_widgets/widgets/text.dart';
import '../../ai_learning/model/message_model.dart';
import '../controller/ai_chatbot_controller.dart';

class MessageVideoPlayerWidget extends StatefulWidget {
  final File file;

  const MessageVideoPlayerWidget({super.key, required this.file});

  @override
  State<MessageVideoPlayerWidget> createState() =>
      _MessageVideoPlayerWidgetState();
}

class _MessageVideoPlayerWidgetState extends State<MessageVideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        if (mounted) setState(() {});
        // Don't auto-play here
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
              const Icon(Icons.play_circle_fill, color: Colors.white, size: 48),
            ],
          )
        : const SizedBox(
            height: 90,
            width: 90,
            child: Center(child: CircularProgressIndicator()),
          );
  }
}

class MessageBubbleWidget extends StatelessWidget {
  final MessageModel message;

  MessageBubbleWidget({super.key, required this.message});
  final AiChatbotController controller = Get.put(AiChatbotController());
  @override
  Widget build(BuildContext context) {
    final bool isSender = message.isSender;
    bool isDarkMode = Get.find<ThemeController>().isDarkMode;

    switch (message.type) {
      case MessageType.text:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: isSender
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!isSender) ...[
              controller.data != null
                  ? commonCacheImage(
                      controller.data?.instructorProfileImg,
                      ImagePlaceHolder.imagePlaceHolderDark,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    )
                  :  controller.liveSessionTitle!=null
                  ? commonCacheImage(
                      'https://media.imperiathemes.com/images/education_app/BmQ6KLyos7Vf687f20a31c683.png',
                      ImagePlaceHolder.imagePlaceHolderDark,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    )
                  : chatBotIcon(),
              Gap(10),
            ],

            IntrinsicWidth(
              child: Column(
                crossAxisAlignment: isSender
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.regular(
                        isSender
                            ? 'You'
                            : controller.data != null
                            ? controller.data!.instructorName
                            :  controller.liveSessionTitle!=null
                            ?'Ella Gonzalez':'TutorAI',
                        size: 14,
                        color: isDarkMode
                            ? AppColors.bodyTextDarkColor
                            : AppColors.bodyTextColor,
                      ),
                      Gap(5),
                      CommonText.regular(
                        message.time,
                        size: 12,
                        color: isDarkMode
                            ? AppColors.greyTextDarkColor
                            : AppColors.greyTextColor,
                      ),
                    ],
                  ),
                  Gap(6),
                  Container(
                    constraints: BoxConstraints(maxWidth: context.width * 0.70),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSender
                          ? AppColors.primary500
                          : isDarkMode
                          ? AppColors.cardDarkBg2Color
                          : AppColors.mainBgColor,
                      borderRadius: isSender
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                            )
                          : const BorderRadius.only(
                              topRight: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                            ),
                      border: Border.all(
                        color: isSender
                            ? Colors.transparent
                            : isDarkMode
                            ? AppColors.greyColor
                            : AppColors.greyColor,
                      ),
                    ),
                    child: CommonText.regular(
                      message.content,
                      color: isSender
                          ? AppColors.white
                          : isDarkMode
                          ? AppColors.headingsLightColor
                          : AppColors.headingsColor,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      case MessageType.image:
        return GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.regular(
                      isSender ? 'You' : 'TutorAI',
                      size: 14,
                      color: AppColors.bodyTextColor,
                    ),
                    Gap(5),
                    CommonText.regular(
                      message.time,
                      size: 12,
                      color: AppColors.greyTextColor,
                    ),
                  ],
                ),
                Gap(10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.file(
                      File(message.content),
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

      case MessageType.video:
        return GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.regular(
                      isSender ? 'You' : 'TutorAI',
                      size: 14,
                      color: AppColors.bodyTextColor,
                    ),
                    Gap(5),
                    CommonText.regular(
                      message.time,
                      size: 12,
                      color: AppColors.greyTextColor,
                    ),
                  ],
                ),
                Gap(10),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: MessageVideoPlayerWidget(file: File(message.content)),
                ),
              ],
            ),
          ),
        );

      case MessageType.document:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.cardDarkBgColor : AppColors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            border: Border.all(
              color: isDarkMode ? AppColors.greyColor : AppColors.greyColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              SvgImageFromAsset(CommonImageAssets.pdf, height: 40, width: 40),
              Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.semiBold(
                      message.fileName ?? 'Unknown Document',
                      size: 12,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    CommonText.regular(
                      controller.fileSize.value.toString(),
                      size: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    }
  }
}

chatBotIcon() {
  bool isDarkMode = Get.find<ThemeController>().isDarkMode;
  return Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      color: isDarkMode ? AppColors.primary500 : AppColors.background100,
      shape: BoxShape.circle,
    ),
    child: Center(
      child: SvgImageFromAsset(
        isDarkMode ? CommonImageAssets.darkBot : CommonImageAssets.bot,
        height: 24,
        width: 24,
      ),
    ),
  );
}
