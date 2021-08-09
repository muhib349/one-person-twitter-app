import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_person_twitter_app/controllers/auth_controller.dart';
import 'package:one_person_twitter_app/ui/login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controller = Get.find<AuthController>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Obx(() => ModalProgressHUD(
                inAsyncCall: controller.isLoading.value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome Twitter",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Sign up to continue",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      controller.errorMessage.value.isNotEmpty ?
                      Text(
                        controller.errorMessage.value,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red
                        ),
                      ) : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (String? value) {
                          if (value != null) {
                            return !GetUtils.isEmail(value)
                                ? "Please Enter valid email"
                                : null;
                          }
                          return "Email is required";
                        },
                        decoration: const InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        validator: (String? value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return "Password is required!";
                            }
                            return value.length < 8
                                ? "Minimum 6 character required"
                                : null;
                          }
                          return "Password is required!";
                        },
                        decoration: const InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: confirmPasswordController,
                        validator: (String? value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return "Confirm Password is required!";
                            }
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              return "Password didn't match!";
                            }
                            return value.length < 8
                                ? "Minimum 6 character required"
                                : null;
                          }
                          return "Confirm password is required!";
                        },
                        decoration: const InputDecoration(
                            hintText: "Confirm Password",
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if(formKey.currentState!.validate()){
                            User? user = await controller.signUp(emailController.text, passwordController.text);
                            if(user != null){
                              Get.offAllNamed("/login");
                              Get.snackbar(
                                "Twitter",
                                "User registration successfully done!",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.black,
                                colorText: Colors.white
                              );
                            }
                          }
                        },
                        height: 60,
                        minWidth: double.infinity,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'I have an account ',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign In',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.offAll(LoginScreen());
                                },
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
