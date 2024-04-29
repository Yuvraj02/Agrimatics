import 'package:agrimatics/model/store_item_model.dart';
import 'package:agrimatics/providers/store_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {


  @override
  void initState() {
    // TODO: implement initState
    getClientStream();
    super.initState();
  }

  List _allResults = [];

  getClientStream() async {
    var data = await FirebaseFirestore.instance.collection('store').orderBy('name').get();

    setState(() {
      _allResults = data.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Store",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF2caa5e),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                categoryContainer("Seeds"),
                categoryContainer("Crop Nutrition"),
                categoryContainer("Crop Protection"),
                categoryContainer("Irrigation Accessories"),
                categoryContainer("Agricultral Implements")
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<StoreItemModel>>(
              stream: context.read<StoreProvider>().readPosts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Oops! There's some Error getting Items"),
                  );
                } else if (snapshot.hasData) {
                  final store = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: store.map(itemWidget).toList(),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No Items Listed"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {},
      ),
    );
  }

  Widget itemWidget(StoreItemModel storeModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              child: Image.network(storeModel.imageUrl!),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storeModel.name!,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Text(
                      storeModel.category!,
                      style: TextStyle(color: Colors.grey),
                    ),
                    storeModel.category == 'Seed'
                        ? Text(
                            "₹${storeModel.price}/kg",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )
                        : Text("₹${storeModel.price}",
                            style: TextStyle(fontWeight: FontWeight.w600))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoryContainer(String categoryName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 120,
              width: 120,
              child: Image.asset("assets/store/${categoryName}.png"),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "$categoryName",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
