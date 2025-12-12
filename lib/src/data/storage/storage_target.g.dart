// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_target.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageTarget _$StorageTargetFromJson(Map<String, dynamic> json) =>
    StorageTarget()
      ..currentTarget = (json['currentTarget'] as num).toInt()
      ..streakNumber = (json['streakNumber'] as num).toInt()
      ..longestStreakNumber = (json['longestStreakNumber'] as num).toInt()
      ..weekTargetData = json['weekTargetData'] as String
      ..lastCompletedTargetDate =
          (json['lastCompletedTargetDate'] as num).toInt()
      ..currentTargetWeek = (json['currentTargetWeek'] as num).toInt();

Map<String, dynamic> _$StorageTargetToJson(StorageTarget instance) =>
    <String, dynamic>{
      'currentTarget': instance.currentTarget,
      'streakNumber': instance.streakNumber,
      'longestStreakNumber': instance.longestStreakNumber,
      'weekTargetData': instance.weekTargetData,
      'lastCompletedTargetDate': instance.lastCompletedTargetDate,
      'currentTargetWeek': instance.currentTargetWeek,
    };
