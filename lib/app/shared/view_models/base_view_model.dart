import 'package:get/get.dart';

abstract class ViewModel<T> extends GetxController with StateMixin<T> {
  ViewModel() {
    listenToStreams();
  }

  void listenToStreams();
}
