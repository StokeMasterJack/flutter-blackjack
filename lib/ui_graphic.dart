import 'package:flutter/material.dart' hide Card;

import 'blackjack.dart';
import 'ui_common.dart';

class GGameView extends StatelessWidget {
  final BjModel model;

  GGameView(this.model);

  static Widget mk(BjModel m) => GGameView(m);

  @override
  Widget build(BuildContext context) {
    Game g = model.g;

    var handsColumn = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GHandView(g.ph),
          SizedBox(height: 30.0),
          GHandView(g.dh),
        ]);

    var mainCol = Column(children: <Widget>[
      SizedBox(height: 30.0),
      ButtonsView(
          isGameOver: g.isGameOver,
          onDeal: model.onDeal,
          onHit: model.onHit,
          onStay: model.onStay),
      SizedBox(height: 30.0),
      handsColumn,
      SizedBox(height: 50.0),
      MsgView(g.msg)
    ]);

    final gameContainer =
        Container(child: mainCol, padding: EdgeInsets.all(10.0));
    final scroll = SingleChildScrollView(
      child: gameContainer,
      scrollDirection: Axis.vertical,
    );

    return scroll;
  }
}

class GHandView extends StatelessWidget {
  final Hand hand;

  GHandView(this.hand);

  @override
  Widget build(BuildContext context) {
    final pointsTheme = Theme.of(context).textTheme.body1.copyWith(
        color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold);
    Widget gw = Container(
        margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
        decoration: BoxDecoration(
            color: Theme.of(context).selectedRowColor,
            borderRadius: BorderRadius.circular(4.0)),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(hand.name + " Hand", style: pointsTheme),
              ),
              mkCardsView(hand.cards),
              Text(hand.points.toString() + " points", style: pointsTheme),
            ]));

    return gw;
  }

  Widget mkCardsView(List<Card> cards) {
    List<Widget> children = <Widget>[];
    for (Card card in cards) {
      var cardView = mkCardView(card);
      children.add(cardView);
    }
    ListView listView =
        ListView(scrollDirection: Axis.horizontal, children: children);

    Container c = Container(
      child: listView,
      height: 80.0,
    );

    return c;
  }

  Widget mkCardView(Card card) {
    String path = "images/cards/${card.imageName}";
    var image = Image.asset(path);
    return Padding(
        padding: EdgeInsets.only(right: 8.0, bottom: 4.0), child: image);
  }
}
