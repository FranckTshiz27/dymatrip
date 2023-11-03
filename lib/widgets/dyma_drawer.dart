import 'package:flutter/material.dart';
import 'package:training_dyma_training_exercice/views/trips/trips_view.dart';

import '../views/home/home.dart';

class DymaDrawer extends StatelessWidget {
  const DymaDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            //     child: Container(
            //   color: Theme.of(context).primaryColor,
            //   child: const Text(
            //     "DymaTrip",
            //     style: TextStyle(color: Colors.white, fontSize: 30),
            //   ),
            // )
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            //     child: Container(
            //   color: Theme.of(context).primaryColor,
            //   child: const Text(
            //     "DymaTrip",
            //     style: TextStyle(color: Colors.white, fontSize: 30),
            //   ),
            // )
            child: const Text(
              "DymaTrip",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Accueil"),
            onTap: () {
              Navigator.pushNamed(context, HomeView.routerName);
            },
          ),
          Divider(
            color: Colors.grey[600],
          ),
          ListTile(
            leading: Icon(Icons.flight),
            title: Text("Mes voyages"),
            onTap: () {
              Navigator.pushNamed(context, TripsView.routeName);
            },
          )
        ],
      ),
    );
  }
}
