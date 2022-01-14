import '../../models/city.dart';

abstract class LocationService {
  LocationService();

  Future<List<City>>? fetchAllCity();
}
