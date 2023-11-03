enum ActivityStatus { ongoing, done }

class Activity {
  String? name;
  String? image;
  String? id;
  String? city;
  double? price;
  ActivityStatus status;
  LocationActivity? location;
  Activity({
    this.location,
    required this.name,
    required this.image,
    this.id,
    required this.city,
    required this.price,
    this.status = ActivityStatus.ongoing,
  });

  Activity.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        image = json['image'],
        city = json['city'],
        price = json['price'].toDouble(),
        status =
            json['status'] == 0 ? ActivityStatus.ongoing : ActivityStatus.done;

  // Map<String, dynamic> toJson() {
  //   return {
  //     '-id': id,
  //     'name': name,
  //     'image': image,
  //     'city': city,
  //     'price': price,
  //     'status': status == ActivityStatus.ongoing ? 0 : 1
  //   };
  // }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> value = {
      '-id': id,
      'name': name,
      'image': image,
      'city': city,
      'price': price,
      'status': status == ActivityStatus.ongoing ? 0 : 1
    };

    if (id != null) {
      value['_id'] = id;
    }

    return value;
  }
}

class LocationActivity {
  String? address;
  double? longititude;
  double? latitude;
  LocationActivity({this.address, this.longititude, this.latitude});
}
