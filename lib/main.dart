import 'package:backpackcheck/ui/utils/preferences.dart';
import 'package:backpackcheck/ui/utils/router2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await Preferences.init();
  if (kDebugMode) {
    FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);
  }
  runApp(MultiProvider(
    providers: [
      Provider(create: (context) => Database()),
      ChangeNotifierProvider(create: (context) => categoryAddedEvent),
    ],
    child: const BackpackCheckApp(),
  ));
}

class BackpackCheckApp extends StatelessWidget {
  const BackpackCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Backpack Check',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}
