import 'package:global_configuration/global_configuration.dart';

import '../../models/city.dart';
import 'search_service.dart';

class SearchServiceImpl extends SearchService {
  @override
  Future<List<City>> fetchAllCity() async {
    final jsonData = GlobalConfiguration().getValue('cityList') as List<dynamic>;
    var cities =
        List<City>.from(jsonData.map((model) => City.fromJson(model)));
    return cities;
  }
}
