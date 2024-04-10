import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int? statusCode;
  final String message;

  const Failure({this.statusCode, required this.message});

  String get errorMessage => '${statusCode ?? ''} $message'.trimLeft();

  @override
  List<Object> get props => [statusCode ?? 0, message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.statusCode, required super.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.statusCode, required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({super.statusCode, required super.message});
}

class StorageFailure extends Failure {
  const StorageFailure({super.statusCode, required super.message});
}
