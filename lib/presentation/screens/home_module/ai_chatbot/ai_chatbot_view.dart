part of 'ai_chatbot_imports.dart';

class AiChatbotView extends StatefulWidget {
  const AiChatbotView({super.key});

  @override
  State<AiChatbotView> createState() => _AiChatbotViewState();
}

class _AiChatbotViewState extends State<AiChatbotView> {
  AiChatbotController controller = Get.put(AiChatbotController());

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
        child: SafeArea(
          child: Column(
            children: [
              Gap(15),
              Row(
                children: [
                  BackIcon(),
                  Gap(5),
                  controller.data != null
                      ? Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            commonCacheImage(
                              controller.data?.instructorProfileImg,
                              ImagePlaceHolder.imagePlaceHolderDark,
                              fit: BoxFit.cover,
                              height: 40,
                              width: 40,
                            ),
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: AppColors.success500,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                          ],
                        )
                      : controller.liveSessionTitle != null
                      ? SvgImageFromAsset(CommonImageAssets.generic)
                      : chatBotIcon(),
                  Gap(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.semiBold(
                        controller.data != null
                            ? controller.data!.instructorName
                            : controller.liveSessionTitle != null
                            ? LeaveSessionString.onlineLiveClass
                            : AiChatbotStrings.tutorAI,
                        size: 18,
                      ),
                      CommonText.regular(
                        controller.liveSessionTitle != null
                            ? '123 Participants'
                            : AiChatbotStrings.alwaysActive,
                        size: 14,
                        color: isDarkMode
                            ? AppColors.bodyTextDarkColor
                            : AppColors.bodyTextColor,
                      ),
                    ],
                  ),
                ],
              ),
              Gap(20),
              CommonDivider(
                color: isDarkMode
                    ? AppColors.grey100Color
                    : AppColors.borderDisabledColor,
              ),
              Expanded(
                child: Obx(() {
                  final messages = controller.messageList;
                  return KeyedSubtree(
                    key: ValueKey(messages.length), // <- this forces rebuild
                    child: ListView.builder(
                      controller: controller.scrollController,
                      shrinkWrap: true,
                      itemCount: messages.length,
                      padding: EdgeInsets.only(top: 25, left: 15, right: 15),
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return Align(
                          alignment: message.isSender
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MessageBubbleWidget(message: message),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
          
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.cardDarkBgColor
                      : AppColors.mainBgColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-6, -6),
                      color: AppColors.black.withValues(alpha: 0.09),
                      blurRadius: 23,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalSpacing,
                    vertical: 15,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                          contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                          controller: controller.textController,
                          focusNode: controller.focusNode,
                          textInputAction: TextInputAction.send,
                          hintText: AiChatbotStrings.typeMessage,
                          fillColor: Colors.transparent,
                          prefixIcon: SizedBox(
                            height: 20,
                            width: 20,
                            child: InkWell(
                              onTap: () {
                                commonDialog(
                                  context: context,
                                  view: pickDocumentDialog(
                                    document: true,
                                    cameraOnTap: () {
                                      controller.captureImageFromCamera();
                                      Get.back();
                                    },
                                    galleryTap: () {
                                      controller.pickMedia();
                                      Get.back();
                                    },
                                    fileOnTap: () {
                                      controller.pickDocument();
                                      Get.back();
                                    },
                                  ),
                                );
          
          
                              },
                              child: SvgImageFromAsset(
                                AppCommonIcon.attachmentIcon,
                                colorFilter: ColorFilter.mode(
                                  isDarkMode
                                      ? AppColors.bodyTextDarkColor
                                      : AppColors.bodyTextColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap(10),
                      InkWell(
                        onTap: () {
                          controller.sendText();
                        },
                        child: SvgImageFromAsset(
                          CommonImageAssets.msgSend,
                          height: 53,
                          width: 53,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _chatBotIcon() {
  //   return Container(
  //     height: 40,
  //     width: 40,
  //     decoration: BoxDecoration(
  //       color: AppColors.background100,
  //       shape: BoxShape.circle,
  //     ),
  //     child: Center(child: SvgImageFromAsset(CommonImageAssets.bot)),
  //   );
  // }
  // Widget buildMessageBubble(MessageModel message) {
  //   bool isSender = message.isSender;
  //   switch (message.type) {
  //     case MessageType.text:
  //       return Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: isSender?MainAxisAlignment.end:MainAxisAlignment.start,
  //         children: [
  //           if (!isSender) ...[_chatBotIcon(), Gap(10)],
  //
  //           IntrinsicWidth(
  //             child: Column(
  //               crossAxisAlignment: isSender
  //                   ? CrossAxisAlignment.end
  //                   : CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     CommonText.regular(
  //                       isSender ? 'You' : 'TutorAI',
  //                       size: 14,
  //                       color: AppColors.bodyTextColor,
  //                     ),
  //                     Gap(5),
  //                     CommonText.regular(
  //                       message.time,
  //                       size: 12,
  //                       color: AppColors.greyTextColor,
  //                     ),
  //                   ],
  //                 ),
  //
  //                 Gap(6),
  //
  //                 Container(
  //                   constraints: BoxConstraints(
  //                     maxWidth: context.width * 0.68,
  //                   ),
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 10,
  //                     vertical: 10,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: isSender
  //                         ? AppColors.primary500
  //                         : AppColors.mainBgColor,
  //                     borderRadius: isSender
  //                         ? const BorderRadius.only(
  //                       topLeft: Radius.circular(6),
  //                       bottomRight: Radius.circular(6),
  //                       bottomLeft: Radius.circular(6),
  //                     )
  //                         : const BorderRadius.only(
  //                       topRight: Radius.circular(6),
  //                       bottomRight: Radius.circular(6),
  //                       bottomLeft: Radius.circular(6),
  //                     ),
  //                     border: Border.all(
  //                       color: isSender
  //                           ? Colors.transparent
  //                           : AppColors.greyColor,
  //                     ),
  //                   ),
  //                   child: CommonText.regular(
  //                     message.content,
  //                     color: message.isSender
  //                         ? AppColors.white
  //                         : AppColors.headingsColor,
  //                     size: 14,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       );
  //
  //     case MessageType.image:
  //       return GestureDetector(
  //         onTap: () {},
  //         // => Get.to(() => FullImageScreen(path: message.content)),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(10),
  //           child: Image.file(
  //             File(message.content),
  //             width: 150,
  //             height: 150,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       );
  //
  //     case MessageType.video:
  //       return GestureDetector(
  //         onTap: () {},
  //         child: SizedBox(
  //           width: 150,
  //           height: 150,
  //           child: MessageVideoPlayerWidget(file: File(message.content)),
  //         ),
  //       );
  //
  //     case MessageType.document:
  //       return Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //         decoration: BoxDecoration(
  //           color: AppColors.white,
  //           borderRadius: BorderRadius.only(
  //             topRight: Radius.circular(16),
  //             bottomLeft: Radius.circular(16),
  //             bottomRight: Radius.circular(16),
  //           ),
  //         ),
  //         child: Row(
  //           children: [
  //             SvgImageFromAsset(CommonImageAssets.pdf, height: 40, width: 40),
  //             Gap(12),
  //             Expanded(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   CommonText.semiBold(
  //                     message.fileName ?? 'Unknown Document',
  //                     size: 12,
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //
  //                   CommonText.regular(
  //                     controller.fileSize.value.toString(),
  //                     size: 10,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //   }
  // }
}
