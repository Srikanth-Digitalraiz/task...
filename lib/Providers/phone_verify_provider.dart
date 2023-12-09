import 'package:flutter/material.dart';
import 'package:ritesh_flutter_task/Models/phone_verify_model.dart';
import 'package:ritesh_flutter_task/Services/api_service.dart';

class PhoneVerifyProvider with ChangeNotifier {
  ApiService apiService = ApiService();
  bool isLoading = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  Future<void> phoneNumberVerify({
    required PhoneVerifyModel phoneVerifyModel,
    required Function onSuccess,
    required Function onError,
  }) async {
    isLoading = true;
    notifyListeners();
    final result = await apiService.phoneVerify(phoneVerifyModel);
    isLoading = false;
    notifyListeners();
    if (result == true) {
      onSuccess();
    } else {
      onError();
    }
  }
}
