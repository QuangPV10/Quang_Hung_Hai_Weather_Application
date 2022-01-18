import '../../models/city.dart';

abstract class SearchService {
  SearchService();

  Future<List<City>>? fetchAllCity();
}
