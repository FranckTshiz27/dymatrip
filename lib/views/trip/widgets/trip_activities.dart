import 'package:flutter/material.dart';
import 'package:training_dyma_training_exercice/models/activity.model.dart';

import 'trip_activity_list.dart';

class TripActivities extends StatelessWidget {
  // final List<Activity> activities;
  final String? tripId;
  const TripActivities({super.key, this.tripId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                child: TabBar(indicatorColor: Colors.blue[100], tabs: const [
                  Tab(
                    text: 'En cours',
                  ),
                  Tab(
                    text: 'Terminé',
                  )
                ]),
              ),
              SizedBox(
                height: 1000,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TripActivityList(
                        // activities: activities
                        //     .where((activity) =>
                        //         activity.status == ActivityStatus.ongoing)
                        //     .toList(),
                        filter: ActivityStatus.ongoing,
                        tripId: tripId),
                    TripActivityList(
                        // activities: activities
                        //     .where((activity) =>
                        //         activity.status == ActivityStatus.done)
                        //     .toList(),
                        filter: ActivityStatus.done,
                        tripId: tripId)
                  ],
                ),
              )
            ],
          )),
    );
  }
}
