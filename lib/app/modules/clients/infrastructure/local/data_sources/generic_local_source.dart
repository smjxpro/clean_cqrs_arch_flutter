abstract class GenericLocalSource<T> {
  Future<T?> get(int id);

  Future<T?> getByRemoteId(String id);

  Future<List<T>> getAll();

  Future<T> create(T entity);

  Future<T> update(T entity);

  Future<void> delete(int id);

  Future<void> deleteAll();
}
