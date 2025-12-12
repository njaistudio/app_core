import 'package:json_annotation/json_annotation.dart';

part 'storage_target.g.dart';

@JsonSerializable()
class StorageTarget {
  @JsonKey(name: "currentTarget")
  int currentTarget = 0;
  @JsonKey(name: "streakNumber")
  int streakNumber = 0;
  @JsonKey(name: "longestStreakNumber")
  int longestStreakNumber = 0;
  @JsonKey(name: "weekTargetData")
  String weekTargetData = "";
  @JsonKey(name: "lastCompletedTargetDate")
  int lastCompletedTargetDate = 0;
  @JsonKey(name: "currentTargetWeek")
  int currentTargetWeek = 0;

  StorageTarget();

  factory StorageTarget.fromJson(Map<String, dynamic> json) => _$StorageTargetFromJson(json);

  Map<String, dynamic> toJson() => _$StorageTargetToJson(this);
}