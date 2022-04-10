import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:frontend/models/food_model.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/services/food_service.dart';
import 'package:frontend/utils/utilities.dart';
import 'package:frontend/viewmodels/food_viewmodel.dart';
import 'package:frontend/views/screens/food_detail_screen.dart';
import 'package:frontend/views/screens/main_screens/expired_screen.dart';
import 'package:frontend/views/screens/main_screens/foods_screen.dart';
import 'package:frontend/views/screens/main_screens/speech_to_text_screen.dart';
import 'package:frontend/views/widgets/category_widget.dart';
import 'package:frontend/views/widgets/custom_appbar_widget.dart';
import 'package:frontend/views/widgets/expired_card_widget.dart';
import 'package:frontend/views/widgets/home_card_widget.dart';
import 'package:frontend/views/widgets/slider_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _token;
  List<Food> _foods = [];
  List<Food> _expiredList = [];
  bool _isLoadingExpiry = true;
  bool _isLoadingRecent = true;
  bool _isLoading = false;
  FoodViewModel foodViewModel = FoodViewModel();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      getToken();
    });
  }

  void getToken() async {
    setState(() {
      _isLoading = true;
    });
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _token = prefs.getString("token");
    });
    print(_token);

    if (_token != null) {
      await FoodService.getRecentFoods(_token!).then((value) {
        if (value.isNotEmpty) {
          if (mounted) {
            setState(() {
              _foods = value;
              _isLoadingRecent = false;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _isLoadingRecent = false;
            });
          }
        }
      });
      await FoodService.getExpiredFoods(_token!).then((value) {
        if (value.isNotEmpty) {
          if (mounted) {
            setState(() {
              _expiredList = value;
              _isLoadingExpiry = false;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _isLoadingExpiry = false;
            });
          }
        }
      });
    }
  }

  void getRecentFoods(String token) async {
    if (mounted) {
      setState(() {
        _isLoadingExpiry = true;
      });
    }
    var response = await FoodService.getRecentFoods(token);
    if (response.isNotEmpty) {
      if (mounted) {
        setState(() {
          _foods = response;
          _isLoadingExpiry = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoadingExpiry = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
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
          title: Constants.appName,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          foodViewModel.getUserToken().then((token) => getRecentFoods(token!));
        },
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    "Popular Foods",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Palette.appBarColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemExtent: 280,
                  itemCount: foodSlider.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map foodsList = foodSlider[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SliderItem(
                        text: foodsList['name'],
                        image: foodsList['image'],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 2.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Expired items",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Palette.appBarColor),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExpiredScreen())),
                    child: const Text(
                      "See All",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Palette.appBarColor),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: size.height / 6,
                child: _isLoadingExpiry
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _expiredList.isEmpty
                        ? const Center(
                            child: Text(
                              "Foods are safe",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Palette.textColor),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemExtent: 180,
                            itemCount: _expiredList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ExpiredCard(
                                  food: _expiredList[index],
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FoodDetailScreen(
                                          food: _expiredList[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
              ),
            ),
            const SizedBox(
              height: 2.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Recent Items",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Palette.appBarColor),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FoodsScreen())),
                    child: const Text(
                      "See All",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Palette.appBarColor),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 2.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                height: size.height / 4,
                child: _isLoadingRecent
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _foods.isEmpty
                        ? const Center(
                            child: Text(
                              "No recent food",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Palette.textColor),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _foods.length,
                            itemBuilder: (BuildContext context, int index) {
                              return HomeCard(
                                food: _foods[index],
                                ontap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FoodDetailScreen(
                                                food: _foods[index],
                                              )));
                                },
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
