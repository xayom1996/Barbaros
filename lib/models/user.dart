class User {
  final String id;
  final String fullName;

  User({required this.id, required this.fullName});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
    };
  }
}