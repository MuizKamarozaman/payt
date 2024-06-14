// lib/models/user_model.dart

class UserProfile {
  String fullName;
  String username;
  String location;
  String contactNo;

  UserProfile({
    required this.fullName,
    required this.username,
    required this.location,
    required this.contactNo,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      fullName: map['full_name'] ?? '',
      username: map['username'] ?? '',
      location: map['location'] ?? '',
      contactNo: map['contact_no'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'username': username,
      'location': location,
      'contact_no': contactNo,
    };
  }

  void update(
      {String? fullName,
      String? username,
      String? location,
      String? contactNo}) {
    if (fullName != null) this.fullName = fullName;
    if (username != null) this.username = username;
    if (location != null) this.location = location;
    if (contactNo != null) this.contactNo = contactNo;
  }
}
