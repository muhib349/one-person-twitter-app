
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_person_twitter_app/models/tweet_model.dart';
import 'package:one_person_twitter_app/repositories/exceptions/error_exception.dart';

class TweetRepository {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;


  Future<bool> saveTweet(Tweet tweet) async {
     try{
       await _firestore
           .collection("users")
           .doc(_currentUser!.uid)
           .collection("tweets")
           .add({
         "body": tweet.body,
         "created_at": Timestamp.now()
       });
       return true;
     }catch(e){
       throw new ErrorException("Save tweet failed");
     }
  }

  Stream<List<Tweet>> getTweets() {
    try{
      return _firestore
          .collection("users")
          .doc(_currentUser!.uid)
          .collection("tweets")
          .orderBy("created_at",descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        List<Tweet> retVal = [];
        query.docs.forEach((element) => retVal.add(Tweet.fromDocumentSnapshot(element)));
        return retVal;
      });
    }catch(e){
      throw new ErrorException("Fetch tweet failed");
    }
  }

  Future<bool> deleteTweet(String tweetID) async {
    try{
      await _firestore
          .collection("users")
          .doc(_currentUser!.uid)
          .collection("tweets")
          .doc(tweetID)
          .delete();
      return true;
    }
    on FirebaseException catch(e){
      throw new ErrorException(e.message ?? "Exception found");
    }
  }

  Future<bool> updateTweet(Tweet tweet) async {
    try{
      await _firestore
          .collection("users")
          .doc(_currentUser!.uid)
          .collection("tweets")
          .doc(tweet.id)
          .update({
              "body": tweet.body,
          });

      return true;
    }catch(e){
      throw new ErrorException("Update tweet failed");
    }
  }

}