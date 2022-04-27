import 'base_failure.dart';

class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'Network Failure'})
      : super(message: message);
}
