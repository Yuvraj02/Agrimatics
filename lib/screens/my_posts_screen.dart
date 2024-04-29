//TODO : Implement my posts

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../model/community/post_model.dart';
// import '../providers/post_provider.dart';
// import '../utils/custom_colors.dart';
// import '../widgets/navigation_drawer.dart';
//
// class MyPosts extends StatefulWidget {
//   const MyPosts({super.key});
//
//   @override
//   State<MyPosts> createState() => _MyPostsState();
// }
//
// class _MyPostsState extends State<MyPosts> {
//   @override
//   Widget build(BuildContext context) {
//      final user = FirebaseAuth.instance.currentUser!;
//
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: CustomColors.firstGradientColor,
//         title: Text(
//           "My Posts",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: StreamBuilder<List<PostModel>>(
//         stream: context.read<PostProvider>().readMyPosts(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Center(
//               child: Text("Oops! There's some Error getting Posts"),
//             );
//           } else if (snapshot.hasData) {
//             final post = snapshot.data!;
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListView(
//                 children: post.map(postWidget).toList(),
//               ),
//             );
//           } else if (!snapshot.hasData) {
//             return const Center(
//               child: Text("You haven't Posted anything Yet"),
//             );
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//       drawer: CustomNavigationDrawer(),
//     );
//   }
// }
