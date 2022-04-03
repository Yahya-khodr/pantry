import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/viewmodels/food_viewmodel.dart';
import 'package:frontend/viewmodels/product_viewmodel.dart';
import 'package:frontend/viewmodels/user_viewmodel.dart';
import 'package:frontend/views/screens/auth_screens/auth_screen.dart';
import 'package:frontend/views/screens/main_screens/main_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FoodViewModel foodViewModel = FoodViewModel();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FoodViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
      ],
      child: MaterialApp(
          title: 'Pantry Tracker',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Palette.backgroundColor),
          home: FutureBuilder<String?>(
            future: foodViewModel.getUserToken(),
            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                return const MainScreen();
              }
              return const Authentication();
            },
          )),
    );
  }
}
