import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_person_twitter_app/controllers/auth_controller.dart';
import 'package:one_person_twitter_app/controllers/tweet_controller.dart';
import 'package:one_person_twitter_app/models/tweet_model.dart';
import 'package:one_person_twitter_app/ui/add_tweet_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<TweetController>();
    final authController = Get.find<AuthController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Twitter Home"),
          leading: IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              onPressed: ()  {
                authController.signOut();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),

        body: Obx(() => ModalProgressHUD(
          inAsyncCall: _controller.isLoading.value,
          child: ListView.builder(
            itemCount: _controller.tweetList.length,
            itemBuilder: (_,index){
              Tweet tweet = _controller.tweetList[index];

              return InkWell(
                onTap: (){
                  Get.to(AddTweetScreen(tweet: tweet,));
                },
                child: Container(
                  height: 200,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tweet.body ?? "Text",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat("dd, MMMM, yyyy").format(tweet.createdAt!.toDate()),
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey,
                                  fontSize: 12
                                ),
                              ),

                              InkWell(
                                onTap: (){
                                  _controller.delete(tweet.id ?? "00");
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                ),
              );
            },
          ),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.to(AddTweetScreen());
          },
          child: Icon(Icons.add),
          tooltip: "Add twitter",
        ),
      ),
    );
  }
}
