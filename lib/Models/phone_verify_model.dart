class PhoneVerifyModel {
  final dynamic deviceId;
  final String deviceType;
  final String deviceToken;
  final String mobile;
  final String adminId;

  PhoneVerifyModel({
    required this.deviceId,
    required this.deviceType,
    required this.deviceToken,
    required this.mobile,
    required this.adminId,
  });

  Map<String, dynamic> toJson() {
    print("#### 1. toJson");
    print("#### @@. deviceId: $deviceId");

    return {
      "device_id": deviceId?.toString(),
      "device_type": deviceType,
      "device_token": deviceToken,
      "mobile": mobile,
      "admin_id": adminId,
    };
  }
}
