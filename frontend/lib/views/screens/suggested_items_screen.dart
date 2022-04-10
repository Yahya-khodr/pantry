import 'package:flutter/material.dart';
import 'package:frontend/models/shop_item_model.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/services/shop_item_service.dart';
import 'package:frontend/utils/suggestions.dart';
import 'package:frontend/utils/utilities.dart';
import 'package:frontend/viewmodels/food_viewmodel.dart';
import 'package:frontend/views/screens/main_screens/main_screen.dart';
import 'package:frontend/views/widgets/card_item_widget.dart';
import 'package:frontend/views/widgets/custom_button_widget.dart';
import 'package:frontend/views/widgets/custom_text_input_widget.dart';
import 'package:frontend/views/widgets/suggested_card_wdiget.dart';

class SuggestedScreen extends StatefulWidget {
  const SuggestedScreen({Key? key}) : super(key: key);

  @override
  State<SuggestedScreen> createState() => _SuggestedScreenState();
}

class _SuggestedScreenState extends State<SuggestedScreen> {
  late String _itemName;
  int _itemQty = 1;
  final TextEditingController _itemNameController = TextEditingController();
  String? _token;
  List<ShopItem> _shopList = [];
  bool _isLoading = true;
  FoodViewModel foodViewModel = FoodViewModel();

  PersistentBottomSheetController? _controller; // <------ Instance variable
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void createItem() async {
    await foodViewModel.getUserToken().then((token) async {
      setState(() {
        _isLoading = true;
      });

      var response = await ShopService.createItem(token!, _itemName, _itemQty)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainScreen()));
        } else {
          Utilities.showSnackbar(context, "Failed", false);
          Navigator.pop(context);
        }
      });
    });
  }

  void increment() {
    setState(() {
      _itemQty++;
    });
  }

  void decrement() {
    setState(() {
      _itemQty--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggested Items'),
        backgroundColor: Palette.appBarColor,
        flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Palette.appBarColor, Palette.appBarColorLinear],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
          ),
        ),
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.75,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: suggestionsItems.length,
            itemBuilder: (BuildContext context, int index) {
              Map suggestions = suggestionsItems[index];
              return SuggestedCard(
                  onTap: () {
                    setState(() {
                      _itemNameController.text = suggestions['name'];
                    });
                    addShopItem(context, _itemNameController);
                  },
                  image: AssetImage(suggestions['image']),
                  name: suggestions['name']);
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> addShopItem(
      BuildContext context, TextEditingController nameController) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Add Item",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(height: 30),
                      CustomTextInput(
                          textAlign: TextAlign.center,
                          controller: nameController),
                      const SizedBox(height: 2.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleButtonIcon(
                            onPressed: () {
                              setState(() {
                                decrement();
                              });
                            },
                            icon: Icons.remove,
                          ),
                          Text('$_itemQty'),
                          CircleButtonIcon(
                            onPressed: () {
                              setState(() {
                                increment();
                              });
                            },
                            icon: Icons.add,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomElevetadButton(
                            onPressed: () {
                              setState(() {
                                _itemName = nameController.text;
                              });
                              createItem();
                            },
                            icon: Icons.check,
                            text: "Add Item",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
