class RecentUser {
  String? name, role;

  RecentUser({
    this.name,
    this.role,
  });

  static fromJson(json) {}
}

List recentUsers = [
  RecentUser(
    name: "Floater Fund",
    role: "Mutual Funds",
  ),
  RecentUser(
    name: "Liquid Funds",
    role: "Mutual Funds",
  ),
  RecentUser(
    name: "Liquid Fund",
    role: "Mutual Funds",
  ),
  RecentUser(
    name: "Aggressive Fund",
    role: "Mutual Funds",
  ),
  RecentUser(
    name: "Flexi Cap Fund",
    role: "Mutual Funds",
  ),
  RecentUser(
    name: "***Fund",
    role: "Mutual Funds",
  ),
  RecentUser(
    name: "**Fund",
    role: "Mutual Funds",
  ),
];

class Product {
  String name;
  String avatarImage;
  bool isCheck;
  Product(this.name, this.avatarImage, this.isCheck);
}

class Summary {
  final String product_name;
  final String asset_category;
  final String asset_class;

  Summary({
    required this.product_name,
    required this.asset_category,
    required this.asset_class,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      product_name: json['product_name'],
      asset_category: json['asset_category'],
      asset_class: json['asset_class'],
    );
  }
}
