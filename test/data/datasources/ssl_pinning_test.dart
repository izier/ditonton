import 'package:ditonton/data/datasources/ssl_pinning.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';
  
  group('SSL Pinning Test', () {
    test('must return statuscode 200 when succeed connecting', () async {
      final http.Client client = await SSLPinning.customHttpClient(isTestMode: true);
      final response = await client.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY'));
      expect(response.statusCode, 200);
    });
  });
}