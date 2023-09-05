import 'package:backpackcheck/firebase/database.dart';
import 'package:backpackcheck/ui/drawer/app_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/preferences.dart';
import '../utils/router2.dart';

class SetupScreen extends StatelessWidget {
  SetupScreen({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: !kDebugMode ? AppDrawer() : null,
      appBar: !kDebugMode ? AppBar() : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to BackPackCheck. Please give yourself a nice name",
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _controller,
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: () => _continue(context),
            ),
          ],
        ),
      ),
    );
  }

  void _continue(BuildContext context) async {
    var user = await Database.createUser(_controller.text);
    Preferences.setUserId(user.id);
    Database.getOrCreateStorage();
    Preferences.setSetupCompleted(true);
    if (!context.mounted) return;
    const NewCategoryRoute().navigate(context);
  }
}
