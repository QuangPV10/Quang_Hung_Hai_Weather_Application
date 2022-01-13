import 'dart:convert';

import 'package:flutter/services.dart';

import '../../constants/app_assets.dart';
import '../../models/city.dart';
import './location_service.dart';

class LocationImpl extends LocationService {
  @override
  Future<List<City>> fetchCity() async {
    final jsondata = await rootBundle.loadString(AppAssets.data);
    Iterable responseList = json.decode(jsondata);
    var cities =
        List<City>.from(responseList.map((model) => City.fromJson(model)));
    return cities;
  }
}
