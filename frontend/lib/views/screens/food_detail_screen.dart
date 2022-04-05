import 'package:flutter/material.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/viewmodels/food_viewmodel.dart';
import 'package:frontend/views/screens/main_screens/scan_detail_screen.dart';
import 'package:frontend/views/widgets/custom_button_widget.dart';
import 'package:frontend/views/widgets/custom_listtile_widget.dart';
import 'package:frontend/views/widgets/rounded_button_widget.dart';
import 'package:provider/provider.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<FoodViewModel>(context, listen: false).foodList;
  }

  @override
  Widget build(BuildContext context) {
    FoodViewModel foodViewModel = context.watch<FoodViewModel>();
    FoodViewModel productViewModel = context.watch<FoodViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        title: Text(foodViewModel.selectedFood.name!),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: foodViewModel.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Hero(
                                tag: Constants.imageApi +
                                    foodViewModel.selectedFood.imageUrl!,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image(
                                    image: NetworkImage(Constants.imageApi +
                                        foodViewModel.selectedFood.imageUrl!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              name: foodViewModel.selectedFood.expiryDate
                                  .toString()),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundedButton(
                              width: 200,
                              // onPressed: () => Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) {
                              //       return ScanDetailScreen(
                              //         barcode:
                              //             foodViewModel.selectedFood.barcode!,
                              //         image:
                              //             foodViewModel.selectedFood.imageUrl ??
                              //                 "",
                              //         qty: foodViewModel.selectedFood.quantity!,
                              //         name: foodViewModel.selectedFood.name!,
                                      
                              //       );
                              //     },
                              //   ),
                              // ),
                              onPressed: (){},
                              icon: Icons.edit,
                              text: 'Edit Item',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
