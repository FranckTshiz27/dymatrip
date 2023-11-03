import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:training_dyma_training_exercice/provider/trip_provider.dart';

import '../../../models/activity.model.dart';
import '../../../models/trip.model.dart';

class TripActivityList extends StatelessWidget {
  // final List<Activity> activities;
  final String? tripId;
  final ActivityStatus filter;
  const TripActivityList(
      {super.key, required this.filter, required this.tripId});

  @override
  Widget build(BuildContext context) {
    final Trip trip = Provider.of<TripProvider>(context).getById(tripId);
    final List<Activity> activities = trip.activities
        .where((activity) => (activity.status == filter))
        .toList();

    return Consumer<TripProvider>(builder: (context, tripProvider, child) {
      return ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, i) {
            var activity = activities[i];
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: filter == ActivityStatus.ongoing
                    ? Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.greenAccent[700],
                          ),
                          child: const Icon(Icons.check),
                        ),
                        key: ValueKey(activity.id),
                        child: Card(
                          child: ListTile(
                            title: Text(activity.name!),
                          ),
                        ),
                        // onDismissed: (_) {
                        //   Provider.of<TripProvider>(context, listen: false)
                        //       .updateTrip(trip, activity.id);
                        //   // Provider.of<TripProvider>(context, listen: false)
                        //   //     .setActivityToDone(activity);
                        // },
                        confirmDismiss: (_) {
                          return Provider.of<TripProvider>(context,
                                  listen: false)
                              .updateTrip(trip, activity.id!)
                              .then((_) => true)
                              .catchError((_) => false);
                        },
                      )
                    : Card(
                        child: ListTile(
                          title: Text(
                            activity.name!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ));
          });
    });
  }
}
