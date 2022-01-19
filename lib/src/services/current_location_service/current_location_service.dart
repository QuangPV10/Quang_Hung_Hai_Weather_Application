import 'package:location/location.dart';

abstract class CurrentLocationService {
  CurrentLocationService();

  Future<LocationData> getCurrentLocation();
}
