class CropModel {
  String? name;
  String? description;
  String? imageUrl;

  CropModel(
      {required this.name, required this.description, required this.imageUrl});

  static CropModel fromJson(Map<String, dynamic> json) => CropModel(
      name: json['name'],
      description: json['desc'],
      imageUrl: json['imageUrl']);
}
