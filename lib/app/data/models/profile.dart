class Profile {
  int id;
  String name;
  String password;
  String image;
  String nik;

  Profile(
      {required this.id,
      required this.name,
      required this.password,
      required this.image,
      required this.nik});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'image': image,
      'nik': nik,
    };
  }
}
