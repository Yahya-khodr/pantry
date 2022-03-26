import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/viewmodels/product_viewmodel.dart';
import 'package:frontend/views/screens/auth_screens/auth_screen.dart';
import 'package:frontend/views/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Palette.backgroundColor),
        home: const MainScreen(),
      ),
    );
  }
}
