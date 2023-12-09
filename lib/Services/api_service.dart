import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ritesh_flutter_task/Models/phone_verify_model.dart';

class ApiService {
  Future<bool> phoneVerify(PhoneVerifyModel phoneVerifyModel) async {
    const url = 'https://www.ondeindia.com/api/user/login';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(phoneVerifyModel.toJson()),
    );
    print('#### 3. ${response.body}');
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      print("#### 2. $decodedResponse");
      return true;
    } else {
      return false;
    }
  }
}
