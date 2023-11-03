import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_dyma_training_exercice/widgets/dyma_drawer.dart';
import 'package:training_dyma_training_exercice/widgets/dyma_loader.dart';
import '../../models/city_model.dart';
import '../../provider/city_provider.dart';
import '../home/widgets/card_city.dart';

class HomeView extends StatefulWidget {
  static const routerName = "/";

  // HomeView({super.key, required this.cities});
  HomeView({super.key});

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeView> {
  List cities = [];
  TextEditingController searchController = TextEditingController();
  // void switchChecked(city) {
  //   int index = widget.cities.indexOf(city);
  //   setState(() {
  //     cities[index]['checked'] = !cities[index]['checked'];
  //   });
  // }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<City> cities = Provider.of<List<City>>(context);
    // List<City> cities = Provider.of<CityProvider>(context).cities;
    CityProvider cityProvider = Provider.of<CityProvider>(context);
    List<City> filteredCities = Provider.of<CityProvider>(context)
        .getFilteredCities(searchController.text);
    return Scaffold(
      appBar: AppBar(
          // leading: const Icon(Icons.home),

          title: const Text('dymatrip'),
          actions: const [Icon(Icons.more_vert)]),
      drawer: const DymaDrawer(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                        hintText: 'Recherhcher une ville',
                        prefixIcon: Icon(Icons.search)),
                    onSubmitted: (value) {
                      print("filter");
                      print(value);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => setState(() => searchController.clear()),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 10),
                child: RefreshIndicator(
                    onRefresh: Provider.of<CityProvider>(context).fetchData,
                    child: cityProvider.isLoading
                        ? const DymaLoader()
                        : filteredCities.isNotEmpty
                            ?
                            //  Column(
                            //     crossAxisAlignment: CrossAxisAlignment.stretch,
                            //     children: cities.map((city) {
                            //       return CityCard(
                            //         city: city,
                            //         // checked: city['checked'],
                            //         // updateChecked: () => switchChecked(city),
                            //       );
                            //     }).toList())
                            ListView.builder(
                                itemCount: filteredCities.length,
                                itemBuilder: (_, i) => CityCard(
                                      city: filteredCities[i],
                                      // checked: city['checked'],
                                      // updateChecked: () => switchChecked(city),
                                    )
                                //   ;,
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                // children: cities.map((city) {
                                //   return CityCard(
                                //     city: city,
                                //     // checked: city['checked'],
                                //     // updateChecked: () => switchChecked(city),
                                //   );
                                // }).toList())

                                )
                            : const DymaLoader())),
          ),
        ],
      ),
    );
  }
}
