import 'package:flutter/material.dart';
import '../../../models/city_model.dart';
import '../../city/city.dart';

class CityCard extends StatelessWidget {
  // final String name;
  // final String image;
  // final bool checked;
  // final VoidCallback updateChecked;
  final City city;

  // const CityCard(
  //     {super.key,
  //     required this.image,
  //     required this.name,
  //     required this.checked,
  //     required this.updateChecked});
  const CityCard({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: SizedBox(
          height: 150,
          child: Stack(
            fit: StackFit.expand,
            children: [
              GestureDetector(
                onTap: () {
                  // updateChecked();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return CityView();
                  //     },
                  //   ),
                  // );
                  Navigator.pushNamed(context, '/city', arguments: city.name);
                },
                child: Hero(
                    tag: city.name,
                    child: Image.network(city.image, fit: BoxFit.cover)),
              ),
              // Ink.image(
              //   fit: BoxFit.cover,
              //   // image: AssetImage(
              //   //   city.image,
              //   // ),
              //   image: NetworkImage(
              //     city.image,
              //   ),
              //   child: InkWell(
              //     onTap: () {
              //       // updateChecked();
              //       // Navigator.push(
              //       //   context,
              //       //   MaterialPageRoute(
              //       //     builder: (context) {
              //       //       return CityView();
              //       //     },
              //       //   ),
              //       // );
              //       Navigator.pushNamed(context, '/city', arguments: city.name);
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.all(10),
              //   child: Column(
              //     children: [
              //       Expanded(
              //           child: Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Icon(
              //             checked ? Icons.star : Icons.star_border,
              //             size: 40,
              //             color: Colors.white,
              //           )
              //         ],
              //       )),
              //       Row(
              //         children: [
              //           Text(
              //             name,
              //             style: const TextStyle(
              //                 color: Colors.white, fontSize: 30),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // )
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.black54,
                  child: Text(
                    city.name,
                    style: const TextStyle(fontSize: 35, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
