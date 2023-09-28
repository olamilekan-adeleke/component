import '../../app/locator.dart';
import 'authentication_local_storage_data_source.dart';

class SessionManager {
  SessionManager._internal();
  static final SessionManager instance = SessionManager._internal();
  factory SessionManager() => instance;

  static final AuthLocalStorageDataSource _authLocalStorageDataSource =
      getIt<AuthLocalStorageDataSource>();

  static final Map<String, dynamic> _loginData = {};

  String? _token;
  Future<String> get bearerToken async {
    return (await getSavedToken) ?? _token ?? _loginData['token'] ?? '';
  }

  Future<String> get token async {
    return (await bearerToken).replaceAll('Bearer ', '').toString().trim();
  }

  String get email => _loginData['data']['email'] ?? '';

  Future<void> setLoginData(Map<String, dynamic> data) async {
    _loginData.clear();
    _loginData.addAll(data);
    await _authLocalStorageDataSource.saveToken(data['token']);
  }

  Future<void> setToken(String token) async {
    _token = token;
    await _authLocalStorageDataSource.saveToken(token);
  }

  Future<String?> get getSavedToken async {
    return await _authLocalStorageDataSource.getToken();
  }
}
