import 'package:crpt/provider/api/get_currency_provider.dart';
import 'package:crpt/provider/firebase_database/provider_firebase.dart';
import 'package:crpt/ui/coin_manipulation.dart';
import 'package:crpt/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => CurrencyProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ProviderFirebase(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
