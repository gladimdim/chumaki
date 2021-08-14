import 'package:chumaki/components/ui/game_text.dart';
import 'package:chumaki/components/ui/resized_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InlineHelp extends StatefulWidget {
  final String text;

  const InlineHelp(this.text, {Key? key}) : super(key: key);

  @override
  _InlineHelpState createState() => _InlineHelpState();
}

class _InlineHelpState extends State<InlineHelp> {
  bool showText = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: _toggle,
          child: ResizedImage(
            "images/icons/unknown/unknown.png",
            width: 64,
          ),
        ),
        if (showText) GameText(
          widget.text,
          addStyle: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }

  _toggle() {
    setState(() {
      showText = !showText;
    });
  }
}
