class FoodItem {
  final int? number;
  final String? title;
  final String? fullName;
  final int? score;

  FoodItem({
    required this.number,
    required this.title,
    required this.fullName,
    required this.score,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      number: json['number'],
      title: json['title'],
      fullName: json['fullName'],
      score: json['score'],
    );
  }

  FoodItem.fromJson2(Map<String, dynamic> json)
      : number = json['number'],
        title = json['title'],
        fullName = json['fullName'],
        score = json['score'];

  @override
  String toString() {
    return '$number: $title $fullName $score';
  }
}
