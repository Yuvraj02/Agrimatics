import 'package:agrimatics/screen_routes.dart';
import 'package:agrimatics/utils/custom_colors.dart';
import 'package:agrimatics/widgets/navigation_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String firstName(String fullName) {
    String fName = "";
    for (int i = 0; i < fullName.length; i++) {
      if (fullName[i] == ' ') break;
      fName += fullName[i];
    }
    return fName;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    List<ScreenCard> sc = [
      ScreenCard("Get Weather Information", "assets/icons/weather_forecast.png",
          weatherDataScreen),
      ScreenCard("Explore Store", "assets/icons/store.png", storeScreen),
      ScreenCard("Crop Checkup", "assets/icons/herbs.png", diseaseDetection),
      ScreenCard(
          "Crop Recommendation", "assets/icons/wheat.png", cropRecommendation),
      ScreenCard(
          "Crop Information", "assets/icons/search.png", cropInformation),
      ScreenCard("Get with Community", "assets/icons/social-justice.png",
          communityScreen),
      ScreenCard("Rent an Item", "assets/icons/deal.png", rentScreen),
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Agrimetics',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: CustomColors.firstGradientColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3.0,
            color: CustomColors.firstGradientColor,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hi",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        "${firstName(user.displayName!)}",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text("Crops Sown",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Text("0",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1e542d))),
                      Text("Community Posts",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Text("0",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1e542d))),
                    ],
                  ),
                  SizedBox(width: 50),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.photoURL!),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 0, left: 8, right: 8),
            child: Text(
              "Explore",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: GridView.count(
                crossAxisSpacing: 8,
                crossAxisCount: 2,
                children: [gridContainer(sc[0]),
                gridContainer(sc[1]),
                gridContainer(sc[2]),
                gridContainer(sc[3]),
                gridContainer(sc[4]),
                gridContainer(sc[5]),
                gridContainer(sc[6])]
              ),
            ),
          )
        ],
      ),
      drawer: const CustomNavigationDrawer(),
    );
  }

  Widget gridContainer(ScreenCard sc) {
    return InkWell(
      onTap: () {
        //Navigator.pushNamed(context, sc.route!);
      },
      child: Container(
          //color: Colors.grey,
          //color: Color(0xFF72ed93),
          // boxShadow: [
          //   BoxShadow(blurRadius: 0.5),
          // ],
          // borderRadius:
          //     BorderRadius.all(Radius.circular(15)),
          child: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                child: Image.asset("${sc.imageLoc}"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("${sc.title}"),
              ),
            ],
          )),
    );
  }
}

class ScreenCard {
  String? title;
  String? imageLoc;
  String? route;

  ScreenCard(this.title, this.imageLoc, this.route);
}
