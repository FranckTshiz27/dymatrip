import 'package:flutter/widgets.dart';
import 'package:training_dyma_training_exercice/models/activity.model.dart';

class Trip {
  String city;
  List<Activity> activities;
  DateTime date;
  String? id;
  Trip(
      {required this.city,
      required this.activities,
      required this.date,
      this.id});

  // Trip(
  //     {required this.city,
  //     required this.activities,
  //     required this.date,
  //     required this.id}) {
  //   id = UniqueKey().toString();
  // }

  Trip.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        city = json['city'],
        date = DateTime.parse(json['date']),
        activities = (json['activities'] as List)
            .map(
              (activityJson) => Activity.fromJson(activityJson),
            )
            .toList();

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_null_comparison
    if (id != null) {
      return {
        '_id': id,
        'city': city,
        'date': date!.toIso8601String(),
        'activities': activities
            .map(
              (activity) => activity.toJson(),
            )
            .toList()
      };
    } else {
      return {
        'city': city,
        'date': date!.toIso8601String(),
        'activities': activities
            .map(
              (activity) => activity.toJson(),
            )
            .toList(),
      };
    }
  }
}
