
import 'package:get/get.dart';
import 'package:one_person_twitter_app/controllers/auth_controller.dart';
import 'package:one_person_twitter_app/repositories/auth_repository.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => AuthController());
  }
  
}