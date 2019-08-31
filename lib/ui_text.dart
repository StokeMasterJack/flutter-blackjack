import 'package:flutter/material.dart' hide Card;

import 'blackjack.dart';
import 'ui_common.dart';

const title = 'Flutter Blackjack';

class GameView extends StatelessWidget {
  final BjModel model;

  GameView(this.model);

  static Widget mk(BjModel m) => GameView(m);

  @override
  Widget build(BuildContext context) {
    Game g = model.g;

    var mainCol =
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      SizedBox(height: 30.0),
      ButtonsView(
        isGameOver: g.isGameOver,
        onDeal: model.onDeal,
        onHit: model.onHit,
        onStay: model.onStay,
      ),
      SizedBox(height: 30.0),
      Expanded(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            HandView(g.ph),
            HandView(g.dh),
          ])),
      SizedBox(height: 40.0),
      MsgView(g.msg)
    ]);

    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      constraints: BoxConstraints(maxHeight: 340.00),
      child: mainCol,
    );
  }
}

class HandView extends StatelessWidget {
  final Hand hand;

  HandView(this.hand);

  @override
  Widget build(BuildContext context) {

    final pointsTheme = Theme.of(context).textTheme.body1.copyWith(
        color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold);

    double rMargin = hand.isDealer ? 0.0 : 8.0;
    double lMargin = hand.isDealer ? 8.0 : 0.0;

    return Expanded(
        child: Container(
            decoration: BoxDecoration(
//                color: Colors.black12,
                color: Theme.of(context).selectedRowColor,
                borderRadius: BorderRadius.circular(4.0)),
            margin: EdgeInsets.fromLTRB(lMargin, 0.0, rMargin, 8.0),
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Text(hand.name + " Hand",
                        style: pointsTheme),
                  ),
                  buildCardsView1(context, hand.cards),
                  Text(hand.points.toString() + " points",
                      style: pointsTheme),
                ])));
  }

  Widget buildCardsView1(BuildContext context, List<Card> cards) {
    return Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: hand.cards
                .map((Card c) =>
                    Text(c.name, style: Theme.of(context).textTheme.body1))
                .toList()));
  }
}
