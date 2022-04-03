

import 'package:flutter/material.dart';

import 'package:frontend/resources/constants.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/viewmodels/food_viewmodel.dart';
import 'package:frontend/viewmodels/user_viewmodel.dart';
import 'package:frontend/views/screens/main_screens/main_screen.dart';
import 'package:frontend/views/widgets/date_time_field.dart';
import 'package:frontend/views/widgets/rounded_button_widget.dart';
import 'package:frontend/views/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class EditFoodScreen extends StatefulWidget {
  const EditFoodScreen({Key? key, required this.barcode}) : super(key: key);
  final String barcode;
  @override
  State<EditFoodScreen> createState() => _EditFoodScreenState();
}

class _EditFoodScreenState extends State<EditFoodScreen> {
  bool isLoading = false;
  // ignore: unused_field
  String? _token;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _purchaseDateController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();


  // ignore: prefer_typing_uninitialized_variables
  var foodList;
  FoodViewModel foodViewModel = FoodViewModel();
  @override
  void initState() {
    super.initState();
    Provider.of<FoodViewModel>(context, listen: false).foodList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserViewModel userViewModel = context.watch<UserViewModel>();
    FoodViewModel foodViewModel = context.watch<FoodViewModel>();

    if (userViewModel.loading) {
      setState(() {
        isLoading = true;
      });
    } else {
      setState(() {
        isLoading = false;
        _token = userViewModel.token;
        _barcodeController.text = widget.barcode;
      });
    }

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                ),
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("Add item"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 14.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: size.width / 2.5,
                            height: size.height / 4.5 - 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image(
                                image: NetworkImage(Constants.imageApi +
                                    foodViewModel.selectedFood.imageUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              SizedBox(
                                width: size.width / 2.5,
                                height: size.height / 4.5 - 10,
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(
                                        hintText: 'product name',
                                      ),
                                    ),
                                    TextField(
                                      enabled: false,
                                      controller: _barcodeController,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    ExpansionTile(
                      initiallyExpanded: true,
                      textColor: Palette.appBarColor,
                      iconColor: Palette.appBarColor,
                      title: const Text(
                        "Product Details",
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                controller: _typeController,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 14.0),
                                  child: Text("Category:"),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                controller: _quantityController,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 14.0),
                                  child: Text("Qty:"),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              BasicDateField(
                                controller: _purchaseDateController,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 14.0),
                                  child: Text(
                                    "Purchased date:",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              BasicDateField(
                                controller: _expiryDateController,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 14.0),
                                  child: Text(
                                    "Expiry date:",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: RoundedButton(
                text: "Cancel",
                color: Palette.buttonColorRed,
                width: size.width,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              flex: 3,
              child: RoundedButton(
                text: "Save",
                width: size.width,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await foodViewModel.getUserToken().then((value) async {
                    // await FoodService.addFood(
                    //   value!,
                    //   _barcodeController.text,
                    //   _nameController.text,
                    //   _quantityController.text,
                    //   Utilities.stringToDateTime(_expiryDateController.text),
                    //   Utilities.stringToDateTime(_purchaseDateController.text),
                    //   _typeController.text,

                    // );
                  });

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
