import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_dyma_training_exercice/models/trip.model.dart';
import 'package:training_dyma_training_exercice/provider/city_provider.dart';
import 'package:training_dyma_training_exercice/provider/trip_provider.dart';
import 'package:training_dyma_training_exercice/views/activity_form/activity_form_view.dart';
import 'package:training_dyma_training_exercice/views/trip/trip_view.dart';
import 'package:training_dyma_training_exercice/views/trips/trips_view.dart';
import 'package:training_dyma_training_exercice/views/widgets/NotFoundView.dart';
import 'package:training_dyma_training_exercice/views/city/city.dart';
import 'package:training_dyma_training_exercice/views/home/home.dart';
import 'data/data.dart' as data;
import 'models/activity.model.dart';
import 'models/city_model.dart';

void main() {
  runApp(DymaTrip());
}

class DymaTrip extends StatefulWidget {
  final List<City> cities = data.cities;

  DymaTrip({super.key});

  @override
  State<DymaTrip> createState() => _DymaTripState();
}

class _DymaTripState extends State<DymaTrip> {
  final CityProvider cityProvider = CityProvider();
  final TripProvider tripProvider = TripProvider();
  // void addTrip(Trip trip) {
  //   setState(() {
  //     trips.add(trip);
  //   });
  // }
  @override
  void initState() {
    cityProvider.fetchData();
    tripProvider.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider<CityProvider>
    return MultiProvider(
      // providers: [
      //   ChangeNotifierProvider(create: (context) {
      //     return CityProvider();
      //   }),
      //   ChangeNotifierProvider(create: (context) {
      //     return TripProvider();
      //   })
      // ],
      providers: [
        ChangeNotifierProvider.value(value: cityProvider),
        ChangeNotifierProvider.value(value: tripProvider)
      ],
      // create: (context) => CityProvider(),
      // create: (BuildContext context) {
      //   return data.cities;
      // }

      child: MaterialApp(
          // theme: ThemeData(primarySwatch: Colors.red, brightness: Brightness.dark),
          debugShowCheckedModeBanner: false,
          // home: City(),
          // home: HomeView(),
          // initialRoute: '/city',
          routes: {
            '/': (context) => HomeView(),
            // CityView.routeName: (context) => const CityView(),
            // TripsView.routeName: (context) => TripsView(),
            // TripView.routeName:(context)=>TripView(trip: trip, city: city)
            CityView.routeName: (_) => const CityView(),
            TripsView.routeName: (_) => TripsView(),
            TripView.routeName: (_) => const TripView(),
            ActivityFormView.routeName: (_) => const ActivityFormView()
            // '/city': (context) {
            //   return CityView();
            // }
          },
          // onGenerateRoute: (settings) {
          //   // if (settings.name == CityView.routeName) { 
          //   //   final City city = settings.arguments as City;
          //   //   return MaterialPageRoute(builder: (context) {
          //   //     return CityView(city: city);
          //   //  });
          //   // }
          //   switch (settings.name) {
          //     case CityView.routeName:
          //       final City city = settings.arguments as City;
          //       return MaterialPageRoute(builder: (context) {
          //         return CityView(city: city, addTrip: addTrip);
          //       });

          //     case TripsView.routeName:
          //       return MaterialPageRoute(builder: (context) {
          //         return TripsView(trips: trips);
          //       });
          //     case TripView.routeName:
          //       return MaterialPageRoute(builder: (context) {
          //         String? tripId =
          //             (settings.arguments as Map<String, String>)['tripId'];
          //         String? cityName =
          //             (settings.arguments as Map<String, String>)['cityName'];
          //         for (var i = 0; i < widget.cities.length; i++) {
          //           var element = widget.cities[i];
          //         }
          //         // print(widget.cities.firstWhere((city) => city.name == 'PARIS'));
          //         // print("000 ==========");
          //         return TripView(
          //           trip: trips.firstWhere((trip) => trip.id == tripId),
          //           city:
          //               widget.cities.firstWhere((city) => city.name == cityName),
          //         );
          //       });
          //     default:
          //   }
          // },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
                builder: (context) => const NotFoundView());
          }),
    );
  }
}

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         title: Text(" ESSAIE APP "),
//       ),
//       body: Row(
//         children: [
//           TextButton(
//               onPressed: () {
//                 print(" SALUT LE MONDE");
//               },
//               child: const Text(" Je suis un textButton")),
//           ElevatedButton(
//               onPressed: () {}, child: const Text(" SALUT LE MONDE ")),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(items: const [
//         BottomNavigationBarItem(label: 'Accueil', icon: Icon(Icons.home)),
//         BottomNavigationBarItem(label: 'Clients', icon: Icon(Icons.people))
//       ]),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: const <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text('Header du drawer'),
//             ),
//             ListTile(
//               title: Text('Elément 1'),
//             ),
//             ListTile(
//               title: Text('Elément 2'),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton:
//           // ignore: avoid_print
//           FloatingActionButton(
//         onPressed: () => {print(" Hello wolrd")},
//         child: const Icon(Icons.add),
//       ),
//     ));
//   }
// }
