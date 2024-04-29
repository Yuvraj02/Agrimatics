class PostModel {
  String? name;
  String? uid;
  String? photoURL;
  String? text;
  String? postID;

  PostModel({required this.name, required this.photoURL, required this.text,required this.uid, required this.postID});

  Map<String, dynamic> toJson() => {
        'userName': name,
        'uid': uid,
        'photoUrl': photoURL,
        'post': text,
        'postId' : postID,
      };

  static PostModel fromJson(Map<String, dynamic> json) =>
      PostModel(name: json['userName'],
      uid: json['uid'],
      photoURL: json['photoUrl'],
      text: json['post'],
      postID: json['postId']);
}
