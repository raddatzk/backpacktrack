import 'package:flutter/material.dart';

enum SelectorResult {
  left,
  right,
}

typedef SelectorCallback = void Function(SelectorResult);

class Selector extends StatefulWidget {
  const Selector({
    Key? key,
    required this.leftLabel,
    required this.rightLabel,
    required this.title,
    required this.callback,
  }) : super(key: key);

  final String leftLabel;
  final String rightLabel;
  final String title;
  final SelectorCallback callback;

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  bool _state = false;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(widget.title),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.leftLabel),
            Switch(
              value: _state,
              onChanged: (value) => setState(() {
                _state = value;
              }),
              inactiveTrackColor: colorScheme.secondary.withOpacity(0.5),
              inactiveThumbColor: colorScheme.secondary,
            ),
            Text(widget.rightLabel),
          ],
        ),
      ],
    );
  }
}
