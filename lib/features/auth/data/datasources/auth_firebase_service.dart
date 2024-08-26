import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/features/auth/data/models/create_user_req.dart';
import 'package:spotify_clone/features/auth/data/models/sign_In_req.dart';
import 'package:spotify_clone/features/auth/data/models/user.dart';
import 'package:spotify_clone/features/auth/domain/entities/user.dart';

abstract class AuthFirebaseService {
  Future<Either> signUp(CreateUserReq createUserReq);
  Future<Either> signIn(SignInReq signInReq);
  Future<Either> getUser();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try {
      var data = await _firebaseAuth.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);
      _firestore.collection('users').doc(data.user?.uid).set({
        'name': createUserReq.fullName,
        'email': data.user?.email,
      });
      return const Right('SignUp was Successfull');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exist with that email';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signIn(SignInReq SignInReq) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: SignInReq.email, password: SignInReq.password);
      return right('Logged in Successfully');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'Please Enter a valid email';
      } else if (e.code == 'user-not-found') {
        message = 'this user doasnt exist';
      } else if (e.code == 'invalid-credential') {
        message = 'email or password are invalid';
      } else {
        message = "an error occured please try again later";
      }
      return left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      var user = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser?.uid)
          .get();
      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageUrl = _firebaseAuth.currentUser?.photoURL ??
          "https://gravatar.com/avatar/8aab5260c5099270cba742073c813757?s=400&d=mp&r=x";
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return const Left('an error occured');
    }
  }
}
