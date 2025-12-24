import 'package:equatable/equatable.dart';

/// Base failure class for error handling
abstract class Failure extends Equatable {
  const Failure([this.message]);

  final String? message;

  @override
  List<Object?> get props => [message];
}

/// Server failure - errors from backend/server
class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

/// Cache failure - errors from local storage/cache
class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}

/// Network failure - errors from network connectivity
class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

/// Auth failure - errors from authentication
class AuthFailure extends Failure {
  const AuthFailure([super.message]);
}
