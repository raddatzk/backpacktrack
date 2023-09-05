import 'package:backpackcheck/ui/utils/double_extension.dart';
import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({
    Key? key,
    required this.title,
    required this.amount,
    required this.luggage,
    required this.checked,
  }) : super(key: key);

  final String title;
  final double amount;
  final String luggage;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text("${amount.stringify()}x $title"),
      subtitle: Text(luggage),
      value: checked,
      onChanged: (bool? value) {},
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

class StorageItem extends StatelessWidget {
  const StorageItem({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text('available: ${amount.stringify()}'),
    );
  }
}
