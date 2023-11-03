import 'package:flutter/widgets.dart';
import '../../../models/activity.model.dart';
import '../../../data/data.dart' as data;

class Data extends InheritedWidget {
  // final List<Activity> activities = data.activities;

  Data({super.key, required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw UnimplementedError();
  }
}
