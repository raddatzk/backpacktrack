import 'package:backpackcheck/firebase/database.dart';
import 'package:backpackcheck/ui/utils/router2.dart';
import 'package:flutter/material.dart';

class NewCategoryTab extends StatefulWidget {
  const NewCategoryTab({Key? key}) : super(key: key);

  @override
  State<NewCategoryTab> createState() => _NewCategoryTabState();
}

class _NewCategoryTabState extends State<NewCategoryTab> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Add Category',
              textScaleFactor: 2,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Here you can add a new category. Give it a name and an icon',
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: _create,
            child: const Text('Save'),
          )
        ],
      ),
    );
  }

  void _create() async {
    var category = await Database.createCategory(_controller.text);
    if (!context.mounted) return;
    CategoryRoute(categoryId: category.id).navigate(context);
  }
}
