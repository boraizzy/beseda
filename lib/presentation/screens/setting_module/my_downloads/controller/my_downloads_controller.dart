import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_json_path.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../utils/extensions/json_helper.dart';
import '../../../../common_widgets/alerts/alerts.dart';
import '../../../home_module/home/model/course_model.dart';
import '../model/documents_model.dart';

class MyDownloadsController extends GetxController {
  RxList<CourseModel> videoLectureList = <CourseModel>[].obs;
  RxList<DocumentsModel> documentsList = <DocumentsModel>[].obs;
  RxList<DocumentsModel> audioList = <DocumentsModel>[].obs;
  var selectedIndex = 0.obs;
 String title='';
  TextEditingController nameController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    fetchData();
    title = (Get.arguments as String?) ?? '';
  }

  void fetchData() {
    fetchVideoLectureList();
    fetchDocumentsList();
    audiosList();
  }

  void fetchVideoLectureList() async {
    videoLectureList.clear();
    try {
      final data = await loadListFromAsset<CourseModel>(
        AppJsonPath.myDownloads,
        'video_lectures_list',
        (json) => CourseModel.fromJson(json),
      );

      videoLectureList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error video_lectures_list : $e');
      }
    } finally {}
  }

  void fetchDocumentsList() async {
    documentsList.clear();
    try {
      final data = await loadListFromAsset<DocumentsModel>(
        AppJsonPath.myDownloads,
        'documents_list',
        (json) => DocumentsModel.fromJson(json),
      );

      documentsList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error documents_list : $e');
      }
    } finally {}
  }

  void audiosList() async {
    audioList.clear();
    try {
      final data = await loadListFromAsset<DocumentsModel>(
        AppJsonPath.myDownloads,
        'audio_list',
        (json) => DocumentsModel.fromJson(json),
      );

      audioList.addAll(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error audio_list : $e');
      }
    } finally {}
  }

  void selection(int index) {
    selectedIndex.value = index;
  }
//video
  deleteVideo(int index, BuildContext context) {
    videoLectureList.removeAt(index);
    Get.back();
    showSuccessMessage(
      context: context,
      title: MyDownloadsString.videoDeleteSuccessfully,
      content: '',
    );
  }

  updateVideoName(CourseModel data, BuildContext context) {
    data.name = nameController.text;
    Get.back();
    update();
    showSuccessMessage(
      context: context,
      title: MyDownloadsString.videoUpdateSuccessfully,
      content: '',
    );
    return data.name;
  }

  //document
  deleteDocument(int index, BuildContext context){
    documentsList.removeAt(index);
    Get.back();
    showSuccessMessage(
      context: context,
      title: MyDownloadsString.documentDeleteSuccessfully,
      content: '',
    );
  }

  updateDocumentName(DocumentsModel data, BuildContext context) {
    data.name = nameController.text;
    Get.back();
    update();
    showSuccessMessage(
      context: context,
      title: MyDownloadsString.videoUpdateSuccessfully,
      content: '',
    );
    return data.name;
  }

  //audio
  deleteAudio(int index, BuildContext context){
    audioList.removeAt(index);
    Get.back();
    showSuccessMessage(
      context: context,
      title: MyDownloadsString.audioDeleteSuccessfully,
      content: '',
    );
  }

  updateAudioName(DocumentsModel data, BuildContext context) {
    data.name = nameController.text;
    Get.back();
    update();
    showSuccessMessage(
      context: context,
      title: MyDownloadsString.videoUpdateSuccessfully,
      content: '',
    );
    return data.name;
  }
}
