import 'package:blackjack/app.dart';
import 'package:blackjack/blackjack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {
  Game.skipShuffleForTesting = true;

  testHomePage();
  testGamePage("UI 1");
  testGamePage("UI 2");

}

void testHomePage(){
  testWidgets('Home Page', (WidgetTester tester) async {
    await tester.pumpWidget(new App());
    expect(find.widgetWithText(AppBar,'Flutter Blackjack'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(buttonWithText('PLAY GAME - UI 1'), findsOneWidget);
    expect(buttonWithText('PLAY GAME - UI 2'), findsOneWidget);
  });
}

void testGamePage(String suffix){
  testWidgets('UI Game ${suffix}', (WidgetTester tester) async {
    await tester.pumpWidget(new App());

    await tester.tap(find.text('PLAY GAME - ${suffix}'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar,"Blackjack - $suffix"), findsOneWidget);
    expect(buttonWithText('Hit'), findsOneWidget);
    expect(buttonWithText('Stay'), findsOneWidget);
    expect(buttonWithText('Deal'), findsOneWidget);

    expect(find.text('4 points'), findsOneWidget);
    expect(find.text('6 points'), findsOneWidget);
    expect(find.text('PRESS HIT OR STAY'), findsOneWidget);

    await tester.tap(buttonWithText("Hit"));
    await tester.pumpAndSettle();
    expect(find.text('9 points'), findsOneWidget);
    expect(find.text('6 points'), findsOneWidget);
    expect(find.text('PRESS HIT OR STAY'), findsOneWidget);

    await tester.tap(buttonWithText("Stay"));
    await tester.pumpAndSettle();
    expect(find.text('9 points'), findsOneWidget);
    expect(find.text('19 points'), findsOneWidget);
    expect(find.text('DEALER WINS!'), findsOneWidget);


  });
}

/**
 * @return true if w is a Button with child of type Text containing text (or any text if text is null)
 */
bool isButton(Widget w, String text) {
  bool isButton = w is MaterialButton || w is CupertinoButton;
  if (!isButton) return false;

  Widget childOrNull;
  if (w is MaterialButton) {
    childOrNull = w.child;
  } else if (w is CupertinoButton) {
    childOrNull = w.child;
  } else {
    return false;
  }

  if (childOrNull != null && childOrNull is Text && childOrNull.data != null) {
    if (text == null) return true;
    final outer = childOrNull.data.toLowerCase();
    final inner = text.toLowerCase();
    return outer.contains(inner);
  } else {
    return false;
  }
}

Finder buttonWithText(String s) => find.byWidgetPredicate((w) => isButton(w, s));
