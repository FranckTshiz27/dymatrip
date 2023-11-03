import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../models/city_model.dart';

class TripCityBar extends StatelessWidget {
  final City city;

  const TripCityBar({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          // Image.asset(
          //   city.image,
          //   fit: BoxFit.cover,
          // )

          Image(
            image: NetworkImage(city.image),
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black38,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ))
                  ],
                ),
                Expanded(
                    child: Center(
                  child: Text(city.name,
                      style:
                          const TextStyle(fontSize: 30, color: Colors.white)),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
