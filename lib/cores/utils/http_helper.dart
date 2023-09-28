import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../navigator/navigator.dart';
import '../shared_session/session_manager.dart';
import 'logger.dart';

class HttpHelper {
  final Client client;
  final AppRouter appRouter;
  // final CrashLogger crashLogger;

  HttpHelper({
    required this.client,
    required this.appRouter,
    // required this.crashLogger,
  });

  Future<Map<String, String>> headers() async {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': await SessionManager.instance.bearerToken,
      'platform': Platform.operatingSystem,
      // 'version': (await PackageInfo.fromPlatform()).version.substring(0, 4),
    };
  }

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final Map<String, String> header = await headers();

      if (query != null) {
        url += '?';

        query.forEach((key, value) {
          bool isFirst = query.keys.toList().indexOf(key) == 0;
          if (isFirst) {
            url += '$key=$value';
          } else {
            url += '&$key=$value';
          }
        });
      }

      LoggerHelper.log(url);
      LoggerHelper.log(query);
      LoggerHelper.log("header: $header");

      Response response = await client
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 50));

      LoggerHelper.log(response.body);

      final Map<String, dynamic> result = json.decode(response.body);

      // Log Endpoint
      // crashLogger.endpointLogData(
      //   url: url,
      //   header: header,
      //   response: response.body,
      // );

      if ((response.statusCode ~/ 100) == 2) {
        return result;
      } else if (response.statusCode == 404) {
        throw 'Route not found, Please contact support';
      } else if (response.statusCode == 401) {
        appRouter.logOut();
        throw "Session has expired, please login";
      } else {
        throw result['message'];
      }
    } on FormatException catch (e, s) {
      LoggerHelper.log(e, s);
      if (kDebugMode) {
        throw 'Unable To Format Data!';
      }

      throw 'Something went wrong, please try again';
    } on SocketException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Unable to connect to server please check your network and try again!';
    } on TimeoutException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Unable to connect to server please check your network and try again!';
    } catch (e) {
      throw e.toString();
    }
  }

  /// Make an [Http] post request
  Future<Map<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> body,
    Map<String, dynamic>? query,
    Duration? timeoutDuration,
  }) async {
    final Map<String, String> header = await headers();

    try {
      if (query != null) {
        url += '?';
        query.forEach((key, value) => url += '&$key=$value');
      }

      LoggerHelper.log(url);
      LoggerHelper.log(query);
      LoggerHelper.log(body);
      LoggerHelper.log("header: $header");

      final bodyData = json.encode(body);
      Response response = await client
          .post(Uri.parse(url), headers: header, body: bodyData)
          .timeout(timeoutDuration ?? const Duration(seconds: 50));

      LoggerHelper.log(response.body);

      final Map<String, dynamic> result = json.decode(response.body);

      // Log Endpoint
      // crashLogger.endpointLogData(
      //   url: url,
      //   header: header,
      //   body: body,
      //   response: response.body,
      // );

      if ((response.statusCode ~/ 100) == 2) {
        return result;
      } else if (response.statusCode == 404) {
        throw 'Route not found, Please contact support';
      } else {
        throw checkForError(result);
      }
    } on FormatException catch (e, s) {
      LoggerHelper.log(e, s);
      if (kDebugMode) {
        throw 'Unable To Format Data!';
      }

      throw 'Something went wrong, please try again';
    } on TimeoutException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request Timeout, Unable to connect to server please check your network and try again!';
    } on SocketException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Unable to connect to server please check your network and try again!';
    } catch (e) {
      throw e.toString();
    }
  }

  /// Make an [Http] put request
  Future<Map<String, dynamic>> put({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      // Log Endpoint
      final Map<String, String> header = await headers();

      LoggerHelper.log(url);
      LoggerHelper.log(body);
      LoggerHelper.log("header: ${await headers()}");

      Response response = await client
          .put(Uri.parse(url), headers: header, body: json.encode(body))
          .timeout(const Duration(seconds: 50));

      LoggerHelper.log(response.body);

      final Map<String, dynamic> result = json.decode(response.body);

      // Log Endpoint
      // crashLogger.endpointLogData(
      //   url: url,
      //   header: header,
      //   body: body,
      //   response: response.body,
      // );

      if ((response.statusCode ~/ 100) == 2) {
        return result;
      } else if (response.statusCode == 404) {
        throw 'Route not found, Please contact support';
      } else {
        throw checkForError(result);
      }
    } on FormatException catch (e, s) {
      LoggerHelper.log(e, s);
      if (kDebugMode) {
        throw 'Unable To Format Data!';
      }

      throw 'Something went wrong, please try again';
    } on TimeoutException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request Timeout, Unable to connect to server please check your network and try again!';
    } on SocketException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Unable to connect to server please check your network and try again!';
    } catch (e) {
      throw e.toString();
    }
  }

  /// Make an [Http] delete request
  Future<Map<String, dynamic>> delete({
    required String url,
    required Map<String, dynamic> body,
    Map<String, dynamic>? query,
  }) async {
    try {
      final Map<String, String> header = await headers();

      if (query != null) {
        url += '?';
        query.forEach((key, value) => url += '&$key=$value');
      }

      LoggerHelper.log(url);
      LoggerHelper.log(query);
      LoggerHelper.log(body);
      LoggerHelper.log("header: ${await headers()}");

      Response response = await client
          .delete(Uri.parse(url), headers: header, body: json.encode(body))
          .timeout(const Duration(seconds: 50));

      LoggerHelper.log(response.body);

      final Map<String, dynamic> result = json.decode(response.body);

      // Log Endpoint
      // crashLogger.endpointLogData(
      //   url: url,
      //   header: header,
      //   body: body,
      //   response: response.body,
      // );

      if ((response.statusCode ~/ 100) == 2) {
        return result;
      } else if (response.statusCode == 404) {
        throw 'Route not found, Please contact support';
      } else {
        throw checkForError(result);
      }
    } on FormatException catch (e, s) {
      LoggerHelper.log(e, s);
      if (kDebugMode) {
        throw 'Unable To Format Data!';
      }

      throw 'Something went wrong, please try again';
    } on TimeoutException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Request Timeout, Unable to connect to server please check your network and try again!';
    } on SocketException catch (e, s) {
      LoggerHelper.log(e, s);
      throw 'Unable to connect to server please check your network and try again!';
    } catch (e) {
      throw e.toString();
    }
  }

  //! Todo: Refactor this method to use status code
  static String checkForError(Map data) {
    if (data['error'] != null ||
        data['state'] == "error" ||
        (data['statusCode'] != null && data['statusCode'] ~/ 2 != 1) ||
        (data['status'] != null && data['status'] ~/ 2 != 1)) {
      if (data['message'] is List<dynamic>) {
        throw data['message'].join(', ');
      }
      final String? message = data['message'] ?? data['msg'];

      if (message != null) throw message;

      final Map<String, dynamic> errorMap = Map.from(data['error']);
      return errorMap.values.join('\n');
    }

    return 'Something went wrong, Please try again';
  }
}
