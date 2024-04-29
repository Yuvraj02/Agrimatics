import 'package:agrimatics/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier{

  final user = FirebaseAuth.instance.currentUser!;
  
  //Add post
  Future createPost({required String userName, required String uid, required String photoUrl, required String text}) async{
    final docUser = FirebaseFirestore.instance.collection('posts').doc();
    final post = PostModel(name: userName, photoURL: photoUrl, text: text, uid: uid,postID: docUser.id);
    final postJson = post.toJson();
    await docUser.set(postJson);
  }

  //Read Posts
  Stream<List<PostModel>> readPosts(){

    //print("Called");
    Stream<List<PostModel>> snapshot = FirebaseFirestore.instance
        .collection('posts').snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList());

    return snapshot;
  }

  //Add comment
  Future addComment({required String userName, required String uid, required String photoUrl, required String text, required String? postId}) async {
    final docUser = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc();

    final post = PostModel(name: userName, photoURL: photoUrl, text: text, uid: uid,postID: docUser.id);
    final postJson = post.toJson();
    await docUser.set(postJson);
  }

  //Read Comments
  Stream<List<PostModel>> readComments({required String postId}){

    Stream<List<PostModel>> snapshot = FirebaseFirestore.instance
        .collection('posts').doc(postId).collection('comments').snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList());

    return snapshot;
  }
  //Get Particular Posts
  Stream<List<PostModel>> readMyPosts(){

    //print("Called");
    Stream<List<PostModel>> snapshot = FirebaseFirestore.instance
        .collection('posts').where("uid", isEqualTo: user.uid).snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList());

    return snapshot;
  }
}