class Product {
  final String id;
  final String name;
  final String desc;

  Product({
    required this.id,
    this.name = '',
    this.desc = '',
  });

  @override
  bool operator ==(Object o) => o is Product && o.id == this.id;

  @override
  int get hashCode => id.hashCode;
}
