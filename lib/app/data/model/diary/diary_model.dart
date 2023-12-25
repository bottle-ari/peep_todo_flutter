class DiaryModel {
  final String id;
  DateTime date;
  List<String> image;
  String memo;

  DiaryModel({
    required this.id,
    required this.date,
    required this.image,
    required this.memo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'image': image.join(','),
      'memo': memo,
    };
  }

  factory DiaryModel.fromMap(Map<String, dynamic> map) {
    return DiaryModel(
        id: map['id'],
        date: DateTime.fromMillisecondsSinceEpoch(map['date']),
        image: map['image']?.split(',') ?? [],
        memo: map['memo']);
  }
}
