// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ENV {
  String get apiBaseUrl => dotenv.env['STAGING_BASE_URL'] ?? "";
  String get prodApiBaseUrl => dotenv.env['PROD_BASE_URL'] ?? "";
  String get DIGITAL_OCEAN_REGION => dotenv.env['DIGITAL_OCEAN_REGION'] ?? "";
  String get digitalOceanAccessKey =>
      dotenv.env['DIGITAL_OCEAN_PUBLIC_KEY'] ?? "";
  String get digitalOceanSecretKey =>
      dotenv.env['DIGITAL_OCEAN_SECRET_KEY'] ?? "";
  String get digitalOceanBucketUrl =>
      dotenv.env['DIGITAL_OCEAN_BASE_URL'] ?? "";
}
