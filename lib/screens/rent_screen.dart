import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';
import '../widgets/navigation_drawer.dart';

class RentScreen extends StatefulWidget {
  const RentScreen({super.key});

  @override
  State<RentScreen> createState() => _BuyOrRentScreenState();
}

class _BuyOrRentScreenState extends State<RentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: CustomColors.firstGradientColor,
          title: Text(
            "Rent an Item",
            style: TextStyle(color: Colors.white),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [Center(child: Text("No Items Available for Rent right now"))],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        
        //TODO : Implement this
        
      }, child: Icon(Icons.shopping_cart_checkout,),)
    );
  }
}
