import 'dart:convert';

import 'package:flutter/services.dart';

import '../../models/city.dart';
import './location_service.dart';

class LocationImpl extends LocationService {
  @override
  Future<List<City>> fetchCity() async {
    final jsondata = await rootBundle.loadString('assets/data/city_list.json');
    final list = json.decode(jsondata) as List<dynamic>;
    var cities = list.map((e) => City.fromJson(e)).toList();
    return cities;
  }
}
