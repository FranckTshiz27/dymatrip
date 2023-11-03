import 'package:flutter/material.dart';
import 'dart:async';
import '../../../models/activity.model.dart';

Future<LocationActivity> showInputAutoComplete(BuildContext context) async {
  return await showDialog(context: context, builder: (_) => InputAddress());
}

class InputAddress extends StatefulWidget {
  const InputAddress({super.key});

  @override
  State<InputAddress> createState() => _InputAddressState();
}

class _InputAddressState extends State<InputAddress> {
  List<dynamic> _places = [];
  Timer? _debouncer;
  Future<void> _searchAddress(String value) async {
    if (_debouncer!.isActive == true) _debouncer!.cancel();
    _debouncer = Timer(
      Duration(seconds: 1),
      () {
        print(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Rechercher',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _searchAddress,
              ),
              Positioned(
                  top: 5,
                  right: 3,
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.clear))),
            ],
          )
          // ListView.builder(itemCount: _places.lenth,itemBuilder: (contex,i){
          //   var place = _places[i]
          //   return ListTile(leading: Icon(Icons.place),title: Text(place.),);

          // },)
        ],
      ),
    );
  }
}
