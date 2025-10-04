class RankModel {
   int rank=0;
   String title='';
   int courses=0;
   String image='';

  RankModel({
    required this.rank,
    required this.title,
    required this.courses,
    required this.image,
  });

  factory RankModel.fromJson(Map<String, dynamic> json) {
    return RankModel(
      rank: json['rank']??0,
      title: json['title']??'',
      courses: json['courses']??0,
      image: json['image']??'',
    );
  }
}
