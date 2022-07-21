abstract class GenericLocalSource<T> {
  Future<T?> get(String id);

  Future<List<T>> getAll();

  Future<T> create(T entity);

  Future<T> update(T entity);

  Future<void> delete(T entity);

  Future<void> deleteAll();

  Future<bool> exists(T entity);
}
