class QuizModel {
  int id = 0;
  String name = '';
  String image = '';
  int noOfQuestions = 0;
  int noOfAttendance = 0;
   String question='';
   int correctOptionIndex=0;
   List<QuizOption> options=[];
  int selectedOptionIndex=-1;
  String status = 'Pending';
  QuizModel({
    required this.id,
    required this.name,
    required this.image,
    required this.noOfQuestions,
    required this.noOfAttendance,
    required this.question,
    required this.correctOptionIndex,
    required this.options,
    required this.selectedOptionIndex,
    this.status = 'Pending',

  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      noOfQuestions: json['noOfQuestions'] ?? 0,
      noOfAttendance: json['noOfAttendance'] ?? 0,
      question: json['question']??'',
      correctOptionIndex: json['correctOptionIndex']??0,
      options: (json['options'] as List<dynamic>?)
        ?.map((e) => QuizOption.fromJson(e))
        .toList() ??
        [],
      selectedOptionIndex: json['selectedOptionIndex'] ?? -1,
        status: json['status'] ?? 'Pending',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "noOfQuestions": noOfQuestions,
      "noOfAttendance": noOfAttendance,
      "question": question,
      "correctOptionIndex": correctOptionIndex,
      "options": options.map((e) => e.toJson()).toList(),
      "selectedOptionIndex": selectedOptionIndex,
      "status": status,
    };
  }
}
class QuizOption {
   String value='';
  final bool isImage;
  String key = '';
  QuizOption({required this.value, required this.isImage,required this.key,});

  factory QuizOption.fromJson(Map<String, dynamic> json) {
    return QuizOption(
      value: json['value']??'',
      isImage: json['isImage'] ?? false,
      key: json['key'] ?? '',
    );
  }

   Map<String, dynamic> toJson() {
     return {
       "value": value,
       "isImage": isImage,
       "key": key,
     };
   }
 }