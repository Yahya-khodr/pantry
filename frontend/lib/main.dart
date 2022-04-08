import 'package:flutter/material.dart';
import 'package:frontend/resources/palette.dart';
import 'package:frontend/services/notification_service.dart';
import 'package:frontend/viewmodels/food_viewmodel.dart';
import 'package:frontend/viewmodels/product_viewmodel.dart';
import 'package:frontend/viewmodels/user_viewmodel.dart';
import 'package:frontend/views/screens/auth_screens/auth_screen.dart';
import 'package:frontend/views/screens/main_screens/main_screen.dart';
import 'package:frontend/views/screens/main_screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

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
    NotificationService.init(initScheduled: true);
    listenNotification();
    tz.initializeTimeZones();
    super.initState();

    NotificationService.showScheduledNotification(
        title: 'Alert',
        body: 'Some products are expiring soon check them !',
        payLoad: 'daily alerts',
        scheduledDate: DateTime.now().add(const Duration(seconds: 15)));
  }

  void listenNotification() => NotificationService.onNotifications.stream
      .listen((value) => {onClickedNotify});

  void onClickedNotify(String? payload) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MainScreen()));
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
          routes: {
            '/search_screen': (context) => SearchScreen(),
          },
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
