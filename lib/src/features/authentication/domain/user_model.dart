class User{
  String name;

  User({
    required this.name,
});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
    name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}