import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_dyma_training_exercice/views/trips/widgets/trip_list_view.dart';
import 'package:training_dyma_training_exercice/widgets/dyma_drawer.dart';
import 'package:training_dyma_training_exercice/widgets/dyma_loader.dart';

import '../../models/trip.model.dart';
import '../../provider/trip_provider.dart';

// class TripsView extends StatefulWidget {
//   static const String routeName = '/trips';
//   final List<Trip> trips;

//   const TripsView({super.key, required this.trips});

//   @override
//   State<TripsView> createState() => _TripsViewState();
// }

class TripsView extends StatelessWidget {
  static const String routeName = '/trips';
  @override
  Widget build(BuildContext context) {
    TripProvider tripProvider = Provider.of<TripProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Mes voyages'),
            bottom: const TabBar(tabs: [
              Tab(
                text: 'A venir',
              ),
              Tab(
                text: 'Passés',
              )
            ]),
          ),
          drawer: const DymaDrawer(),
          body: !tripProvider.isLoading
              ? tripProvider.trips.isNotEmpty
                  ? TabBarView(children: [
                      TripList(
                          trips: tripProvider.trips
                              .where(
                                  (trip) => DateTime.now().isAfter(trip.date))
                              .toList()),
                      TripList(
                          trips: tripProvider.trips
                              .where(
                                  (trip) => DateTime.now().isBefore(trip.date))
                              .toList()),
                    ])
                  : Container(
                      alignment: Alignment.center,
                      child: Text("Aucun voyage pour le moment"),
                    )
              : const DymaLoader()),
    );
  }
}
