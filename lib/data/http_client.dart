import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:nguyen_ngoc_thang_nexlab/utils/utils.dart';

class HttpClient {
  final String baseUrl = 'https://dummyjson.com';

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final queries = buildQueryString(queryParameters);
    final url = Uri.parse(baseUrl + path + queries);

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw HttpException(
          'Request failed with status: ${response.statusCode}',
          uri: url,
        );
      }

      return jsonDecode(response.body) as Map<String, dynamic>;
    } on SocketException catch (_) {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final queries = buildQueryString(queryParameters);
    final url = Uri.parse(baseUrl + path + queries);

    try {
      final response = await http.post(url, body: body);

      if (response.statusCode != 200) {
        throw HttpException(
          'Request failed with status: ${response.statusCode}',
          uri: url,
        );
      }

      final result = jsonDecode(response.body);

      return result as Map<String, dynamic>;
    } on SocketException catch (_) {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final queries = buildQueryString(queryParameters);
    final url = Uri.parse(baseUrl + path + queries);

    try {
      final response = await http.put(url, body: body);

      if (response.statusCode != 200) {
        throw HttpException(
          'Request failed with status: ${response.statusCode}',
          uri: url,
        );
      }

      return jsonEncode(response.body) as Map<String, dynamic>;
    } on SocketException catch (_) {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final queries = buildQueryString(queryParameters);
    final url = Uri.parse(baseUrl + path + queries);

    try {
      final response = await http.delete(url, body: body);

      if (response.statusCode != 200) {
        throw HttpException(
          'Request failed with status: ${response.statusCode}',
          uri: url,
        );
      }

      return jsonEncode(response.body) as Map<String, dynamic>;
    } on SocketException catch (_) {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
