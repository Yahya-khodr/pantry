import 'package:flutter/material.dart';
import 'package:frontend/models/shop_item_model.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/services/shop_item_service.dart';
import 'package:frontend/utils/suggestions.dart';
import 'package:frontend/utils/utilities.dart';
import 'package:frontend/viewmodels/food_viewmodel.dart';
import 'package:frontend/views/screens/suggested_items_screen.dart';
import 'package:frontend/views/widgets/card_item_widget.dart';
import 'package:frontend/views/widgets/custom_appbar_widget.dart';
import 'package:frontend/views/widgets/custom_button_widget.dart';
import 'package:frontend/views/widgets/custom_text_input_widget.dart';
import 'package:frontend/views/widgets/shop_item_widget.dart';
import 'package:frontend/views/widgets/suggested_card_wdiget.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late String _itemName;
  int _itemQty = 1;
  final TextEditingController _itemNameController = TextEditingController();
  String? _token;
  List<ShopItem> _shopList = [];
  bool _isLoading = true;
  FoodViewModel foodViewModel = FoodViewModel();

  PersistentBottomSheetController? _controller; // <------ Instance variable
  final _scaffoldKey =
      GlobalKey<ScaffoldState>(); // <---- Another instance variable
  @override
  void initState() {
    super.initState();
    getToken();
  }

  void getToken() async {
    await foodViewModel.getUserToken().then((token) {
      getShopItems(token!);
      setState(() {
        _token = token;
      });
    });
  }

  void getShopItems(String token) async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    var response = await ShopService.getItems(token);
    if (response.isNotEmpty) {
      if (mounted) {
        setState(() {
          _shopList = response;
          _isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void deleteItem(ShopItem shopItem) async {
    await foodViewModel.getUserToken().then((token) async {
      var response = await ShopService.deleteShopItem(token!, shopItem.id!);
      if (response) {
        getShopItems(_token!);
      } else {
        Utilities.showSnackbar(context, "Failed to delete item", false);
      }
    });
  }

  void createItem() async {
    await foodViewModel.getUserToken().then((token) async {
      setState(() {
        _isLoading = true;
      });

      var response = await ShopService.createItem(token!, _itemName, _itemQty)
          .then((value) {
        setState(() {
          _isLoading = false;
          getShopItems(token);
        });
        if (value) {
          Navigator.pop(context);
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          iconButton:
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          title: "Shopping list",
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Suggested Items",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SuggestedScreen())),
                  child: const Text(
                    "See All",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Palette.appBarColor),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemExtent: 150,
                itemCount: suggestionsItems.length,
                itemBuilder: (BuildContext context, int index) {
                  Map suggestions = suggestionsItems[index];
                  return SuggestedCard(
                      image: AssetImage(suggestions['image']),
                      name: suggestions['name']);
                },
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text("Add items to buy"),
                      CustomElevetadButton(
                        onPressed: () async {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Container(
                                        padding: const EdgeInsets.all(30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            const Text(
                                              "Add Item",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 30),
                                            ),
                                            const SizedBox(height: 30),
                                            CustomTextInput(
                                                controller:
                                                    _itemNameController),
                                            const SizedBox(height: 2.5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CustomElevetadButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _itemName =
                                                          _itemNameController
                                                              .text;
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
                        },
                        icon: Icons.add,
                        text: 'Add Item',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: size.height,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _shopList.isEmpty
                      ? const Center(
                          child: Text("No items"),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _shopList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ShopItemCard(
                              onPressed: () {
                                deleteItem(_shopList[index]);
                              },
                              shopItem: _shopList[index],
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
