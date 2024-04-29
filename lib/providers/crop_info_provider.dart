import 'package:agrimatics/model/crop_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CropInfoProvider with ChangeNotifier{

  //Read Crop Data
  Stream<List<CropModel>> readCropInfo(){

    print("Called");
    Stream<List<CropModel>> snapshot = FirebaseFirestore.instance
        .collection('crop_info').orderBy('name').snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => CropModel.fromJson(doc.data())).toList());

    return snapshot;
  }
}