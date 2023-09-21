import 'package:flutter/widgets.dart';
import 'package:movie_tv/common/constants.dart';

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