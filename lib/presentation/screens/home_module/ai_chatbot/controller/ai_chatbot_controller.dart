import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../ai_learning/model/message_model.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../home/model/course_model.dart';

class AiChatbotController extends GetxController {
  CourseModel? data;
  String? liveSessionTitle;
  RxList<MessageModel> messageList = <MessageModel>[].obs;
  var isEmojiPickerVisible = false.obs;
  TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  static DateTime now = DateTime.now();
  String formattedTime = DateFormat('EEEE h:mm a').format(now)
      .replaceAll('AM', 'am')
      .replaceAll('PM', 'pm');

  @override
  void onInit() {
    super.onInit();
    fetchMessageListDetail();
    final arguments = Get.arguments;
    if (arguments != null && arguments is CourseModel) {
      data = arguments;
    } else if (arguments != null && arguments is String) {
      liveSessionTitle = arguments;
    }
  }

  void fetchMessageListDetail() async {
    messageList.clear();
    try {
      final data = await loadListFromAsset<MessageModel>(
        AppJsonPath.messageList,
        'message_list',
        (json) => MessageModel.fromJson(json),
      );
      messageList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error message_list : $e');
      }
    }
  }

  // 🔹 Connect to Ollama
  Future<String> getRagResponse(String userMessage) async {
    // Emulator → PC
    final url = Uri.parse("http://192.168.100.249:5000/ask");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question": userMessage}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["response"] ?? "Няма отговор от модела.";
      } else {
        return "Грешка: ${response.body}";
      }
    } catch (e) {
      return "Грешка при връзка с RAG сървъра: $e";
    }
  }

  // 🔹 Send user text + get AI reply
  Future<void> sendText() async {
    final msg = textController.text.trim();
    if (msg.isEmpty) return;

    // Add user message
    messageList.add(
      MessageModel(
        id: messageList.length + 1,
        content: msg,
        type: MessageType.text,
        isSender: true,
        time: formattedTime,
        name: '',
        image: '',
      ),
    );

    messageList.refresh();
    textController.clear();

    // Scroll
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });

    // 🔥 AI response
    final aiResponse = await getRagResponse(msg);

    messageList.add(
      MessageModel(
        id: messageList.length + 1,
        content: aiResponse,
        type: MessageType.text,
        isSender: false,
        time: formattedTime,
        name: 'TutorAI',
        image: '',
      ),
    );

    messageList.refresh();

    // Scroll again
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  var fileSize = 0.obs;

  Future<void> pickMedia() async {
    final result = await PhotoManager.requestPermissionExtend();
    if (!result.isAuth) return PhotoManager.openSetting();

    final paths = await PhotoManager.getAssetPathList(type: RequestType.common);
    final recent = paths.first;
    final assets = await recent.getAssetListPaged(page: 0, size: 50);

    Get.bottomSheet(
      GridView.builder(
        itemCount: assets.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (_, index) {
          final asset = assets[index];
          return FutureBuilder<File?>(
            future: asset.file,
            builder: (_, snapshot) {
              if (!snapshot.hasData) return const SizedBox.shrink();
              final originalFile = snapshot.data!;
              final type = asset.type == AssetType.video
                  ? MessageType.video
                  : MessageType.image;

              return GestureDetector(
                onTap: () async {
                  try {
                    final tempDir = await getTemporaryDirectory();
                    final fileName = originalFile.path
                        .split('/')
                        .last;
                    final savedFile = await originalFile.copy(
                      '${tempDir.path}/$fileName',
                    );

                    messageList.add(
                      MessageModel(
                        id: messageList.length + 1,
                        content: savedFile.path,
                        type: type,
                        isSender: true,
                        time: formattedTime,
                        name: '',
                        image: '',
                      ),
                    );

                    Get.back();
                    Future.delayed(const Duration(milliseconds: 100), () {
                      if (scrollController.hasClients) {
                        scrollController.jumpTo(
                          scrollController.position.maxScrollExtent,
                        );
                      }
                    });
                  } catch (e) {
                    Get.snackbar("Error", "Failed to send media.");
                  }
                },
                child: Stack(
                  children: [
                    AssetEntityImage(
                      asset,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    if (type == MessageType.video)
                      const Center(
                        child: Icon(Icons.videocam, color: Colors.white),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Future<void> pickDocument() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx'],
  //   );
  //
  //   if (result != null && result.files.isNotEmpty) {
  //     try {
  //       final picked = result.files.first;
  //       final originalFile = File(picked.path!);
  //       final tempDir = await getTemporaryDirectory();
  //       final savedPath = '${tempDir.path}/${picked.name}';
  //       final savedFile = await originalFile.copy(savedPath);
  //
  //       fileSize.value = picked.size;
  //
  //       messageList.add(
  //         MessageModel(
  //           id: messageList.length + 1,
  //           content: savedFile.path,
  //           fileName: picked.name,
  //           fileSize: picked.size,
  //           type: MessageType.document,
  //           isSender: true,
  //           time: formattedTime,
  //           name: '',
  //           image: '',
  //         ),
  //       );
  //
  //       Future.delayed(const Duration(milliseconds: 100), () {
  //         if (scrollController.hasClients) {
  //           scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //         }
  //       });
  //     } catch (e) {
  //       Get.snackbar("Error", "Failed to send document.");
  //     }
  //   }
  // }



   Future<void> pickDocument() async {
     // Request permission first
     if (await Permission.storage.request().isGranted ||
         await Permission.mediaLibrary.request().isGranted) {

       final result = await FilePicker.platform.pickFiles(
         type: FileType.custom,
         allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx'],
       );

       if (result != null && result.files.isNotEmpty) {
         try {
           final picked = result.files.first;
           final originalFile = File(picked.path!);
           final tempDir = await getTemporaryDirectory();
           final savedPath = '${tempDir.path}/${picked.name}';
           final savedFile = await originalFile.copy(savedPath);

           fileSize.value = picked.size;

           messageList.add(
             MessageModel(
               id: messageList.length + 1,
               content: savedFile.path,
               fileName: picked.name,
               fileSize: picked.size,
               type: MessageType.document,
               isSender: true,
               time: formattedTime,
               name: '',
               image: '',
             ),
           );

           Future.delayed(const Duration(milliseconds: 100), () {
             if (scrollController.hasClients) {
               scrollController.jumpTo(scrollController.position.maxScrollExtent);
             }
           });
         } catch (e) {
           Get.snackbar("Error", "Failed to send document.");
         }
       }
     } else {
       Get.snackbar("Permission Denied", "Please allow storage access from App Settings.");
       openAppSettings(); // Opens the App Info screen manually
     }
   }


   Future<void> captureImageFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
          source: ImageSource.camera);

      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);

        messageList.add(
          MessageModel(
            id: messageList.length + 1,
            content: imageFile.path,
            type: MessageType.image,
            isSender: true,
            time: formattedTime,
            name: '',
            image: '',
          ),
        );

        Future.delayed(const Duration(milliseconds: 100), () {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Camera capture error: $e");
      }
    }
  }
}
