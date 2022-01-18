import 'package:http/http.dart' as http;

class HttpClient {
  final String? baseUrl;
  final String? apiKey;
  HttpClient({this.baseUrl, this.apiKey});
  Future<String> getData(String path, {Map<String, dynamic>? params}) async {
    final baseParam = <String, dynamic>{
    };
    baseParam.putIfAbsent('appid', () => apiKey);

    if (params != null) {
      baseParam.addAll(params);
    }
    final uri = Uri(
      scheme: 'https',
      host: baseUrl,
      path: path,
    );
    final getData = await http.get(uri);
    if (getData.statusCode == 200) {
      return getData.body;
    } else {
      return '';
    }
  }
}
