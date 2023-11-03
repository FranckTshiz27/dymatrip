import 'package:flutter/material.dart';
import 'package:training_dyma_training_exercice/views/activity_form/widgets/activity_form.dart';
import 'package:training_dyma_training_exercice/widgets/dyma_drawer.dart';

class ActivityFormView extends StatelessWidget {
  static const routeName = "/activity-form";
  const ActivityFormView({super.key});

  @override
  Widget build(BuildContext context) {
    String cityName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text('ajouter une activité ')),
      drawer: const DymaDrawer(),
      body: SingleChildScrollView(
        child: ActivityForm(
          cityName: cityName,
        ),
      ),
    );
  }
}
