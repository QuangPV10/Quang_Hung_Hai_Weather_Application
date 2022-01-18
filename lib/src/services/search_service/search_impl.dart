import 'dart:convert';

import 'package:flutter/services.dart';

import '../../constants/app_assets.dart';
import '../../models/city.dart';
import './search_service.dart';

class SearchImpl extends SearchService {
  @override
  Future<List<City>> fetchAllCity() async {
    final jsonData = await rootBundle.loadString(AppAsset.data);
    Iterable responseList = json.decode(jsonData);
    var cities =
        List<City>.from(responseList.map((model) => City.fromJson(model)));
    return cities;
  }
}
