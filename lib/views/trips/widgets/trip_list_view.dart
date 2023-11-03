import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:training_dyma_training_exercice/views/trip/trip_view.dart';

import '../../../models/trip.model.dart';

class TripList extends StatelessWidget {
  final List<Trip> trips;

  TripList({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, i) {
        var trip = trips[i];
        return ListTile(
          title: Text(trip.city),
          subtitle: Text(trip.date != null
              ? DateFormat('d/M/y').format(trip.date)
              : "choisissez une date"),
          trailing: const Icon(Icons.info),
          onTap: () {
            Navigator.pushNamed(context, TripView.routeName,
                arguments: {'tripId': trip.id, 'cityName': trip.city});
          },
        );
      },
    );
  }
}
