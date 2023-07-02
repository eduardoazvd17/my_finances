import 'package:get/get.dart';
import 'package:myfinances/src/core/data/models/user_model.dart';

class AppController extends GetxController {
  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  UserModel? get user => _user.value;
  void setUser(UserModel? value) => _user.value = value;
}
