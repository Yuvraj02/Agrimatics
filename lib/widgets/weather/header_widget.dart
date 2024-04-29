import 'package:agrimatics/controller/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    // TODO: implement initState
    getAddress(globalController.getLattitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  getAddress(lat, long) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(lat, long);

    setState(() {
      city = placeMark[0].locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, right: 20,bottom: 10),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: TextStyle(fontSize: 33,color: Colors.grey[700],height: 1.5),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20,bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style: TextStyle(fontSize: 14,color: Colors.grey[700],height: 1.5),
          ),
        )
      ],
    );
  }
}
