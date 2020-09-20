import 'package:flutter/foundation.dart';

/// This file contains all the exception that could be used throughout the App
/// All the classes implement [Exception]

class ServerException implements Exception {
  final String message;
  final int code;

  const ServerException({this.message, this.code});
}

class CacheException implements Exception {
  final String message;
  const CacheException({@required this.message});
}
