import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_person_twitter_app/bindings/tweet_bindings.dart';
import 'package:one_person_twitter_app/repositories/auth_repository.dart';
import 'package:one_person_twitter_app/ui/add_tweet_screen.dart';
import 'package:one_person_twitter_app/ui/home_screen.dart';
import 'package:one_person_twitter_app/ui/login_screen.dart';
import 'package:one_person_twitter_app/ui/registration_screen.dart';

import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthRepository());
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'One Person Twitter App',
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegistrationScreen(),),
        GetPage(name: '/home', page: () => HomeScreen(), binding: TweetBindings()),
      ],
    );
  }
}
