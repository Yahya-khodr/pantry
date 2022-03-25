import 'package:flutter/material.dart';
import 'package:frontend/resources/constants.dart';
import 'package:frontend/views/widgets/category_widget.dart';
import 'package:frontend/views/widgets/custom_appbar_widget.dart';
import 'package:frontend/views/widgets/home_card_widget.dart';
import 'package:frontend/views/widgets/slider_item.dart';

import '../../utils/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          title: Constants.appName,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Common Items",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("See All"),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 2.5,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return const SliderItem();
              },
            ),
          ),
          const SizedBox(
            height: 2.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 2.5,
          ),
          SizedBox(
            height: 65.0,
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 5.0),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                Map cat = categories[index];
                return CategoryItem(icon: cat['icon'], title: cat['name']);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  "Recent Items",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("See All"),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 2.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: SizedBox(
              height: size.height / 3,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return const HomeCard(
                      image:
                          'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
                      title: 'Product Name',
                      date: '3 days',
                      qty: '2L');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
