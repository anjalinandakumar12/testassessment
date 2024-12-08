class BusinessInfo {
  final int id;
  final String businessName;
  final String phone;
  final String address;
  final String workspaceName;
  final String website;
  final String email;

  BusinessInfo({
    required this.id,
    required this.businessName,
    required this.phone,
    required this.address,
    required this.workspaceName,
    required this.website,
    required this.email,
  });

  factory BusinessInfo.fromJson(Map<String, dynamic> json) {
    return BusinessInfo(
      id: json['id'],
      businessName: json['business_name'],
      phone: json['phone'],
      address: json['address'],
      workspaceName: json['workspacename'],
      website: json['website'],
      email: json['email'],
    );
  }
}
