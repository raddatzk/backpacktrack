import 'package:backpackcheck/ui/widgets/selector.dart';
import 'package:backpackcheck/ui/widgets/share_project_widget.dart';
import 'package:flutter/material.dart';

class ProjectSettingsTab extends StatefulWidget {
  const ProjectSettingsTab({Key? key}) : super(key: key);

  @override
  State<ProjectSettingsTab> createState() => _ProjectSettingsTabState();
}

class _ProjectSettingsTabState extends State<ProjectSettingsTab> {
  bool state = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Selector(
            leftLabel: 'categories',
            rightLabel: 'luggages',
            title: 'Group stuff by',
            callback: (value) {},
          ),
          TextButton(
            onPressed: () {},
            child: const Text('print'),
          ),
          const Divider(),
          const ShareProjectWidget(),
        ],
      ),
    );
  }
}
