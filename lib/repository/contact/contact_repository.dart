import 'package:nguyen_ngoc_thang_nexlab/data/data.dart';
import 'package:nguyen_ngoc_thang_nexlab/models/models.dart';

abstract class ContactRepository {
  Future<List<User>> fetchContacts({
    required int page,
    Map<String, dynamic>? filters,
  });

  Future<bool> deleteContact({required int userId});
}

class ContactRepositoryImpl implements ContactRepository {
  final HttpClient httpClient = HttpClient();

  @override
  Future<List<User>> fetchContacts({
    required int page,
    Map<String, dynamic>? filters,
  }) async {
    try {
      String url = '/users';

      if (filters != null && filters.containsKey('q')) {
        url = '/users/search';
      }

      final response = await httpClient.get(
        url,
        queryParameters: {...?filters},
      );
      if (response['users'] == null) {
        throw Exception('Failed to load contacts');
      }

      final List<dynamic> data = response['users'] as List<dynamic>;
      return data
          .map((dynamic e) => User.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteContact({required int userId}) async {
    try {
      final response = await httpClient.delete('/users/$userId');

      if (response['id'] == null ||
          (response['id'] && !response['isDeleted'])) {
        throw Exception('Failed to delete contact');
      }

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
