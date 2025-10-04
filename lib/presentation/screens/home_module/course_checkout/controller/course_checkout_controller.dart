import 'package:education_app/presentation/screens/home_module/home/model/course_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class CourseCheckoutController extends GetxController {
  RxList<CourseModel>? courseList;

  Rx<CourseModel?> singleCourseData = Rx<CourseModel?>(null);
  var countryNameController = TextEditingController();
  var stateController = TextEditingController();
  var creditCardNumberController = TextEditingController();
  var creditCardNameController = TextEditingController();
  var upiIdController = TextEditingController();
  var expireDateController = TextEditingController();
  var cvvController = TextEditingController();
  var selectedCreditCard = false.obs;
  var selectedUpi = false.obs;
  var selectedPaypal = false.obs;
  var selectedRazorpay = false.obs;
  var totalPrice = 0.0.obs;
  var selectedUpiSuffix = '@oksbi'.obs;



  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null && arguments is RxList<CourseModel>) {
      courseList = arguments;
      getTotalPrice();
    } else if (arguments != null && arguments is CourseModel) {
      singleCourseData.value = arguments;
      totalPrice.value=singleCourseData.value!.courseFees;
    }

    //courseList =Get.arguments as RxList<CourseModel>;
  }

  final countryList = ['India', 'USA', 'Canada'].obs;
  final stateMap = {
    'India': ['Delhi', 'Maharashtra', 'Gujarat'],
    'USA': ['California', 'Texas', 'Florida'],
    'Canada': ['Ontario', 'Quebec', 'Alberta'],
  }.obs;

  RxString selectedCountry = ''.obs;
  RxString selectedState = ''.obs;

  var searchController = TextEditingController();

  void clearSelection() {
    selectedCountry.value = '';
    selectedState.value = '';
  }

  void getTotalPrice() {
    totalPrice.value = 0.0;

    if (courseList != null) {
      for (var item in courseList!) {
        totalPrice.value += item.courseFees;
      }
    } else if (singleCourseData.value != null) {
      totalPrice.value = singleCourseData.value!.courseFees;
    }
  }
  void removeSingleCourse() {
    singleCourseData.value = null;
    totalPrice.value = 0.0;
    update();
  }
  String? validatePaymentFields() {
    if (selectedCreditCard.value) {
      if (creditCardNumberController.text.trim().isEmpty) {
        return "Please enter card number.";
      }
      if (creditCardNameController.text.trim().isEmpty) {
        return "Please enter cardholder name.";
      }
      if (expireDateController.text.trim().isEmpty) {
        return "Please enter expiry date.";
      }
      if (cvvController.text.trim().isEmpty) {
        return "Please enter CVV.";
      }
    } else if (selectedUpi.value) {
      String upi = "${upiIdController.text.trim()}${selectedUpiSuffix.value}";
      String? upiError = validateUPIId(upi);
      if (upiError != null) return upiError;
    } else if (selectedPaypal.value) {
      // You can add extra validation if needed (e.g. PayPal email)
    } else if (selectedRazorpay.value) {
      // Optional: Add logic for Razorpay if needed
    } else {
      return "Please select a payment method.";
    }

    return null; // All good
  }

  String? validateUPIId(String value) {
    final upiRegex = RegExp(r'^[\w.-]{2,256}@[a-zA-Z]{2,64}$');
    if (value.isEmpty) {
      return "Please enter UPI ID.";
    } else if (!upiRegex.hasMatch(value)) {
      return "Enter a valid UPI ID (e.g., name@bank).";
    }
    return null;
  }

  List<String> upiSuffixList = [
    '@oksbi',
    '@okhdfcbank',
    '@okicici',
    '@paytm',
    '@upi',
  ];
}
