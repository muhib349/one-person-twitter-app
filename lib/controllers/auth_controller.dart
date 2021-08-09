
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:one_person_twitter_app/repositories/auth_repository.dart';
import 'package:one_person_twitter_app/repositories/exceptions/firebase_signin_exception.dart';
import 'package:one_person_twitter_app/repositories/exceptions/firebase_signup_exception.dart';

class AuthController extends GetxController{
  var isLoading = false.obs;
  final _repository = Get.find<AuthRepository>();
  var errorMessage = "".obs;
  
  Future<User?> signIn(String email, String password) async {
    try {
      isLoading(true);
      User? user = await _repository.signIn(email, password);
      return user;
    } on FirebaseSignInException catch (e) {
      errorMessage.value = e.message;
    }finally{
      isLoading(false);
    }
    
  }

  Future<User?> signUp(String email, String password) async {
    try {
      isLoading(true);
      User? user = await _repository.signUp(email, password);
      return user;

    } on FirebaseSignUpException catch (e) {
      errorMessage.value = e.message;
    }finally{
      isLoading(false);
    }
  }

  void signOut() async {
    try{
      await _repository.signOut();
      Get.offAll("/login");
      Get.snackbar(
        "Log out!",
        "Successfully Logged out!",
        snackPosition: SnackPosition.BOTTOM,
      );
    }catch(e){

    }
  }
}