import 'package:agrimatics/model/crop_model.dart';
import 'package:flutter/material.dart';

class CropDetail extends StatelessWidget {
  CropModel cropModel;

  CropDetail({super.key, required this.cropModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_outlined),
        ),
        title: Text("${cropModel.name}"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text("${cropModel.description}"),
        ),
      )),
    );
  }
}
