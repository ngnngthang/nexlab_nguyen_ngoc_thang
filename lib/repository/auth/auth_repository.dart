import 'package:nguyen_ngoc_thang_nexlab/data/data.dart';

abstract class AuthRepository {
  Future<bool> signIn({required String username, required String password});
  Future<bool> signOut();
}

class AuthRepositoryImpl implements AuthRepository {
  final HttpClient httpClient = HttpClient();

  @override
  Future<bool> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final response = await httpClient.post(
        '/auth/login',
        body: {'username': username, 'password': password},
      );

      if (response['accessToken'] == null) {
        throw Exception('Failed to sign in');
      }

      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      return true;
    } catch (error) {
      rethrow;
    }
  }
}
