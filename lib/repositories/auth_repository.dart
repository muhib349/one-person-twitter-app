
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_person_twitter_app/repositories/exceptions/firebase_signin_exception.dart';
import 'package:one_person_twitter_app/repositories/exceptions/firebase_signup_exception.dart';

class AuthRepository{
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      await createNewUser(userCredential.user);
      return userCredential.user;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw FirebaseSignUpException("The password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        throw FirebaseSignUpException("The account already exists for that email.");
      }
    } catch (e) {
      throw FirebaseSignUpException(e.toString());
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw FirebaseSignInException("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        throw FirebaseSignInException("Wrong password provided for that user.");
      }
    } catch(e){
      throw FirebaseSignInException("Something went wrong");
    }
  }

  Future<void> signOut() async {
    try{
      await _firebaseAuth.signOut();
    }
    on FirebaseException catch(e){
      print(e.message);
    }
  }

  Future<bool> createNewUser(User? user) async {
    try {
      await _firestore
          .collection("users")
          .doc(user!.uid)
          .set({
            "email": user.email,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}