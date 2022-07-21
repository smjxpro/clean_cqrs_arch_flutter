class Client {
  Client({
    this.id,
    required this.name,
    this.imageUrl,
    this.localId,
    this.isDeleted = false,
  });

  String? id;
  String name;
  String? imageUrl;
  int? localId;
  bool isDeleted;
}
