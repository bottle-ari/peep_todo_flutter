import 'dart:ui';

import 'package:peep_todo_flutter/app/data/model/diary/diary_todo_model.dart';

class DiaryModel {
  final String id;
  String image;
  String memo;

  DiaryModel({
    required this.id,
    required this.image,
    required this.memo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'memo': memo,
    };
  }

  factory DiaryModel.fromMap(Map<String, dynamic> map) {
    return DiaryModel(
        id: map['id'],
        image: map['image'],
        memo: map['memo']);
  }
}
