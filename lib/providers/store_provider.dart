import 'package:agrimatics/model/store_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class StoreProvider with ChangeNotifier{

  Stream<List<StoreItemModel>> readPosts(){

    Stream<List<StoreItemModel>> snapshot = FirebaseFirestore.instance
        .collection('store').snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => StoreItemModel.fromJson(doc.data())).toList());

    return snapshot;
  }

}