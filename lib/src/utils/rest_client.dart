import 'package:global_configuration/global_configuration.dart';

import '../services/http_client.dart';


mixin HttpClientServices {
  static HttpClient httpClient() {
    final baseUrl = GlobalConfiguration().getValue('baseUrl');
    final apiKey = GlobalConfiguration().getValue('apiKey');
    return HttpClient(baseUrl: baseUrl, apiKey: apiKey);
  }
}