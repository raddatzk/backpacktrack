import 'package:backpackcheck/ui/drawer/app_drawer.dart';
import 'package:backpackcheck/ui/widgets/project_settings_tab.dart';
import 'package:flutter/material.dart';

import '../widgets/category_tab.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({Key? key, required this.title, required this.project, this.category}) : super(key: key);

  final String title;
  final String project;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            )
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Climbing', icon: Icon(Icons.abc)),
              Tab(text: 'Clothes', icon: Icon(Icons.ac_unit)),
              Tab(icon: Icon(Icons.settings)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ProjectCategoryTab(),
            ProjectCategoryTab(),
            ProjectSettingsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}
