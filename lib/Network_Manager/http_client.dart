
import 'package:food_donation/Network_Manager/http_helper.dart';
import 'package:food_donation/model/objectModal.dart';

class Restclient {
  static final HttpHelper _httpHelper = HttpHelper();

  static Future<ObjectModal> getApiUsing_Object() async {
    Map<String, dynamic> response = await _httpHelper.get(
      url: 'https://reqres.in/api/users?page=2',
    );
    return ObjectModal.fromJson(response);
  }

}
