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
    'email' : email,
    'name': name,
    'nickname': nickname,
    'gender' :gender,
    'role': role,
    'birthday' : birthday,
    'profileImage' : profileImage
  };

  void printMember() {
    print('--- Member Info ---');
    print('ID: $id');
    print('Email: $email');
    print('Name: $name');
    print('Nickname: $nickname');
    print('Gender: $gender');
    print('Role: $role');
    print('Birthday: $birthday');
    print('Profile Image: ${profileImage ?? 'No image'}');
  }
}
