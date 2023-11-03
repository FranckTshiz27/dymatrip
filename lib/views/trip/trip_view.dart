import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_dyma_training_exercice/provider/city_provider.dart';
import 'package:training_dyma_training_exercice/views/trip/widgets/trip_activities.dart';
import 'package:training_dyma_training_exercice/views/trip/widgets/trip_city_bar.dart';
import 'package:training_dyma_training_exercice/views/trip/widgets/trip_weather.dart';

import '../../models/city_model.dart';

// class TripView extends StatefulWidget {
//   static const String routeName = '/trip';

//   // final Trip trip;
//   // final City city;

//   const TripView({super.key, required this.trip, required this.city});

//   @override
//   State<TripView> createState() => _TripViewState();
// }

class TripView extends StatelessWidget {
  static const String routeName = '/trip';

  const TripView({super.key});
  @override
  Widget build(BuildContext context) {
    final String? cityName = (ModalRoute.of(context)!.settings.arguments
        as Map<String?, String?>)['cityName'];
    final String? tripId = (ModalRoute.of(context)!.settings.arguments
        as Map<String?, String?>)['tripId'];
    final City city = Provider.of<CityProvider>(context, listen: false)
        .getCityByName(cityName);
    // final Trip trip =
    //     Provider.of<TripProvider>(context, listen: false).getById(tripId);

    return Scaffold(
      // body: Column(
      //   children: [
      //     Container(
      //       height: 200,
      //       color: Colors.red,
      //     ),
      //     Container(
      //       height: 200,
      //       color: Colors.blue,
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TripCityBar(city: widget.city),
            TripCityBar(city: city),
            TripWeather(
              cityName: cityName,
            ),
            // TripActivities(activities: widget.trip.activities)
            TripActivities(tripId: tripId)
          ],
        ),
      ),
    );
  }
}
