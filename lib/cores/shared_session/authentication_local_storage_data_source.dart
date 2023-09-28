import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

import '../exception/base_exception.dart';

abstract class AuthLocalStorageDataSource {
  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> clearToken();

  Future<void> saveLoginData(String email, String password);

  Future<AuthLocallySavedDetails> getSavedLoginData();

  Future<bool> checkIfLoginDataIsSaved();

  Future<bool> toggleBiometric(bool value);

  Future<bool> checkBiometricToggleState();

  Future<bool> toggleDarkMode(bool value);

  Future<bool> checkDarkModeToggleState();

  void clearLoginData();

  Future<bool> canUseThumbPrint();

  Future<bool> authenticateWithBioMetric();

  Future<bool> isNotFirstTimeUsingApp();
}

class AuthLocalStorageDataSourceImp implements AuthLocalStorageDataSource {
  final FlutterSecureStorage storage;
  final LocalAuthentication localAuth;

  const AuthLocalStorageDataSourceImp({
    required this.storage,
    required this.localAuth,
  });

  final String _isNotFirstTimeKey = 'IsNotFirstTimeUsingApp';
  final String _token = 'Token';
  final String _loginDetailsKey = 'LoginDetailsKey';
  final String _bioMetricStatus = 'BoiMetricStatus';
  final String _darkModeStatus = 'DarkModeStatus';

  @override
  Future<bool> canUseThumbPrint() async {
    final bool canUseBiometrics = await localAuth.canCheckBiometrics;
    final bool isDeviceSupported = await localAuth.isDeviceSupported();
    final bool canAuthenticate = canUseBiometrics || isDeviceSupported;

    return canAuthenticate;
  }

  @override
  Future<bool> authenticateWithBioMetric() async {
    try {
      final bool didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate continue',
      );

      return didAuthenticate;
    } on PlatformException {
      throw const BaseFailures(message: 'Failed to authenticate');
    }
  }

  @override
  Future<void> saveLoginData(String email, String password) async {
    final Map data = {'email': email, 'password': password};
    final String value = json.encode(data);

    await storage.write(key: _loginDetailsKey, value: value);
  }

  @override
  Future<AuthLocallySavedDetails> getSavedLoginData() async {
    final bool authenticate = await authenticateWithBioMetric();
    if (!authenticate) {
      throw const BaseFailures(message: 'Authentication Failed');
    }

    final String? value = await storage.read(key: _loginDetailsKey);

    if (value == null) {
      throw const BaseFailures(
        message: 'No User Was Found Or A change password operation was '
            'preform, Please Login With Email And Password',
      );
    }

    return AuthLocallySavedDetails.fromMap(json.decode(value));
  }

  @override
  void clearLoginData() => throw UnimplementedError();

  @override
  Future<bool> checkIfLoginDataIsSaved() async {
    final String? value = await storage.read(key: _loginDetailsKey);
    final String? biometricStatus = await storage.read(key: _bioMetricStatus);
    final bool canUseThumbPrint = await this.canUseThumbPrint();

    if (value != null && biometricStatus == 'true' && canUseThumbPrint) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> toggleBiometric(bool value) async {
    await storage.write(key: _bioMetricStatus, value: value.toString());
    return value;
  }

  @override
  Future<bool> checkBiometricToggleState() async {
    final String? biometricStatus = await storage.read(key: _bioMetricStatus);
    return biometricStatus == 'true' ? true : false;
  }

  @override
  Future<bool> toggleDarkMode(bool value) async {
    await storage.write(key: _darkModeStatus, value: value.toString());
    return value;
  }

  @override
  Future<bool> checkDarkModeToggleState() async {
    final String? darkModeStatus = await storage.read(key: _darkModeStatus);
    return darkModeStatus == 'true' ? true : false;
  }

  @override
  Future<String?> getToken() async {
    final String? token = await storage.read(key: _token);

    return token;
  }

  @override
  Future<void> clearToken() async {
    await storage.write(key: _token, value: null);
  }

  @override
  Future<void> saveToken(String token) async {
    await storage.write(key: _token, value: token);
  }

  @override
  Future<bool> isNotFirstTimeUsingApp() async {
    final String? isNotFirstTime = await storage.read(key: _isNotFirstTimeKey);

    if (isNotFirstTime == "true") return true;

    await storage.write(key: _isNotFirstTimeKey, value: "true");
    return false;
  }
}

class AuthLocallySavedDetails {
  final String email;
  final String password;

  AuthLocallySavedDetails({required this.email, required this.password});

  factory AuthLocallySavedDetails.fromMap(Map<String, dynamic> map) {
    return AuthLocallySavedDetails(
      email: map['email'],
      password: map['password'],
    );
  }
}
