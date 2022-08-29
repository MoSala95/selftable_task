class CatModel{
  String name;
  String desc;
  Map<String,dynamic> id;
  String image;

  CatModel({required this.name,required this.desc,required this.id,required this.image});

  factory CatModel.fromMap(Map<String,dynamic> json) =>CatModel(name: json["name"], desc: json["desc"], id: json["id"] as Map<String,dynamic>, image: json["image"]);
}