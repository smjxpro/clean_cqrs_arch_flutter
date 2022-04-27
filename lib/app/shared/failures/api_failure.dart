import 'base_failure.dart';

class ApiFailure extends Failure {
  final int code;

  const ApiFailure({required this.code, required String message})
      : super(message: message);
}
