
// lib/models/staff_model.dart
class Staff {
  final String username;
  final String email;
  final String fullName;

  Staff({
    required this.username,
    required this.email,
    required this.fullName,
  });

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      username: map['username'],
      email: map['email'],
      fullName: map['full_name'],
    );
  }
}
