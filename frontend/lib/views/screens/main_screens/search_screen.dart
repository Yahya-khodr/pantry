import 'package:flutter/material.dart';
import 'package:frontend/models/food_model.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/services/food_service.dart';
import 'package:frontend/utils/utilities.dart';
import 'package:frontend/viewmodels/food_viewmodel.dart';
import 'package:frontend/views/screens/food_detail_screen.dart';
import 'package:frontend/views/widgets/custom_tile_widget.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class SearchScreen extends StatefulWidget {
 final String? body;
  const SearchScreen({Key? key, this.body}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Food> foodList = [];
  String query = "";
  TextEditingController searchController = TextEditingController();
  FoodViewModel foodViewModel = FoodViewModel();
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getToken();
    searchController.text = widget.body ?? "";
  }

  void getToken() async {
    await foodViewModel.getUserToken().then((token) => getFoods(token!));
  }

  void getFoods(String token) async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    var response = await FoodService.getFoods(token);

    if (response.isNotEmpty) {
      if (mounted) {
        setState(() {
          foodList = response;
          _isLoading = false;
        });
      }
    } else {
      Utilities.showSnackbar(context, "Failed to get foods", false);
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  searchAppBar(BuildContext context) {
    return NewGradientAppBar(
      gradient: const LinearGradient(
          colors: [Palette.gradientColorStart, Palette.gradientColorEnd]),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextField(
            controller: searchController,
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
            cursorColor: Palette.blackColor,
            autofocus: true,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 35,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  WidgetsBinding.instance
                      ?.addPostFrameCallback((_) => searchController.clear());
                },
              ),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Color(0x88ffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildSuggestions(String query) {
    final List<Food> foodSuggestions = query.isEmpty
        ? []
        : foodList != null
            ? foodList.where((Food food) {
                String _getName = food.name!.toLowerCase();
                String _query = query.toLowerCase();
                String _getQty = food.quantity!.toLowerCase();
                bool matchesName = _getName.contains(_query);
                bool matchesQty = _getQty.contains(_query);

                return (matchesQty || matchesName);

                // (User user) => (user.username.toLowerCase().contains(query.toLowerCase()) ||
                //     (user.name.toLowerCase().contains(query.toLowerCase()))),
              }).toList()
            : [];

    return ListView.builder(
      itemCount: foodSuggestions.length,
      itemBuilder: ((context, index) {
        Food searchedFood = Food(
            id: foodSuggestions[index].id,
            imageUrl: foodSuggestions[index].imageUrl,
            name: foodSuggestions[index].name,
            purchasedDate: foodSuggestions[index].purchasedDate,
            expiryDate: foodSuggestions[index].expiryDate,
            total: foodSuggestions[index].total,
            quantity: foodSuggestions[index].quantity);

        return CustomTile(
          mini: false,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FoodDetailScreen(
                          food: searchedFood,
                        )));
          },
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage(Constants.imageApi + searchedFood.imageUrl!),
          ),
          title: Text(
            searchedFood.name!,
            style: const TextStyle(
              color: Palette.appBarColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            searchedFood.quantity!,
            style: const TextStyle(color: Palette.textColor),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: buildSuggestions(query),
      ),
    );
  }
}
