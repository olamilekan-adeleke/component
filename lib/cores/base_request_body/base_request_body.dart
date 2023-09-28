import 'package:equatable/equatable.dart';

abstract class RequestParam extends Equatable {
  Map<String, dynamic> toMap();
}
