import 'package:get/get.dart';
import 'package:one_person_twitter_app/models/tweet_model.dart';
import 'package:one_person_twitter_app/repositories/exceptions/error_exception.dart';
import 'package:one_person_twitter_app/repositories/tweet_repository.dart';

class TweetController extends GetxController{
  RxBool isLoading = false.obs;
  RxList<Tweet> tweetList = List<Tweet>.empty(growable: true).obs;
  final _repository = Get.find<TweetRepository>();


  @override
  void onInit() {
    _getTweetList();
    super.onInit();
  }
  void saveTweet(Tweet tweet){

  }

  void _getTweetList(){
    try {
      isLoading.value = true;
      tweetList.bindStream(_repository.getTweets());
    } on ErrorException catch (e) {
      printInfo(info: e.message);
    }finally{
      isLoading.value = false;
    }
  }

  void delete(String ID){
    try{
      isLoading.value = true;
      _repository.deleteTweet(ID);
    }
    on ErrorException catch(e){
      print(e.message);
    }finally{
      isLoading.value = false;
    }
  }

  void addUpdateTweet(Tweet tweet){
    try{
      isLoading.value = true;
      String status = "";

      if(tweet.id == null){
        _repository.saveTweet(tweet);
        status = "saved";
      }else{
        _repository.updateTweet(tweet);
        status = "updated";
      }
      Get.back();
      Get.snackbar(
        "Successful",
        "You have successfully $status your tweet",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    on ErrorException catch(e){
      print(e.message);
    }finally{
      isLoading.value = false;
    }
  }

}