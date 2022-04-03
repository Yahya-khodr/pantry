import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/viewmodels/food_viewmodel.dart';
import 'package:frontend/viewmodels/product_viewmodel.dart';
import 'package:frontend/views/screens/main_screens/scan_detail_screen.dart';
import 'package:frontend/views/screens/main_screens/foods_screen.dart';
import 'package:frontend/views/screens/profile_screen.dart';
import 'package:frontend/views/widgets/tabbar_material_widget.dart';
import 'package:provider/provider.dart';

import '../../../resources/palette.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  String barcode = "";
  Product? _product;
  bool _isLoading = false;
  final screens = const <Widget>[
    // HomeScreen(),
    FoodsScreen(),
    // ProfileScreen(),
    ProfileScreen()
  ];
  @override
  void initState() {
    super.initState();
    Provider.of<FoodViewModel>(context, listen: false);
    Provider.of<ProductViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.watch<ProductViewModel>();
    FoodViewModel foodViewModel = context.watch<FoodViewModel>();

    return Scaffold(
      extendBody: true,
      body: productViewModel.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : screens[index],
      bottomNavigationBar: TabBarMaterialWidget(
        index: index,
        onChangedTab: onChangedTab,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() async {
          scanBarcode().then((value) async {
            setState(() {
              _isLoading = true;
            });
            await productViewModel.fetchProduct(barcode);
          }).then((value) {
            setState(() {
              _isLoading = false;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ScanDetailScreen(
                  barcode: barcode,
                  image: productViewModel.product?.imageUrl ?? "",
                  name: productViewModel.product?.productName ?? "",
                  qty: productViewModel.product?.quantity ??
                      productViewModel.product?.productQuantity ??
                      "",
                ),
              ),
            );
          });
        }),
        backgroundColor: Palette.appBarColor,
        child: SvgPicture.asset("assets/svg/scan_icon.svg", height: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }

  Future<void> scanBarcode() async {
    try {
      await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      ).then((barcode) {
        setState(() {
          this.barcode = barcode;
        });
      });
    } on PlatformException {
      barcode = 'Failed to get platform version';
    }
  }
}
