import 'package:backpackcheck/ui/utils/router2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/preferences.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);

  final Key _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return _AppDrawer(
      key: _key,
      child: ListView(
        children: [
          ListTile(
            title: const Text('Storage'),
            onTap: () {
              switch (Preferences.getLastStorageUrl()) {
                case 'new':
                  const NewCategoryRoute().navigate(context);
                  break;
                default:
                  CategoryRoute(categoryId: Preferences.getLastStorageUrl()).navigate(context);
                  break;
              }
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Mallorca 2023'),
            onTap: () => context.go('/projects/mallorca2023'),
          ),
          if (kDebugMode) const Divider(),
          if (kDebugMode)
            ListTile(
              title: const Text('Setup'),
              onTap: () {
                Preferences.setSetupCompleted(false);
                const SetupRoute().navigate(context);
              },
            ),
        ],
      ),
    );
  }
}

class _AppDrawer extends Drawer {
  const _AppDrawer({required Widget child, Key? key}) : super(key: key, child: child);
}
