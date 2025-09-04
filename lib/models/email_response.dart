class EmailResponse {
  final bool isVerified;
  final String? passwordChangeToken; 

  EmailResponse({
    required this.isVerified,
    this.passwordChangeToken,
  });

  factory EmailResponse.fromJson(Map<String, dynamic> json) {
    return EmailResponse(
      isVerified: json['isVerified'] ?? false,
      passwordChangeToken: json['passwordChangeToken'], // null 가능
    );
  }
}