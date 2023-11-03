import 'package:training_dyma_training_exercice/models/city_model.dart';

import '../models/activity.model.dart';
import '../models/trip.model.dart';

List<City> cities = [
  City(name: 'PARIS', image: 'assets/images/paris.jpg', activities: [
    Activity(
        image: 'assets/images/activities/louvre.jpg',
        name: 'Le Louvre',
        id: 'a1',
        city: 'Paris',
        price: 50),
    Activity(
        image: 'assets/images/activities/chaumont.jpg',
        name: 'Les buttes Chaumont',
        id: 'a2',
        city: 'Paris',
        price: 10),
    Activity(
        image: 'assets/images/activities/dame.jpg',
        name: 'Notre Dame',
        id: 'a3',
        city: 'Paris',
        price: 15),
    Activity(
        image: 'assets/images/activities/defense.jpg',
        name: 'La Défense',
        id: 'a4',
        city: 'Paris',
        price: 20),
  ]),
  City(name: 'LONDRE', image: 'assets/images/londre.jpg', activities: [
    Activity(
        image: 'assets/images/activities/louvre.jpg',
        name: 'Boston',
        id: 'a1',
        city: 'Boston',
        price: 50),
    Activity(
        image: 'assets/images/activities/chaumont.jpg',
        name: 'Malabard',
        id: 'a2',
        city: 'Malabard',
        price: 10),
    Activity(
        image: 'assets/images/activities/dame.jpg',
        name: 'Indonesie',
        id: 'a3',
        city: 'Indonesie',
        price: 15),
    Activity(
        image: 'assets/images/activities/defense.jpg',
        name: 'Bruxelles',
        id: 'a4',
        city: 'Bruxelles',
        price: 20),
  ]),
  City(name: 'BRUXELLE', image: 'assets/images/bruxelle.jpeg', activities: [
    Activity(
        image: 'assets/images/activities/louvre.jpg',
        name: 'Kinshasa',
        id: 'a1',
        city: 'Kinshasa',
        price: 50),
    Activity(
        image: 'assets/images/activities/chaumont.jpg',
        name: 'Masina',
        id: 'a2',
        city: 'Masina',
        price: 10),
    Activity(
        image: 'assets/images/activities/dame.jpg',
        name: 'Brazzaville',
        id: 'a3',
        city: 'Brazzaville',
        price: 15),
    Activity(
        image: 'assets/images/activities/defense.jpg',
        name: 'La Défense',
        id: 'a4',
        city: 'Paris',
        price: 20),
  ]),
];

List<Trip> trips = [
  Trip(
      city: 'PARIS',
      activities: [
        Activity(
          image: 'assets/images/activities/louvre.jpg',
          name: 'Kinshasa',
          id: 'a1',
          city: 'Kinshasa',
          price: 50,
          status: ActivityStatus.done,
        ),
        Activity(
            image: 'assets/images/activities/chaumont.jpg',
            name: 'Masina',
            id: 'a2',
            city: 'Masina',
            price: 10),
        Activity(
            image: 'assets/images/activities/dame.jpg',
            name: 'Brazzaville',
            id: 'a3',
            city: 'Brazzaville',
            price: 15),
        Activity(
            image: 'assets/images/activities/defense.jpg',
            name: 'La Défense',
            id: 'a4',
            city: 'Paris',
            price: 20),
      ],
      date: DateTime.now().add(const Duration(days: 1))),
  Trip(
      city: 'LONDRE',
      activities: [],
      date: DateTime.now().add(const Duration(days: 2))),
  Trip(
      city: 'BRUXELLE',
      activities: [],
      date: DateTime.now().subtract(const Duration(days: 1)))
];
