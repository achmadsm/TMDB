import 'package:core/styles/text_styles.dart';
import 'package:flutter/widgets.dart';

class HeadingText extends StatelessWidget {
  const HeadingText(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: kHeading6,
    );
  }
}
