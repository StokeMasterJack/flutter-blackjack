import 'package:blackjack/blackjack.dart';
//import 'package:flutter_test/flutter_test.dart';
import 'package:test/test.dart';
//import 'package:matcher/matcher.dart';

void main() {
  Game.skipShuffleForTesting = true;

  test('Card test', () {
    var c1 = Card(value: 1, suit: 1);
    var c2 = Card(value: 13, suit: 4);

    expect(c1.value, 1);
    expect(c1.suit, 1);
    expect(c1.suitName, "Spades");
    expect(c1.valueName, "Ace");
    expect(c1.name, "Ace of Spades");
    expect(c1.points, 1);

    expect(c2.value, 13);
    expect(c2.suit, 4);
    expect(c2.suitName, "Diamonds");
    expect(c2.valueName, "King");
    expect(c2.name, "King of Diamonds");
    expect(c2.points, 10);

    expect(() => new Card(value: 1, suit: 5),
        throwsA(TypeMatcher<AssertionError>()));
    expect(() => new Card(value: 14, suit: 1),
        throwsA(TypeMatcher<AssertionError>()));
  });

  test('Hand test', () {
    var h1 = Hand(isDealer: false);
    h1.add(Card(value: 1, suit: 1));
    h1.add(Card(value: 13, suit: 4));

    var h2 = Hand(isDealer: true);
    h2.add(Card(value: 1, suit: 1));
    h2.add(Card(value: 2, suit: 1));
    h2.add(Card(value: 3, suit: 1));

    expect(h1.name, "Player");
    expect(h1.points, 11);
    expect(h1.size, 2);

    expect(h2.name, "Dealer");
    expect(h2.points, 6);
    expect(h2.size, 3);

    h1.dump();
    h2.dump();
  });

  test('Deck test', () {
    var d1 = Deck.clean();
    expect(d1.size, 52);

    var c1 = d1.take();
    expect(c1.name, "Ace of Spades");
    expect(d1.size, 51);

    var c2 = d1.take();
    expect(c2.name, "2 of Spades");
    expect(d1.size, 50);

    d1.dump();
  });

  test('Game test', () {
    var g = new Game();
    expect(g.deck.size, 48);
    expect(g.ph.size, 2);
    expect(g.dh.size, 2);
    expect(g.ph.points, 4);
    expect(g.dh.points, 6);
    expect(g.isGameOver, false);
    expect(g.msg, "Press Hit or Stay");

    g.hit();
    expect(g.deck.size, 47);
    expect(g.ph.size, 3);
    expect(g.dh.size, 2);
    expect(g.ph.points, 9);
    expect(g.dh.points, 6);
    expect(g.isGameOver, false);
    expect(g.msg, "Press Hit or Stay");

    g.hit();
    expect(g.deck.size, 46);
    expect(g.ph.size, 4);
    expect(g.dh.size, 2);
    expect(g.ph.points, 15);
    expect(g.dh.points, 6);
    expect(g.isGameOver, false);
    expect(g.msg, "Press Hit or Stay");

    g.stay();
    expect(g.deck.size, 44);
    expect(g.ph.size, 4);
    expect(g.dh.size, 4);
    expect(g.ph.points, 15);
    expect(g.dh.points, 21);
    expect(g.isGameOver, true);
    expect(g.msg, "Dealer Wins!");

    g.deal();
    expect(g.deck.size, 40);
    expect(g.ph.size, 2);
    expect(g.dh.size, 2);
    expect(g.ph.points, 19);
    expect(g.dh.points, 20);
    expect(g.isGameOver, false);
    expect(g.msg, "Press Hit or Stay");

    g.hit();
    expect(g.ph.points, 29);
    expect(g.isGameOver, true);
    expect(g.msg, "Dealer Wins!");

    g.deal();
    g.deal();
    g.hit();
    g.stay();
    expect(g.isGameOver, true);
    expect(g.msg, "Player Wins!");

    print("");
    print("");
    g.dump();
  });
}
