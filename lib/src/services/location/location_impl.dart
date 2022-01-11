import 'dart:convert';

import 'package:flutter/services.dart';

import '../../constants/app_assets.dart';
import '../../models/city.dart';
import './location_service.dart';

class LocationImpl extends LocationService {
  @override
  Future<List<City>> fetchCity() async {
    final jsondata = await rootBundle.loadString(AppAssets.data);
    final list = json.decode(jsondata) as List<dynamic>;
    var cities = list.map((e) => City.fromJson(e)).toList();
    return cities;
  }
}
