class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;
  final String location;

  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.location});
// factory constructor sab say pehly call hoga !
// UserModel say bhi pehly
// is say variables ko values assign ho jati hain late modifier add karny ki xroorat ni hai
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        location: json["location"],
      );
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "location": location,
      };
}
