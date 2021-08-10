import 'package:get/get.dart';
import 'package:one_person_twitter_app/controllers/auth_controller.dart';
import 'package:one_person_twitter_app/controllers/tweet_controller.dart';
import 'package:one_person_twitter_app/repositories/auth_repository.dart';
import 'package:one_person_twitter_app/repositories/tweet_repository.dart';

class TweetBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TweetRepository());
    Get.lazyPut(() => TweetController());
  }

}