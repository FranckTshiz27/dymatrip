import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training_dyma_training_exercice/views/city/widgets/trip_overview_city.dart';
import '../../../models/trip.model.dart';

class TripOverview extends StatelessWidget {
  final VoidCallback setDate;
  final Trip trip;
  final String cityName;
  final double amount;
  final String cityImage;

  const TripOverview(
      {super.key,
      required this.setDate,
      required this.trip,
      required this.cityName,
      required this.amount,
      required this.cityImage});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;
    return Container(
      // padding: const EdgeInsets.all(10),
      // height: 300,
      width:
          orientation == Orientation.landscape ? size.width * 0.5 : size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TripOverViewCity(cityName: cityName, cityImage: cityImage),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    trip.date != null
                        ? DateFormat('d/M/y').format(trip.date!)
                        : 'Sélectionnez une date',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                ElevatedButton(
                    onPressed: setDate,
                    child: const Text("Sélectionnez une date "))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Text('Montant / personne $amount \$')),
                Text('$amount \$')
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
