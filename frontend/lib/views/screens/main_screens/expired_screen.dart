import 'package:flutter/material.dart';
import 'package:frontend/models/food_model.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/services/food_service.dart';
import 'package:frontend/utils/suggestions.dart';
import 'package:frontend/viewmodels/food_viewmodel.dart';
import 'package:frontend/views/widgets/expired_card_widget.dart';
import 'package:frontend/views/widgets/suggested_card_wdiget.dart';

class ExpiredScreen extends StatefulWidget {
  const ExpiredScreen({Key? key}) : super(key: key);

  @override
  State<ExpiredScreen> createState() => _ExpiredScreenState();
}

class _ExpiredScreenState extends State<ExpiredScreen> {
  bool _isLoading = false;
  List<Food> _expiredList = [];
  FoodViewModel foodViewModel = FoodViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  void getToken() async {
    foodViewModel.getUserToken().then((token) => {getExpiredFoods(token!)});
  }

  void getExpiredFoods(String token) async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    var response = await FoodService.getExpiredFoods(token);
    if (response.isNotEmpty) {
      if (mounted) {
        setState(() {
          _expiredList = response;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expired Items'),
        backgroundColor: Palette.appBarColor,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: _expiredList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpiredCard(
                      food: _expiredList[index],
                      onTap: () {},
                    );
                  },
                ),
              ),
            ),
    );
  }
}
