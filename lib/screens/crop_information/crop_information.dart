import 'package:agrimatics/model/crop_model.dart';
import 'package:agrimatics/providers/crop_info_provider.dart';
import 'package:agrimatics/screens/crop_information/crop_detail.dart';
import 'package:agrimatics/utils/custom_colors.dart';
import 'package:agrimatics/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CropInformation extends StatefulWidget {
  const CropInformation({super.key});

  @override
  State<CropInformation> createState() => _CropInformationState();
}

class _CropInformationState extends State<CropInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.firstGradientColor,
        title: Text(
          "Crop Information",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<List<CropModel>>(
        stream: context.read<CropInfoProvider>().readCropInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error Retrieving data"),
            );
          } else if (snapshot.hasData) {
            final cropInfo = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(20),
              child: GridView.count(
                  crossAxisCount: 2, children: cropInfo.map(cropItem).toList()),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text("No Record Found"),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      drawer: CustomNavigationDrawer(),
    );
  }

  Widget cropItem(CropModel cropModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CropDetail(cropModel: cropModel)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 140,
              width: 120,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                      image: NetworkImage(cropModel.imageUrl!))),
              //child: Image.network(cropModel.imageUrl!),
            ),
            Text("${cropModel.name}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),)
          ],
        ),
      ),
    );
  }
}
