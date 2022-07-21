abstract class BaseHandler<R, T> {
  Future<T> handle(R request);
}
