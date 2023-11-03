import 'package:flutter/material.dart';

import '../../../models/activity.model.dart';

class TripActivityList extends StatelessWidget {
  final List<Activity> activities;
  final Function deleteTripActivity;
  const TripActivityList(
      {super.key, required this.activities, required this.deleteTripActivity});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var activity = activities[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(activity.image!),
              ),
              title: Text(activity.name!),
              subtitle: Text(activity.city!),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  deleteTripActivity(activity.id);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Activité supprimée"),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 1),
                    action: SnackBarAction(
                      label: 'Annuler',
                      textColor: Colors.white,
                      onPressed: () {
                        print('undo');
                      },
                    ),
                  ));
                },
              ),
            ),
          );
        },
        itemCount: activities.length,
      ),
    );
  }
}
