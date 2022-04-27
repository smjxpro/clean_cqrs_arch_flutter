abstract class Handler<R, T> {
  Future<T> handle(R request);
}
