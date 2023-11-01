import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Text text styles and theme', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: Scaffold(
          body: Column(
            children: [
              Text('Heading 5', style: kHeading5),
              Text('Heading 6', style: kHeading6),
              Text('Subtitle', style: kSubtitle),
              Text('Body Text', style: kBodyText),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Heading 5'), findsOneWidget);
    expect(find.text('Heading 6'), findsOneWidget);
    expect(find.text('Subtitle'), findsOneWidget);
    expect(find.text('Body Text'), findsOneWidget);

    expect(
        tester.widget<Text>(find.text('Heading 5')).style, equals(kHeading5));
    expect(
        tester.widget<Text>(find.text('Heading 6')).style, equals(kHeading6));
    expect(tester.widget<Text>(find.text('Subtitle')).style, equals(kSubtitle));
    expect(
        tester.widget<Text>(find.text('Body Text')).style, equals(kBodyText));
  });
}
