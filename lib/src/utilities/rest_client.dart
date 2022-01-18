import 'package:global_configuration/global_configuration.dart';
import 'package:quang_hung_hai_weather_application/src/services/http_client.dart';


mixin HttpClientServices {
  static HttpClient httpClient() {
    final baseUrl = GlobalConfiguration().getValue('baseUrl').toString();
    final apiKey = GlobalConfiguration().getValue('apiKey');
    return HttpClient(baseUrl: baseUrl, apiKey: apiKey);
  }
}