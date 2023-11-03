import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_dyma_training_exercice/provider/city_provider.dart';
import 'package:training_dyma_training_exercice/provider/trip_provider.dart';
import 'package:training_dyma_training_exercice/views/home/home.dart';
import 'package:training_dyma_training_exercice/widgets/dyma_drawer.dart';
import '../../models/city_model.dart';
import '../../views/city/widgets/trip_overview.dart';
import '../../models/activity.model.dart';
import '../../models/trip.model.dart';
import '../activity_form/activity_form_view.dart';
import 'widgets/activity_list.dart';
import 'widgets/trip_activity_list.dart';

class CityView extends StatefulWidget {
  // final City city;
  // final Function addTrip;
  static const String routeName = '/city';
  // List<Activity> get activities {
  //   return city.activities;
  // }

  const CityView({super.key});
  showContext({required BuildContext context, required List<Widget> children}) {
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.landscape) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      );
    } else {
      return Column(
        children: children,
      );
    }
  }

  @override
  State<CityView> createState() => _CityState();
}

class _CityState extends State<CityView> {
  // Trip mytrip = Trip(activities: [], city: 'Paris', date: DateTime(2020));
  Trip? mytrip;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mytrip = Trip(city: "", activities: [], date: DateTime.now());
    index = 0;
  }

  void setDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now().add(const Duration(days: 1)),
            firstDate: DateTime.now(),
            lastDate: DateTime(2024))
        .then((newDate) {
      if (newDate != null) {
        setState(() {
          mytrip!.date = newDate;
        });
      }
    });
  }

  void switchIndex(newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  void toggleActivity(Activity activity) {
    setState(() {
      mytrip!.activities.contains(activity)
          ? mytrip!.activities.remove(activity)
          : mytrip!.activities.add(activity);
    });
  }

  void deleteTripActivity(Activity activity) {
    setState(() {
      mytrip!.activities.remove(activity);
    });
  }

  // List<Activity> get tripActivities {
  //   return widget.activities
  //       .where((activity) => mytrip.activities.contains(activity.id))
  //       .toList();
  // }

  double get amount {
    return mytrip!.activities.fold(0.0, (acc, cur) {
      // final activity =
      //     widget.activities.firstWhere((activity) => activity.id == cur);
      return acc + cur.price!;
    });
  }

  Future<void> saveTrip(String cityName) async {
    final result = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text(" Voulez-vous sauvegarder?"),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.all(5.0),
                          textStyle: const TextStyle(fontSize: 12),
                          backgroundColor:
                              const Color.fromARGB(26, 46, 45, 45)),
                      onPressed: () {
                        Navigator.pop(context, 'cancel');
                      },
                      child: const Text(
                        "Annuler",
                        style: TextStyle(fontSize: 12),
                      )),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(5.0),
                        textStyle: const TextStyle(fontSize: 12),
                        backgroundColor: Colors.blueAccent),
                    onPressed: () {
                      Navigator.pop(context, 'save');
                    },
                    child: const Text(
                      "Sauvegarder",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              )
            ],
          );
        });
    // ignore: use_build_context_synchronously

    if (mytrip?.date == null) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (constext) {
            return AlertDialog(
              title: const Text("Attention"),
              content: const Text('Vous n\'avez pas entré la date'),
              actions: [
                TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            );
          });
    }
    if (result == 'save') {
      // widget.addTrip(mytrip);
      mytrip!.city = cityName;
      // ignore: use_build_context_synchronousl
      Provider.of<TripProvider>(context, listen: false).addTrip(mytrip!);
      Navigator.pushNamed(context, HomeView.routerName);
    }
    // ignore: use_build_context_synchronously
  }

  @override
  Widget build(BuildContext context) {
    // final City city = ModalRoute.of(context)!.settings.arguments as City;
    String cityName = ModalRoute.of(context)!.settings.arguments as String;
    // City city = Provider.of<CityProvider>(context)
    //     .cities
    //     .firstWhere((city) => city.name == cityName);
    City city = Provider.of<CityProvider>(context).getCityByName(cityName);
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.chevron_left),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        title: const Text('Organisation voyage'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(
                  context, ActivityFormView.routeName,
                  arguments: cityName),
              icon: const Icon(Icons.add))
        ],
        // actions: const [Icon(Icons.more_vert)],
      ),
      drawer: const DymaDrawer(),
      body: Container(
          // padding: const EdgeInsets.all(10),
          // child: ListView.separated(
          //   itemBuilder: (context, index) {
          //     return ActivityCard(activity: widget.activities[index]);
          //   },
          //   separatorBuilder: (context, index) {
          //     return Divider();
          //   },
          //   itemCount: widget.activities.length,
          // ),
          // child: GridView.builder(
          //   gridDelegate:
          //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          //   itemBuilder: (context, index) {
          //     return ActivityCard(activity: widget.activities[index]);
          //   },
          //   itemCount: widget.activities.length,
          // ),
          child: widget.showContext(context: context, children: [
        TripOverview(
          setDate: setDate,
          trip: mytrip!,
          // cityName: widget.city.name,
          cityName: city.name,
          amount: amount,
          cityImage: city.image,
        ),
        Expanded(
          // child: GridView.count(
          //   mainAxisSpacing: 1,
          //   crossAxisSpacing: 1,
          //   crossAxisCount: 2,
          //   children: widget.activities
          //       .map((activity) => ActivityCard(activity: activity))
          //       .toList(),
          // ),
          child: index == 0
              ? ActivityList(
                  activities: city.activities,
                  selectedActivities: mytrip!.activities,
                  toggleActivity: toggleActivity,
                )
              : TripActivityList(
                  activities: mytrip!.activities,
                  deleteTripActivity: deleteTripActivity,
                  key: UniqueKey(),
                ),
        ),
      ])),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.forward),
        onPressed: () {
          saveTrip(city.name);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Découverte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            label: 'Mes activités',
          )
        ],
        onTap: switchIndex,
      ),
    );
  }
}
