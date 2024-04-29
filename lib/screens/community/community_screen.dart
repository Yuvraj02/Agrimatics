import 'package:agrimatics/model/post_model.dart';
import 'package:agrimatics/providers/post_provider.dart';
import 'package:agrimatics/screens/community/add_post.dart';
import 'package:agrimatics/utils/custom_colors.dart';
import 'package:agrimatics/widgets/navigation_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.firstGradientColor,
        title: Text(
          "Community",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPostScreen()));
              },
              icon: Icon(
                Icons.send_sharp,
                color: Colors.white,
              ))
        ],
      ),
      body: StreamBuilder<List<PostModel>>(
        stream: context.read<PostProvider>().readPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Oops! There's some Error getting Posts"),
            );
          } else if (snapshot.hasData) {
            final post = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: post.map(postWidget).toList(),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No Post found!"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget postWidget(PostModel postModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            //border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage("${postModel.photoURL}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text("${postModel.name}"),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text("${postModel.text}"),
                ],
              ),
            ),
            SizedBox(
              height: 0,
              width: MediaQuery.of(context).size.width,
              child: DecoratedBox(
                decoration: const BoxDecoration(color: Colors.grey),
              ),
            ),
            GestureDetector(
              onTap: () {
                openComments(postModel.postID!);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Text("See comments"),
                    IconButton(
                        onPressed: () {
                          //TODO : Implement Comment section here
                          openComments(postModel.postID!);
                        },
                        icon: Icon(Icons.comment_outlined))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16),
              child: Row(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Add your comment'),
                      )),
                  IconButton(
                      onPressed: () {
                        //TODO : Implement Send Comment section here
                        final user = FirebaseAuth.instance.currentUser!;
                        final provider =
                            Provider.of<PostProvider>(context, listen: false);
                        provider.addComment(
                            userName: user.displayName!,
                            uid: user.uid,
                            photoUrl: user.photoURL!,
                            text: _commentController.text,
                            postId: postModel.postID);

                        _commentController.clear();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future openComments(String postId) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Comments"),
            content: StreamBuilder<List<PostModel>>(
              stream: context.read<PostProvider>().readComments(postId: postId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Oops! There's some Error getting Posts"),
                  );
                } else if (snapshot.hasData) {
                  final post = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: post.map(commentWidget).toList(),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No Post found!"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"))
            ],
          ));

  Widget commentWidget(PostModel postModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        decoration: BoxDecoration(
            //border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage("${postModel.photoURL}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "${postModel.name}",
                      style: TextStyle(fontSize: 11),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Text("${postModel.text}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
