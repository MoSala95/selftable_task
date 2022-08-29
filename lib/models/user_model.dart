class UserModel {
  final String uid;
  final String email;
  final String name;
  final String photoUrl;
  final String age;
  List favoriteList;

  UserModel(
      {required this.uid,
        required this.email,
        required this.name,
        required this.photoUrl,
      required this.age,
        this.favoriteList=const[]
      });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      age: data['age'] ?? '',
      favoriteList:  data['favoriteList']?? []
    );
  }

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "name": name, "photoUrl": photoUrl,"age":age,"favoriteList":favoriteList};
}