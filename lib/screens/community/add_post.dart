import 'package:agrimatics/providers/post_provider.dart';
import 'package:agrimatics/utils/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.firstGradientColor,
        title: Text("Add Post",style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _postController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type your post here'),
            ),
          ),
          IconButton(
              onPressed: () {
                final provider =
                    Provider.of<PostProvider>(context, listen: false);
                provider.createPost(
                    userName: user.displayName!,
                    uid: user.uid,
                    photoUrl: user.photoURL!,
                    text: _postController.text);

                _postController.clear();
              },
              icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
