import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:education_app/presentation/common_widgets/widgets/common_divider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../app/theme_controller.dart';
import '../../../common_widgets/view_common_widget/common_app_bar.dart';
import '../../../common_widgets/widgets/button.dart';
import '../../../common_widgets/widgets/text.dart';

class LevelOneController extends GetxController {
  // ---- State ----
  final currentStep = 0.obs; // 0..steps.length+1 (last two are Q1/Q2)
  final selectedAnswer = (-1).obs;

  final isQuestion1Correct = false.obs;
  final isQuestion2Correct = false.obs;

  final showResultMessage = false.obs;
  final resultMessage = ''.obs;

  // Drag hover state for subtle highlight
  final isHoverAni = false.obs;
  final isHoverAgi = false.obs;

  // Buckets for Question 2
  final aniBucket = <String>[].obs;
  final agiBucket = <String>[].obs;

  // Items to drag
  final aniItems = const ["ChatGPT", "Самоуправляващи се коли"];
  final agiItems = const [
    "ИИ, който надминава човешкия интелект",
    "Напълно съзнателен робот"
  ];

  // Steps text

  final steps = [
    // Стъпка 1
    "Да започнем! Изкуственият интелект (ИИ) може да изглежда като нова мода, но всъщност съществува от десетилетия. През 50-те години легендарният математик Алън Тюринг задава революционния въпрос: \"Могат ли машините да мислят?\" Този въпрос предизвиква истинска научна революция.",
    "Малко по-късно ИИ се оформя като ново научно направление в рамките на компютърните науки. Компютърните науки обхващат всичко — от хардуер и езици за програмиране до алгоритми и операционни системи. Сред всички тези области ИИ се превръща в една от най-вълнуващите.",
    "През 1950-те години Джон Маккарти описва ИИ като \"науката и инженерството за създаване на интелигентни машини\". Днес дефиницията се разширява: системи, които възприемат средата си, събират и интерпретират данни, разсъждават, взимат решения и действат, за да постигнат цел.",
    "С течение на времето ИИ се развива от теоретична идея до мощна сила, която променя индустрии и ежедневието ни. Но истинският Изкуствен Общ Интелект (AGI) все още не съществува. Днешният ИИ е т.нар. Изкуствен Тесен Интелект (ANI), който е силен в конкретни задачи, но не и в общо човешко мислене.",
    "Гласови асистенти, лицево разпознаване, самоуправляващи се коли и дори генеративни модели като GPT са впечатляващи, но остават специализирани. Бъдещето тепърва предстои!"
  ];

  // Media per step
  final List<Map<String, String>> stepMedia = const [
    {"type": "image", "url": "assets/images/ai_intro.png"},
    {"type": "image", "url": "assets/images/ai_history.png"},
    {"type": "image", "url": "assets/images/mccarthy.png"},
    {"type": "image", "url": "assets/images/agi_vs_ani.png"},
    {"type": "image", "url": "assets/images/examples.png"},
  ];

  // Video (kept for when stepMedia uses `"video"`)
  late VideoPlayerController video;

  bool get isQuestion1 => currentStep.value == steps.length;
  bool get isQuestion2 => currentStep.value == steps.length + 1;

  @override
  void onInit() {
    super.onInit();
    video = VideoPlayerController.asset("assets/videos/intro.mp4");
  }

  @override
  void onReady() async {
    await video.initialize();
    video.setLooping(true);
    update();
    super.onReady();
  }

  @override
  void onClose() {
    video.dispose();
    super.onClose();
  }

  // ---- Logic ----
  void next() {
    if (isQuestion1) {
      if (!isQuestion1Correct.value) {
        checkQuestion1();
        return;
      }
    } else if (isQuestion2) {
      if (!isQuestion2Correct.value) {
        checkQuestion2();
        return;
      }
      // Finished -> navigate
      Get.toNamed("/course_detail_view");
      return;
    }

    if (currentStep.value < steps.length + 1) {
      currentStep.value++;
      showResultMessage.value = false;
    }
  }

  void prev() {
    if (currentStep.value > 0) {
      currentStep.value--;
      showResultMessage.value = false;
    }
  }

  void selectAnswer(int index) {
    selectedAnswer.value = index; // reactive; UI below listens with Obx
  }

  void checkQuestion1() {
    if (selectedAnswer.value == 1) {
      isQuestion1Correct.value = true;
      showResultMessage.value = true;
      resultMessage.value = "Правилно ✅";
    } else {
      showResultMessage.value = true;
      resultMessage.value = "Грешно ❌";
    }
  }

  void checkQuestion2() {
    final ok =
        aniBucket.contains("ChatGPT") &&
        aniBucket.contains("Самоуправляващи се коли") &&
        agiBucket.contains("ИИ, който надминава човешкия интелект") &&
        agiBucket.contains("Напълно съзнателен робот");

    if (ok) {
      isQuestion2Correct.value = true;
      showResultMessage.value = true;
      resultMessage.value = "Правилно ✅";
    } else {
      showResultMessage.value = true;
      resultMessage.value = "Грешно ❌";
    }
  }

  // Drag helpers (use clear/remove/add in a reactive way)
  void dropToAni(String data) {
    agiBucket.remove(data);
    if (!aniBucket.contains(data)) {
      aniBucket.add(data);
    }
    // trigger pool rebuild if needed
    aniBucket.refresh();
    agiBucket.refresh();
  }

  void dropToAgi(String data) {
    aniBucket.remove(data);
    if (!agiBucket.contains(data)) {
      agiBucket.add(data);
    }
    aniBucket.refresh();
    agiBucket.refresh();
  }
}

class LevelOneScreen extends StatelessWidget {
  const LevelOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LevelOneController());
    const double horizontalSpacing = 20;
    final bool isDarkMode = Get.find<ThemeController>().isDarkMode;

    return Scaffold(
      body: Container(
        height: context.height,
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? AppCommonGradient.mainDarkBackgroundGradient
              : AppCommonGradient.mainBackgroundGradient,
        ),
        child: SafeArea(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // AppBar
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CommonAppbar(
                    onPressedBack: () => Get.back(),
                    title: "Level 1",
                  ),
                ),

                const Gap(12),

                // Header: progress
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: horizontalSpacing),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.semiBold(
                        "Стъпка",
                        size: 20,
                        color: isDarkMode
                            ? AppColors.bodyTextDarkColor
                            : AppColors.bodyTextColor,
                      ),
                      CommonText.semiBold(
                        '${(controller.currentStep.value + 1).clamp(1, controller.steps.length + 2)}/${controller.steps.length + 2}',
                        size: 20,
                      ),
                    ],
                  ),
                ),

                const Gap(16),

                // Content (centered) with smooth transitions
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalSpacing),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          transitionBuilder: (child, anim) => FadeTransition(
                            opacity: anim,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, .02),
                                end: Offset.zero,
                              ).animate(anim),
                              child: child,
                            ),
                          ),
                          child: _Content(
                            key: ValueKey(controller.currentStep.value),
                            controller: controller,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Result toast
                if (controller.showResultMessage.value) ...[
                  const Gap(8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalSpacing),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: controller.resultMessage.value.contains("Правилно")
                            ? Colors.green[200]
                            : Colors.red[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CommonText.semiBold(
                          controller.resultMessage.value,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],

                const Gap(10),

                // Dots (moved here, centered, just above buttons)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: horizontalSpacing),
                  child: Center(
                    child: _Dots(
                      total: controller.steps.length + 2,
                      current: controller.currentStep.value
                          .clamp(0, controller.steps.length + 1),
                    ),
                  ),
                ),

                const Gap(8),

                // Prev / Next buttons (QuizView style)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: horizontalSpacing),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlineButton(
                          onPressed: controller.currentStep.value == 0
                              ? null
                              : controller.prev,
                          label: "Предишна",
                          borderSide: BorderSide(
                            color: controller.currentStep.value == 0
                                ? AppColors.greyColor
                                : AppColors.primary500,
                          ),
                          textColor: controller.currentStep.value == 0
                              ? AppColors.greyColor
                              : AppColors.primary500,
                          textSize: 16,
                          textWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: PrimaryButton(
                          onPressed: controller.next,
                          label: controller.isQuestion2
                              ? (controller.isQuestion2Correct.value
                                  ? "Свърши"
                                  : "Провери")
                              : controller.isQuestion1
                                  ? (controller.isQuestion1Correct.value
                                      ? "Напред"
                                      : "Провери")
                                  : "Напред",
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- UI pieces ----------------

class _Content extends StatelessWidget {
  const _Content({required this.controller, super.key});
  final LevelOneController controller;

  @override
  Widget build(BuildContext context) {
    final step = controller.currentStep.value;

    if (step < controller.steps.length) {
      return Column(
        key: const ValueKey('steps'),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Centered step copy with subtle fade on change
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Padding(
              key: ValueKey(step),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CommonText.medium(
                controller.steps[step],
                size: 18,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Gap(16),
          _StepMedia(controller: controller, index: step),
          const Gap(8),
        ],
      );
    } else if (controller.isQuestion1) {
      return _QuestionOne(controller: controller);
    } else {
      return _QuestionTwo(controller: controller);
    }
  }
}

class _QuestionOne extends StatelessWidget {
  const _QuestionOne({required this.controller});
  final LevelOneController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          key: const ValueKey('q1'),
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonText.semiBold(
              "Кой задава въпроса 'Могат ли машините да мислят?'",
              size: 18,
              textAlign: TextAlign.center,
            ),
            const Gap(16),
            _AnswerCard(
              text: "Джон Маккарти",
              selected: controller.selectedAnswer.value == 0,
              onTap: () => controller.selectAnswer(0),
            ),
            const Gap(12),
            _AnswerCard(
              text: "Алън Тюринг",
              selected: controller.selectedAnswer.value == 1,
              onTap: () => controller.selectAnswer(1),
            ),
            const Gap(12),
            _AnswerCard(
              text: "Ада Лъвлейс",
              selected: controller.selectedAnswer.value == 2,
              onTap: () => controller.selectAnswer(2),
            ),
            const Gap(8),
          ],
        ));
  }
}

class _QuestionTwo extends StatelessWidget {
  const _QuestionTwo({required this.controller});
  final LevelOneController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('q2'),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonText.semiBold("Сортирай AI типовете:", size: 18),
        const Gap(12),

        // Buckets row
        Row(
          children: [
            Expanded(
              child: DragTarget<String>(
                onWillAccept: (_) {
                  controller.isHoverAni.value = true;
                  return true;
                },
                onLeave: (_) => controller.isHoverAni.value = false,
                onAccept: (data) {
                  controller.isHoverAni.value = false;
                  controller.dropToAni(data);
                },
                builder: (context, _, __) {
                  return Obx(() => _Bucket(
                        title: "ANI",
                        items: controller.aniBucket.value,
                        isHover: controller.isHoverAni.value,
                      ));
                },
              ),
            ),
            const Gap(12),
            Expanded(
              child: DragTarget<String>(
                onWillAccept: (_) {
                  controller.isHoverAgi.value = true;
                  return true;
                },
                onLeave: (_) => controller.isHoverAgi.value = false,
                onAccept: (data) {
                  controller.isHoverAgi.value = false;
                  controller.dropToAgi(data);
                },
                builder: (context, _, __) {
                  return Obx(() => _Bucket(
                        title: "AGI",
                        items: controller.agiBucket.value,
                        isHover: controller.isHoverAgi.value,
                      ));
                },
              ),
            ),
          ],
        ),

        const Gap(16),
        CommonDivider(),
        const Gap(8),

        // Pool (unplaced chips)
        Obx(() {
          final pool = [
            ...controller.aniItems,
            ...controller.agiItems,
          ].where((item) =>
              !controller.aniBucket.value.contains(item) &&
              !controller.agiBucket.value.contains(item)).toList();

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: pool.isEmpty
                ? const Opacity(
                    opacity: 0.6, child: Text("Няма останали елементи"))
                : Wrap(
                    key: ValueKey(pool.length),
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: pool.map((item) {
                      return Draggable<String>(
                        data: item,
                        feedback: _chip(item, dragging: true),
                        childWhenDragging: const SizedBox.shrink(),
                        child: _chip(item),
                      );
                    }).toList(),
                  ),
          );
        }),
        const Gap(8),
      ],
    );
  }
}


class _StepMedia extends StatelessWidget {
  const _StepMedia({required this.controller, required this.index});
  final LevelOneController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    final meta = controller.stepMedia[index];
    if (meta["type"] == "image") {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Image.asset(
            meta["url"]!,
            key: ValueKey(meta["url"]),
            height: 220,
            fit: BoxFit.contain,
          ),
        ),
      );
    }
    if (meta["type"] == "video") {
      return controller.video.value.isInitialized
          ? AspectRatio(
              aspectRatio: controller.video.value.aspectRatio,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: VideoPlayer(controller.video),
              ),
            )
          : const Center(child: CircularProgressIndicator());
    }
    return const SizedBox.shrink();
  }
}

class _AnswerCard extends StatelessWidget {
  const _AnswerCard({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Material ensures InkWell taps/ripples work reliably
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected ? Colors.blue[50] : Colors.white.withOpacity(.85),
            border: Border.all(
              color: selected ? Colors.blue : Colors.black26,
              width: selected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              if (selected)
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(2, 4),
                ),
            ],
          ),
          child: Row(
            children: [
              Expanded(child: CommonText.regular(text, size: 16)),
              const SizedBox(width: 12),
              _radio(selected),
            ],
          ),
        ),
      ),
    );
  }

  Widget _radio(bool checked) => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: checked ? Colors.blue : Colors.black38),
        ),
        alignment: Alignment.center,
        child: checked
            ? Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              )
            : const SizedBox.shrink(),
      );
}

class _Bucket extends StatelessWidget {
  const _Bucket({
    required this.title,
    required this.items,
    this.isHover = false,
  });

  final String title;
  final List<String> items; // plain List, not RxList
  final bool isHover;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        border: Border.all(
          color: isHover ? Colors.blue : Colors.black26,
          width: isHover ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.semiBold(title),
              const Gap(8),
              if (items.isEmpty)
                const Opacity(opacity: 0.6, child: Text("Пусни тук"))
              else
                Wrap(
                  alignment: WrapAlignment.start,
                  children: items.map((item) {
                    return Draggable<String>(
                      data: item,
                      feedback: _chip(item, dragging: true),
                      childWhenDragging: _chip(item, ghost: true),
                      child: _chip(item),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget _chip(String text, {bool dragging = false, bool ghost = false}) {
  return AnimatedOpacity(
    duration: const Duration(milliseconds: 120),
    opacity: ghost ? 0.5 : 1,
    child: Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: dragging
            ? Colors.white
            : ghost
                ? Colors.grey[300]
                : Colors.white,
        border: Border.all(color: ghost ? Colors.black26 : Colors.black87),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: ghost ? Colors.black54 : Colors.black87),
      ),
    ),
  );
}

class Gap extends SizedBox {
  const Gap(double h, {Key? key}) : super(key: key, height: h);
}

class _Dots extends StatelessWidget {
  const _Dots({required this.total, required this.current});
  final int total;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 18 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? Colors.blue : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
