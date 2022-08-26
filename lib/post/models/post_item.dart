import 'package:equatable/equatable.dart';

class PostItem extends Equatable {
  int userId;
  int id;
  String title;
  String description;

  PostItem(
      {required this.userId,
      required this.id,
      required this.title,
      required this.description});

  factory PostItem.fromJson(Map<String, dynamic> json) {
    return PostItem(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        description: json['body']);
  }

  @override
  List<Object> props() => [userId, id, title, description];
}
