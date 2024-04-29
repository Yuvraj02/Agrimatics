import 'package:agrimatics/utils/custom_colors.dart';
import 'package:agrimatics/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

class CropRecommendationScreen extends StatefulWidget {
  const CropRecommendationScreen({super.key});

  @override
  State<CropRecommendationScreen> createState() =>
      _CropRecommendationScreenState();
}

class _CropRecommendationScreenState extends State<CropRecommendationScreen> {

  Map<int, String> crops = {
    0 : "Apple",
    1 : "Banana",
    2 : "Blackgram",
    3 : "Chickpea",
    4 : "Coconut",
    5 : "Coffee",
    6 : "Cotton",
    7 : "Grapes",
    8 : "Jute",
    9 : "Kidney Beans",
    10 : "Lentil",
    11 : "Maize",
    12 : "Mango",
    13 : "Moth Beans",
    14 : "Mung bean",
    15 : "Muskmelon",
    16 : "Orange",
    17 : "Papaya",
    18 : "Pigeon peas",
    19 : "Pomegranate",
    20 : "Rice",
    21 : "Watermelon",
  };

  //Dummy Data
  var data = [
    //N, P,  K,  temperature, humidity, ph, rainfall, label
 // [ 25, 132, 198, 22.31944084, 90.85174383, 5.73275752 ,100.1173443]
  ];
  late List<double> result;
  bool gotValue = false;

  List<num> dataFromInput = [];

  runModel() async {
    final interpreter = await tfl.Interpreter.fromAsset('assets/model.tflite');
    final input = data;

    var output = List.filled(22, 1).reshape([1, 22]);

    interpreter.run(input, output);
    result = output[0];
    setState(() {
      gotValue = true;
    });
    //print(result);
  }

  String getCrop(){

    for(int i = 0; i<result.length; i++){
      if(result[i]==1.0) {
        return crops[i]!;
      }
    }

    return "Sorry Can't Suggest Crop with this Data";
  }

  TextEditingController _nitrogenController = TextEditingController();
  TextEditingController _phosphorousController = TextEditingController();
  TextEditingController _potassiumController = TextEditingController();
  TextEditingController _temperatureController = TextEditingController();
  TextEditingController _pHlevelController = TextEditingController();
  TextEditingController _rainfallController = TextEditingController();
  TextEditingController _humidityController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.firstGradientColor,
        title: Text("Crop Recommendation",style: TextStyle(color: Colors.white),),
      ),
      drawer: CustomNavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nitrogenController,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Nitrogen Value of Soil'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _phosphorousController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Phosphorous Value of Soil'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _potassiumController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Potassium Content in Soil'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _temperatureController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Temperature in Celcius'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _humidityController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Humidty'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _pHlevelController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'pH level'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _rainfallController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Rainfall in cm'),
                ),
              ),

              Center(
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.green,foregroundColor: Colors.white),
                  child: Text("Get Crop Recommendation"),
                  onPressed: () {
                    data.clear();
                    //result.clear();
                    dataFromInput.clear();
                    dataFromInput.add(num.parse(_nitrogenController.text));
                    dataFromInput.add(num.parse(_phosphorousController.text));
                    dataFromInput.add(num.parse(_potassiumController.text));
                    dataFromInput.add(num.parse(_temperatureController.text));
                    dataFromInput.add(num.parse(_humidityController.text));
                    dataFromInput.add(num.parse(_pHlevelController.text));
                    dataFromInput.add(num.parse(_rainfallController.text));

                    data.add(dataFromInput);

                    runModel();
                    setState(() {});
                  },
                ),
              ),
              gotValue ? Text("'${getCrop()}' is the best crop for your soil",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.green),) : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
