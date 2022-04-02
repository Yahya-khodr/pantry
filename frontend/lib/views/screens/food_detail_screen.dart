import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/viewmodels/food_viewmodel.dart';
import 'package:frontend/views/screens/scan_detail_screen.dart';
import 'package:frontend/views/widgets/custom_button_widget.dart';
import 'package:frontend/views/widgets/custom_listtile_widget.dart';
import 'package:provider/provider.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodViewModel foodViewModel = context.watch<FoodViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        title: Text(foodViewModel.selectedFood.name!),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Row(
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 14.0),
                      child: Text(
                        "Item Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2.5,
                ),
                Column(
                  children: <Widget>[
                    CustomTile(
                        title: 'Product Name :',
                        name: foodViewModel.selectedFood.name!),
                    CustomTile(
                        title: 'Expiry date :',
                        name: foodViewModel.selectedFood.expiryDate.toString()),
                    CustomTile(
                        title: 'Purchased Date :',
                        name: foodViewModel.selectedFood.purchasedDate!),
                    CustomTile(
                        title: 'Quantity :',
                        name: foodViewModel.selectedFood.quantity!),
                  ],
                ),
                const SizedBox(
                  height: 2.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomElevetadButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ScanDetailScreen(
                              barcode: foodViewModel.selectedFood.barcode!,
                              image: foodViewModel.selectedFood.imageUrl ?? "",
                              qty: foodViewModel.selectedFood.quantity!,
                              name: foodViewModel.selectedFood.name!,
                            );
                          },
                        ),
                      ),
                      text: 'Edit Item',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
