import 'dart:collection';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:training_dyma_training_exercice/models/activity.model.dart';
import '../models/city_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CityProvider with ChangeNotifier {
  List<City> _cities = [];
  final String host = 'http://10.0.2.2:80';
  bool isLoading = false;
  UnmodifiableListView<City> get cities => UnmodifiableListView(_cities);

  UnmodifiableListView<City> getFilteredCities(String filter) =>
      UnmodifiableListView(
        _cities
            .where(
              (city) => city.name.toLowerCase().startsWith(
                    filter.toLowerCase(),
                  ),
            )
            .toList(),
      );
  City getCityByName(String? cityName) =>
      cities.firstWhere((city) => city.name == cityName);

  Future<void> fetchData() async {
    try {
      isLoading = true;
      http.Response response = await http.get(Uri.parse('$host/api/cities'));
      _cities = (json.decode(response.body) as List)
          .map((cityJson) => City.fromJson(cityJson))
          .toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

  Future<void> addActivityTocity(Activity newActivity) async {
    String? cityId = getCityByName(newActivity.city).id;
    try {
      http.Response response = await http.post(
        Uri.parse('$host/api/city/$cityId/activity'),
        headers: {'content-type': 'application/json'},
        body: json.encode(
          newActivity.toJson(),
        ),
      );

      if (response.statusCode == 200) {
        int index = _cities.indexWhere((city) => city.id == cityId);
        _cities[index] = City.fromJson(
          json.decode(response.body),
        );

        notifyListeners();
      }
    } catch (e) {
      print('errorororor $e');
      rethrow;
    }
  }

  Future<dynamic?> verifyIfActivityNameIsUnique(
      String? cityName, String? activityName) async {
    try {
      City city = getCityByName(cityName);
      http.Response response = await http.get(Uri.parse(
          '$host/api/city/${city.id}/activities/verify/$activityName'));

      if (response.statusCode != 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('error $e ');
      rethrow;
    }
  }

  Future<String> uploadImage(File? pickedImage) async {
    try {
      var request =
          http.MultipartRequest("POST", Uri.parse('$host/api/activity/image'));

      request.files.add(
        http.MultipartFile.fromBytes(
          "activity",
          pickedImage!.readAsBytesSync(),
          filename: basename(pickedImage.path),
          contentType: MediaType("multipart", "form-data"),
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        // print(String.fromCharCode(responseData));
        return json.decode(responseData);
      } else {
        throw 'error';
      }
    } catch (e) {
      rethrow;
    }
  }
}
