import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:training_dyma_training_exercice/models/activity.model.dart';
import '../models/trip.model.dart';
import 'package:http/http.dart' as http;

class TripProvider with ChangeNotifier {
  final String host = 'http://10.0.2.2:80';
  List<Trip> _trips = [];
  bool isLoading = false;

  UnmodifiableListView<Trip> get trips => UnmodifiableListView(_trips);

  Future<void> addTrip(Trip? trip) async {
    try {
      http.Response response = await http.post(Uri.parse('$host/api/trip'),
          body: json.encode(
            trip!.toJson(),
          ),
          headers: {
            'content-type': 'application/json',
          });

      if (response.statusCode == 200) {
        _trips.add(
          Trip.fromJson(
            json.decode(response.body),
          ),
        );
      }
      _trips.add(trip);
      notifyListeners();
    } catch (e) {
      print("error exception");
      print(e);
      rethrow;
    }
  }

  Trip getById(String? tripId) =>
      _trips.firstWhere((trip) => (trip.id == tripId));

  void setActivityToDone(Activity activity) {
    activity.status = ActivityStatus.done;
    notifyListeners();
  }

  Future<void> fetchData() async {
    try {
      isLoading = true;
      http.Response response = await http.get(Uri.parse('$host/api/trips'));

      if (response.statusCode == 200) {
        _trips = (json.decode(response.body) as List)
            .map((tripJson) => Trip.fromJson(tripJson))
            .toList();
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
    }
  }

  Future<void> updateTrip(Trip trip, String activityId) async {
    try {
      Activity activity =
          trip.activities.firstWhere((activity) => activity.id == activityId);

      activity.status = ActivityStatus.done;

      http.Response response = await http.put(
        Uri.parse('$host/api/trips'),
        body: json.encode(trip.toJson()),
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode != 200) {
        activity.status = ActivityStatus.ongoing;
        throw const HttpException('error');
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
