class Member {
  final int id;
  final String email;
  final String name;
  final String nickname;
  final String gender;
  final String role;
  final String birthday;
  final String? profileImage;
  
  Member({
    required this.id,
    required this.email,
    required this.name,
    required this.nickname,
    required this.gender,
    required this.role,
    required this.birthday,
    this.profileImage
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      nickname: json['nickname'],
      gender: json['gender'],
      role: json['role'],
      birthday: json['birthday'],
      profileImage: json['profileImage']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nickname': nickname,
    'role': role,
    
  };
}
