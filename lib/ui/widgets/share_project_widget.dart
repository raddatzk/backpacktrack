import 'package:flutter/material.dart';

class ShareProjectWidget extends StatelessWidget {
  const ShareProjectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          children: const [
            ListTile(
              title: Text('Fabienne'),
              subtitle: Text("write access"),
            ),
          ],
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
      ],
    );
  }
}
