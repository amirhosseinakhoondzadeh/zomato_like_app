import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({@required this.message});
  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  @override
  String get message => "Cannot cache data!";
}

class UnAuthorizedFailure extends Failure {
  @override
  String get message => "Unauthorized User, Please Login again!";
}

class InternetFailure extends Failure {
  @override
  String get message => "There is no Internet connection!";
}

class ServerFailure extends Failure {
  final String customMessage;
  const ServerFailure({this.customMessage});
  @override
  List<Object> get props => [customMessage];
  @override
  String get message => customMessage ?? "Something went wrong on server!";
}
