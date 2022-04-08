// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/models/nutriment_model.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/services/food_service.dart';
import 'package:frontend/utils/categories.dart';
import 'package:frontend/utils/image_cropper.dart';
import 'package:frontend/utils/utilities.dart';
import 'package:frontend/viewmodels/food_viewmodel.dart';
import 'package:frontend/viewmodels/product_viewmodel.dart';
import 'package:frontend/viewmodels/user_viewmodel.dart';
import 'package:frontend/views/screens/main_screens/main_screen.dart';
import 'package:frontend/views/widgets/custom_text_input_widget.dart';
import 'package:frontend/views/widgets/date_time_field.dart';
import 'package:frontend/views/widgets/rounded_button_widget.dart';
import 'package:frontend/views/widgets/text_field_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ScanDetailScreen extends StatefulWidget {
  const ScanDetailScreen({
    Key? key,
    required this.barcode,
    required this.name,
    required this.qty,
    required this.image,
    this.nutriments,
  }) : super(key: key);
  final String barcode;
  final String name;
  final String qty;
  final String image;
  final Nutriments? nutriments;

  @override
  State<ScanDetailScreen> createState() => _ScanDetailScreenState();
}

class _ScanDetailScreenState extends State<ScanDetailScreen> {
  String? _token;
  bool isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _purchaseDateController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _proteinsController = TextEditingController();
  final TextEditingController _sodiumController = TextEditingController();
  final TextEditingController _sugarController = TextEditingController();
  final TextEditingController _fiberController = TextEditingController();
  final TextEditingController _saturatedFatController = TextEditingController();
  final TextEditingController _saltController = TextEditingController();
  Product? _product;
  File? _selectedFile;
  // ignore: unused_field
  bool _inProcess = false;
  var foodList;
  var imageUrl;
  FoodViewModel foodViewModel = FoodViewModel();
  ProductViewModel productViewModel = ProductViewModel();

  @override
  void initState() {
    super.initState();
    getToken();
    Provider.of<FoodViewModel>(context, listen: false).foodList;
    initializeData();
    _barcodeController.text = widget.barcode;
  }

  void getToken() async {
    foodViewModel.getUserToken().then((value) {
      setState(() {
        value = _token!;
      });
    });
  }

  void initializeData() async {
    _nameController.value = _nameController.value.copyWith(
      text: widget.name,
      selection: widget.name != null
          ? TextSelection.collapsed(offset: widget.name.length)
          : null,
    );
    _quantityController.value = _quantityController.value.copyWith(
      text: widget.qty,
      selection: widget.qty != null
          ? TextSelection.collapsed(offset: widget.qty.length)
          : null,
    );
    _fatController.value = _fatController.value.copyWith(
      text: widget.nutriments?.fat.toString(),
    );
    _proteinsController.value = _proteinsController.value.copyWith(
      text: widget.nutriments?.proteins.toString(),
    );
    _sodiumController.value = _sodiumController.value.copyWith(
      text: widget.nutriments?.sodium.toString(),
    );
    _sugarController.value = _sugarController.value.copyWith(
      text: widget.nutriments?.sugars.toString(),
    );
    _fiberController.value = _fiberController.value.copyWith(
      text: widget.nutriments?.fiber.toString(),
    );
    _saturatedFatController.value = _saturatedFatController.value.copyWith(
      text: widget.nutriments?.saturatedFat.toString(),
    );
    _saltController.value = _saltController.value.copyWith(
      text: widget.nutriments?.salt.toString(),
    );
  }

  _selectImage(ImageSource source) async {
    setState(() {
      _inProcess = true;
    });
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      File? cropped = await ImagesCropper.cropImage(image);

      setState(() {
        _selectedFile = cropped!;
        _inProcess = false;
      });
    } else {
      setState(() {
        _inProcess = false;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FoodViewModel foodViewModel = context.watch<FoodViewModel>();
    ProductViewModel productViewModel = context.watch<ProductViewModel>();

    String? selectedCategory = "Others";
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
        title: const Text("Add Item"),
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
                          Stack(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: _selectedFile != null
                                      ? Image.file(_selectedFile!)
                                      : widget.image.isEmpty
                                          ? Image.asset(
                                              "assets/images/food_placeholder.png",
                                              fit: BoxFit.cover,
                                              width: 100.0,
                                              height: 100.0,
                                            )
                                          : Image.network(
                                              widget.image,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                ),
                              ),
                              Positioned(
                                right: 15,
                                bottom: -2,
                                child: GestureDetector(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  onTap: () {
                                    _selectImage(ImageSource.camera);
                                  },
                                ),
                              ),
                            ],
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
                                        labelText: "Product Name",
                                        hintText: 'product name',
                                      ),
                                    ),
                                    TextField(
                                      decoration: const InputDecoration(
                                          labelText: "Barcode"),
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
                              Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ThemeData()
                                        .colorScheme
                                        .copyWith(primary: Palette.appBarColor),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: "Category",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: const BorderSide(
                                              color: Palette.appBarColor,
                                              width: 2.0)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: const BorderSide(
                                              color: Palette.appBarColor,
                                              width: 2.0)),
                                    ),
                                    value: selectedCategory,
                                    items: categoriesList
                                        .map((gender) =>
                                            DropdownMenuItem<String>(
                                                value: gender,
                                                child: Text(
                                                  gender,
                                                )))
                                        .toList(),
                                    onChanged: (gender) => setState(
                                      () {
                                        selectedCategory = gender;
                                      },
                                    ),
                                  ),
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
                    ExpansionTile(
                      initiallyExpanded: true,
                      textColor: Palette.appBarColor,
                      iconColor: Palette.appBarColor,
                      title: const Text(
                        "Nutriments",
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: CustomTextInput(
                                        labelText: "Carbohydrates",
                                        controller: _fatController,
                                        keyboardType: TextInputType.number,
                                        suffixText: 'g'),
                                  ),
                                  Expanded(
                                    child: CustomTextInput(
                                        labelText: "Energy",
                                        controller: _proteinsController,
                                        keyboardType: TextInputType.number,
                                        suffixText: 'kcal'),
                                  ),
                                  Expanded(
                                    child: CustomTextInput(
                                        labelText: "Salt",
                                        controller: _saltController,
                                        keyboardType: TextInputType.number,
                                        suffixText: 'g'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: CustomTextInput(
                                        labelText: "Fat",
                                        controller: _fatController,
                                        keyboardType: TextInputType.number,
                                        suffixText: 'g'),
                                  ),
                                  Expanded(
                                    child: CustomTextInput(
                                        labelText: "Proteins",
                                        controller: _proteinsController,
                                        keyboardType: TextInputType.number,
                                        suffixText: 'g'),
                                  ),
                                  Expanded(
                                    child: CustomTextInput(
                                        labelText: "Sodium",
                                        controller: _sodiumController,
                                        keyboardType: TextInputType.number,
                                        suffixText: 'g'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: CustomTextInput(
                                        labelText: "Sugar",
                                        controller: _sugarController,
                                        keyboardType: TextInputType.number,
                                        suffixText: 'g'),
                                  ),
                                  Expanded(
                                    child: CustomTextInput(
                                        labelText: "Fiber",
                                        controller: _fiberController,
                                        keyboardType: TextInputType.number,
                                        suffixText: 'g'),
                                  ),
                                  Expanded(
                                    child: CustomTextInput(
                                        labelText: "SaturatedFat",
                                        controller: _saturatedFatController,
                                        keyboardType: TextInputType.number,
                                        suffixText: 'g'),
                                  ),
                                ],
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundedButton(
              icon: Icon(Icons.check),
              text: "Add Item",
              width: size.width / 2,
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await foodViewModel.getUserToken().then((value) async {
                  await FoodService.addFood(
                    value!,
                    _barcodeController.text,
                    _nameController.text,
                    _quantityController.text,
                    Utilities.stringToDateTime(_expiryDateController.text),
                    Utilities.stringToDateTime(_purchaseDateController.text),
                    _typeController.text,
                    _selectedFile!,
                  );
                });

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
