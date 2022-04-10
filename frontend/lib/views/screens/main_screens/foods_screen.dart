import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/food_model.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/services/food_service.dart';
import 'package:frontend/utils/categories.dart';
import 'package:frontend/utils/utilities.dart';
import 'package:frontend/viewmodels/food_viewmodel.dart';
import 'package:frontend/views/screens/food_detail_screen.dart';
import 'package:frontend/views/screens/main_screens/speech_to_text_screen.dart';
import 'package:frontend/views/widgets/card_item_widget.dart';
import 'package:frontend/views/widgets/custom_appbar_widget.dart';
import 'package:frontend/views/widgets/custom_button_widget.dart';
import 'package:frontend/views/widgets/home_card_widget.dart';
import 'package:provider/provider.dart';


class FoodsScreen extends StatefulWidget {
  const FoodsScreen({Key? key}) : super(key: key);

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen>
    with SingleTickerProviderStateMixin {
  String? _token;
  late TabController _tabController;
  FoodViewModel foodViewModel = FoodViewModel();
  List<Food> _foodList = [];
  bool isGridView = true;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    getToken();
    _tabController = TabController(
        vsync: this, initialIndex: 0, length: categoriesList.length);
    _tabController.addListener(() {});
  }

  void getToken() async {
    await foodViewModel.getUserToken().then((token) async {
      await getFoods(token!);
    });
  }

  Future<void> getFoods(String token) async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    var response = await FoodService.getFoods(token);
    if (response.isNotEmpty) {
      if (mounted) {
        setState(() {
          _foodList = response;
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

  void increaseQuantity(Food food, int idx) async {
    var response = await FoodService.increaseFoodQuantity(food.id!, _token!);
    if (response.responseCode == 200) {
      Utilities.showSnackbar(context, response.message, true);
      setState(() {
        foodViewModel.foodList[idx].total =
            foodViewModel.foodList[idx].total! + 1;
      });
    } else {
      Utilities.showSnackbar(context, response.message, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FoodViewModel foodViewModel = context.watch<FoodViewModel>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height / 6.5),
        child: CustomAppBar(
          title: "List Items",
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Palette.appNameColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            controller: _tabController,
            labelStyle: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
            ),
            tabs: <Widget>[
              for (int i = 0; i < categoriesList.length; i++)
                Tab(
                  text: categoriesList[i],
                ),
            ],
          ),
          iconButton: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/search_screen");
              },
              icon: const Icon(Icons.search)),
          voiceButton: IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SpeechScreen())),
            icon: const Icon(Icons.mic),
          ),

          // iconButton: IconButton(
          //   icon: isGridView
          //       ? const Icon(Icons.grid_on)
          //       : const Icon(Icons.grid_off_rounded),
          //   onPressed: () {
          //     setState(() {
          //       isGridView = !isGridView;
          //     });
          //   },
          // ),
        ),
      ),
      body: foodViewModel.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                foodViewModel
                    .getUserToken()
                    .then((value) => foodViewModel.getFoods(value!));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: foodViewModel.foodList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("No items"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomElevetadButton(
                                  icon: Icons.refresh,
                                  onPressed: () async {
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    foodViewModel.getUserToken().then((value) =>
                                        foodViewModel.getFoods(value!));
                                  },
                                  text: "Refresh",
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : isGridView
                        ? Consumer<FoodViewModel>(
                            builder: (context, provider, cardItem) {
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 1.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                itemCount: foodViewModel.foodList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Food food = foodViewModel.foodList[index];
                                  return CardItem(
                                    onTap: () async {
                                      foodViewModel.setSelectedFood(food);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FoodDetailScreen(
                                            food: food,
                                          ),
                                        ),
                                      );
                                    },
                                    total: food.total ?? 1,
                                    image: CachedNetworkImageProvider(
                                      Constants.imageApi + food.imageUrl!,
                                    ),
                                    name: food.name ?? "No name",
                                    qty: food.quantity ?? "No qty",
                                    purchased: food.purchasedDate.toString(),
                                    date: Utilities.daysBetween(DateTime.now(),
                                            DateTime.parse(food.expiryDate!))
                                        .toString(),
                                    increase: () async {
                                      increaseQuantity(food, index);
                                    },
                                    decrease: () async {},
                                  );
                                },
                              );
                            },
                          )
                        : SizedBox(
                            height: size.height,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: foodViewModel.foodList.length,
                              itemBuilder: (BuildContext context, int index) {
                                Food food = foodViewModel.foodList[index];
                                return HomeCard(
                                  food: food,
                                  ontap: () async {
                                    foodViewModel.setSelectedFood(food);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FoodDetailScreen(
                                          food: food,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
              ),
            ),
    );
  }
}
