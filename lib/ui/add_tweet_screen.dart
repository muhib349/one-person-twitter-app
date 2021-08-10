import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_person_twitter_app/controllers/tweet_controller.dart';
import 'package:one_person_twitter_app/models/tweet_model.dart';

class AddTweetScreen extends StatelessWidget {
  final Tweet? tweet;
  const AddTweetScreen({Key? key,this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController  = TextEditingController();
    final controller = Get.find<TweetController>();
    final formKey = GlobalKey<FormState>();

    if(tweet != null){
      textController.text = tweet!.body ?? "";
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Tweet"),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: textController,
                  maxLength: 280,
                  maxLines: 10,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Your content is empty!";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Please type your tweet here",
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      controller.addUpdateTweet(Tweet(
                        id: tweet != null ? tweet!.id : null,
                        body: textController.text
                      ));
                    }
                  },
                  child: Text(tweet != null ? "Update Tweet":"Add Tweet"),
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 16
                    )),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16))
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
