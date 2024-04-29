import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

class DiseaseDetection extends StatefulWidget {
  const DiseaseDetection({super.key});

  @override
  State<DiseaseDetection> createState() => _DiseaseDetectionState();
}

class _DiseaseDetectionState extends State<DiseaseDetection> {
  XFile? file;
  late List _results;
  bool imageSelect = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model_disease.tflite", labels: "assets/labels.txt"))!;
    print("Models loading status: $res");
  }

  Future imageClassification(XFile? file) async {
    var recognitions = await Tflite.runModelOnImage(
      path: file!.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _results = recognitions!;
      imageSelect = true;
      file = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF2caa5e),
        title: Text("Detect Disease", style: TextStyle(color: Colors.white),),
      ),
      body: Center(
          child: ListView(
            children: [
              (imageSelect)
                  ? Container(
                margin: EdgeInsets.all(10),
                child: Image.file(File(file!.path)),
              )
                  : Container(
                margin: EdgeInsets.all(10),
                child: Opacity(
                  opacity: 0.8,
                  child: Center(
                    child: Text("No Image Selected"),
                  ),
                ),
              ),
              Column(children: (imageSelect) ? _results.map((result) {
                return Card(child: Container(
                  margin: EdgeInsets.all(10),
                  child: Text("${result['label']}", style: TextStyle(
                      color: Colors.red, fontSize: 20,fontWeight: FontWeight.w600),),),);
              })
                  .toList() :[])
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: "Pick Image",
        child: Icon(Icons.camera),
      ),
    );
  }

  Future pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(source: ImageSource.gallery);

    imageClassification(file);
  }
}
