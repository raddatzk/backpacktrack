import 'package:flutter/material.dart';

import 'item.dart';

enum CategoryTabType {
  project,
  storage,
}

class ProjectCategoryTab extends StatelessWidget {
  const ProjectCategoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                ProjectItem(
                  title: 'Kletterschuhe Scarpa',
                  amount: 1.0,
                  luggage: "großer Koffer",
                  checked: true,
                ),
                ProjectItem(
                  title: 'Wäscheleine',
                  amount: 2.0,
                  luggage: "Handgepäck, großer Koffer",
                  checked: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StorageCategoryTab extends StatelessWidget {
  const StorageCategoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                StorageItem(
                  title: 'Kletterschuhe Scarpa',
                  amount: 1,
                ),
                StorageItem(
                  title: 'Wäscheleine',
                  amount: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}