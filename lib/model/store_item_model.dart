class StoreItemModel{

  String? name;
  int? price;
  String? category;
  String? imageUrl;

  StoreItemModel({required this.name, required this.price, required this.category, required this.imageUrl});

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'category': category,
    'imageUrl' : imageUrl,
  };

  static StoreItemModel fromJson(Map<String, dynamic> json) =>
      StoreItemModel(name: json['name'],
          price: json['price'],
          category: json['category'],
          imageUrl: json['imageUrl']);
}