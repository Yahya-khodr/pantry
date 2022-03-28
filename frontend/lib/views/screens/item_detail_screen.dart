import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/viewmodels/product_viewmodel.dart';
import 'package:frontend/views/screens/main_screen.dart';
import 'package:frontend/views/widgets/custom_text_input_widget.dart';
import 'package:frontend/views/widgets/rounded_button_widget.dart';
import 'package:frontend/views/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({Key? key}) : super(key: key);

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    TextEditingController _nameController = TextEditingController();
    TextEditingController _typeCotnroller = TextEditingController();
    TextEditingController _quantityController = TextEditingController();
    TextEditingController _purchaseDateController = TextEditingController();
    TextEditingController _expiryDateController = TextEditingController();

    Size size = MediaQuery.of(context).size;
    ProductViewModel productViewModel = context.watch<ProductViewModel>();
    if (productViewModel.loading) {
      setState(() {
        isLoading = true;
      });
    } else {
      setState(() {
        isLoading = false;
        _nameController.text = productViewModel.product?.productName ?? "";
      });
    }
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Palette.appBarColor,
        leading: IconButton(
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainScreen())),
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Item Name'),
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
                                image: NetworkImage(productViewModel
                                        .product?.imageUrl ??
                                    'https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807?k=20&m=1147544807&s=612x612&w=0&h=pBhz1dkwsCMq37Udtp9sfxbjaMl27JUapoyYpQm0anc='),
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
                                      controller: _nameController,
                                      decoration: const InputDecoration(
                                        hintText: 'barcode',
                                      ),
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
                                controller: _typeCotnroller,
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
                              CustomTextField(
                                controller: _purchaseDateController,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 14.0),
                                  child: Text("Purchased Date:"),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
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
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 3,
              child: RoundedButton(
                text: "Save",
                width: size.width,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
