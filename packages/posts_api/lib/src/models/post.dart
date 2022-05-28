import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  const Post({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  final int? id;
  final int userId;
  final String title;
  final String body;

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
