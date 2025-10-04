class LeaderBoardModel {
  int rank = 0;
  String name = '';
  int score = 0;
  String country = '';

  LeaderBoardModel({
    required this.rank,
    required this.name,
    required this.score,
    required this.country,

  });

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) {
    return LeaderBoardModel(
      rank: json['rank'] ?? 0,
      name: json['name'] ?? '',
      score: json['score'] ?? 0,
      country: json['country'] ?? '',
    );
  }
}
