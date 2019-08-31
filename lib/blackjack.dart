class Card {
  final int value, suit;

  Card({this.value, this.suit})
      : assert(value >= 0 && value <= 13),
        assert(suit >= 0 && suit <= 4);

  String get suitName {
    switch (suit) {
      case 1:
        return "Spades";
      case 2:
        return "Hearts";
      case 3:
        return "Clubs";
      case 4:
        return "Diamonds";
      default:
        throw StateError("Bad suit $suit");
    }
  }

  String get valueName {
    if (value == 1) return "Ace";
    if (value >= 2 && value <= 10) return value.toString();
    if (value == 11) return "Jack";
    if (value == 12) return "Queen";
    if (value == 13) return "King";
    throw StateError("Bad value $value");
  }

  String get name => "$valueName of $suitName";

  int get points {
    if (value >= 1 && value <= 10) return value;
    if (value >= 11 && value <= 13) return 10;
    throw StateError("Bad value $value");
  }

  String get imageName {
    String vChar = value != 10 ? valueName[0] : "t";
    String sChar = suitName[0];
    return "$vChar$sChar.gif".toLowerCase();
  }
}

class Hand {
  final bool isDealer;
  final List<Card> cards;

  Hand({this.isDealer, List<Card> cards})
      : this.cards = cards == null ? [] : cards;

  Hand.player() : this(isDealer: true);

  Hand.dealer() : this(isDealer: false);

  String get name => isDealer ? "Dealer" : "Player";

  void add(Card card) {
    cards.add(card);
  }

  int get points => cards.fold(0, (prev, cur) => prev + cur.points);

  int get size => cards.length;

  void dump() {
    print("  $name Hand");
    for (Card c in cards) {
      print("    ${c.name}");
    }
    print("    $points points");
  }

  Hand copy() {
    final copy = List<Card>();
    copy.addAll(this.cards);
    return Hand(isDealer: isDealer, cards: copy);
  }
}

class Deck {
  static bool skipShuffleForTesting = false;

  final List<Card> cards;
  int nextCard;

  Deck._(this.cards, this.nextCard) : assert(nextCard < cards.length);

  Deck.shuffle() : this.init(true);

  Deck.clean() : this.init(false);

  Deck.init(bool shuffle)
      : cards = _createCards(shuffle),
        nextCard = 0;

  static List<Card> _createCards(bool shuffle) {
    final a = <Card>[];
    for (int s = 1; s <= 4; s++) {
      for (int v = 1; v <= 13; v++) {
        a.add(Card(value: v, suit: s));
      }
    }
    if (shuffle && !skipShuffleForTesting) a.shuffle();
    return List.unmodifiable(a);
  }

  int get size => cards.length - nextCard;

  Card take() {
    final Card ret = cards[nextCard];
    nextCard++;
    return ret;
  }

  void dump() {
    print("Deck:");
    for (var c in cards) {
      print("  ${c.name}");
    }
  }

  Deck copy() {
    return Deck._(cards, nextCard);
  }
}

class Game {
  Deck deck;
  Hand ph = Hand.player();
  Hand dh = Hand.dealer();
  bool isStay = false;

  static set skipShuffleForTesting(bool b) {
    Deck.skipShuffleForTesting = b;
  }

  Game() {
    deck = Deck.shuffle();
    deal();
  }

  Game._copy(Game g)
      : deck = g.deck.copy(),
        ph = g.ph.copy(),
        dh = g.dh.copy(),
        isStay = g.isStay;

  void deal() {
    if (deck.size < 30) deck = Deck.shuffle();
    ph = Hand(isDealer: false);
    dh = Hand(isDealer: true);
    ph.add(deck.take());
    dh.add(deck.take());
    ph.add(deck.take());
    dh.add(deck.take());
    isStay = false;
  }

  void hit() {
    if (deck.size < 30) deck = Deck.shuffle();
    ph.add(deck.take());
  }

  void stay() {
    if (deck.size < 30) deck = Deck.shuffle();
    while (dh.points < 17) dh.add(deck.take());
    isStay = true;
  }

  void dump() {
    print("Blackjack");
    ph.dump();
    print("");
    dh.dump();
    print("");
  }

  bool get isGameOver => isStay || ph.points > 21;

  String get msg {
    if (!isGameOver) return "Press Hit or Stay";
    if (ph.points > 21) return "Dealer Wins!";
    if (dh.points > 21) return "Player Wins!";
    if (ph.points == dh.points) return "Tie";
    if (ph.points > dh.points) return "Player Wins!";
    if (dh.points > ph.points) return "Dealer Wins!";
    throw Exception();
  }

  Game copy() {
    return Game._copy(this);
  }
}
