
// lib/models/staff_model.dart
class Staff {
  final String username;
  final String email;
  final String fullName;
  final String location;
  final String contact_no;

  Staff({
    required this.username,
    required this.email,
    required this.fullName,
    required this.location,
    required this.contact_no,
  });

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      username: map['username'],
      email: map['email'],
      fullName: map['full_name'],
      location: map['location'],
      contact_no: map['contact_no'],
    );
  }
}
